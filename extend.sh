#!/bin/bash

# Artık set -euo pipefail yok, CLI çıktısı açık

BACKUP_DIR="/tmp/full_backup_$(date +%Y%m%d_%H%M%S)"
YEDENECIKTI="$BACKUP_DIR.tar.gz"

log() {
    echo -e "\e[1;32m[+] $*\e[0m"
}

err() {
    echo -e "\e[1;31m[ERROR]\e[0m $*" >&2
    exit 1
}

check_root() {
    [[ $EUID -ne 0 ]] && err "Bu script root olarak çalıştırılmalıdır."
}

# Kullanıcıdan SSH bilgilerini al
echo -e "\n=== Yedekleme için hedef sunucu bilgilerini girin ==="
read -rp "📥 Kullanıcı adı (örnek: root): " REMOTE_USER
read -rp "🌐 Uzak sunucu (IP/hostname): " REMOTE_HOST
read -rp "📁 Uzak dizin (örnek: /mnt/yedekler): " REMOTE_PATH

# Kullanıcıdan transfer yöntemi sor
echo -e "\n=== Yedekleme transfer yöntemi seçin ==="
echo "1: SCP"
echo "2: rsync"
echo "3: FTP"
read -rp "Seçiminizi yapın (1/2/3): " TRANSFER_METHOD

# Yedekleme işlemi
backup_entire_system() {
    log "📦 Tüm sistemin yedeği alınıyor..."
    mkdir -p "$(dirname "$YEDENECIKTI")"

    # Yedekleme işlemi
    tar --exclude=/proc \
        --exclude=/sys \
        --exclude=/dev \
        --exclude=/tmp \
        --exclude=/run \
        --exclude=/mnt \
        --exclude=/media \
        --exclude=/lost+found \
        -czf "$YEDENECIKTI" /

    if [[ ! -f "$YEDENECIKTI" ]]; then
        err "Yedekleme başarısız oldu!"
    fi

    log "✅ Yedekleme tamamlandı!"
}

# FTP transfer fonksiyonu
ftp_transfer() {
    log "📤 FTP ile yedek aktarılıyor..."
    ftp -inv "$REMOTE_HOST" <<EOF
user $REMOTE_USER
binary
put "$YEDENECIKTI" "$REMOTE_PATH/$(basename "$YEDENECIKTI")"
bye
EOF
    log "✅ FTP transferi tamamlandı!"
}

# SCP transfer fonksiyonu (Manuel şifre girişi ile)
scp_transfer() {
    log "📤 SCP ile yedek aktarılıyor..."
    # SCP komutunu manuel şifre girişi ile çalıştırıyoruz
    scp -v "$YEDENECIKTI" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
    if [ $? -eq 0 ]; then
        log "✅ SCP transferi tamamlandı!"
    else
        err "🛑 SCP transferi başarısız oldu!"
    fi
}

# rsync transfer fonksiyonu (Manuel şifre girişi ile)
rsync_transfer() {
    log "📤 rsync ile yedek aktarılıyor..."
    # rsync komutunu manuel şifre girişi ile çalıştırıyoruz
    rsync -avz --progress "$YEDENECIKTI" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
    if [ $? -eq 0 ]; then
        log "✅ rsync transferi tamamlandı!"
    else
        err "🛑 rsync transferi başarısız oldu!"
    fi
}

# Kullanıcı onayı al
kullanici_onayi() {
    read -rp "Yedek başarıyla alındı. Devam edip diski genişletmek istiyor musunuz? [y/N]: " onay
    [[ "$onay" != "y" && "$onay" != "Y" ]] && {
        log "🛑 İşlem iptal edildi."
        exit 0
    }
}

# LVM kontrolü
is_lvm() {
    [[ "$(findmnt / -o SOURCE -n)" == /dev/mapper/* ]]
}

# LVM genişletme işlemi
extend_lvm() {
    log "📦 LVM sistemi genişletiliyor..."

    VG=$(vgs --noheadings -o vg_name | xargs)
    LV=$(lvs --noheadings -o lv_name | grep -v swap | xargs)
    LV_PATH="/dev/$VG/$LV"

    NEW_DISK=$(lsblk -dpno NAME | grep -v "$(pvs | awk '{print $1}')" | grep -v "loop" | head -n1)
    [[ -z "$NEW_DISK" ]] && err "🛑 Boş disk bulunamadı!"

    pvcreate "$NEW_DISK"
    vgextend "$VG" "$NEW_DISK"
    lvextend -l +100%FREE "$LV_PATH"

    FS_TYPE=$(df -T / | awk 'NR==2 {print $2}')
    [[ "$FS_TYPE" == "xfs" ]] && xfs_growfs / || resize2fs "$LV_PATH"

    log "✅ LVM genişletildi."
}

# Bölümlü sistem genişletme işlemi
extend_non_lvm() {
    log "📦 Bölümlü sistem genişletiliyor..."

    ROOT_PART=$(findmnt / -o SOURCE -n)
    DISK="/dev/$(lsblk -no pkname "$ROOT_PART")"

    parted "$DISK" resizepart 1 100% <<EOF
Yes
EOF

    partprobe "$DISK"
    sleep 2

    FS_TYPE=$(df -T / | awk 'NR==2 {print $2}')
    [[ "$FS_TYPE" == "xfs" ]] && xfs_growfs / || resize2fs "$ROOT_PART"

    log "✅ Disk bölümü genişletildi."
}

# Ana fonksiyon
main() {
    check_root
    backup_entire_system
    kullanici_onayi

    # Seçilen transfer metoduna göre işlemi yönlendir
    case "$TRANSFER_METHOD" in
        1)
            scp_transfer
            ;;
        2)
            rsync_transfer
            ;;
        3)
            ftp_transfer
            ;;
        *)
            err "Geçersiz seçenek! Lütfen 1, 2 veya 3'ü seçin."
            ;;
    esac

    log "✅ Yedek başarıyla alındı ve aktarım tamamlandı."

    # Disk genişletme işlemi
    if is_lvm; then
        extend_lvm
    else
        extend_non_lvm
    fi

    log "🎉 Tüm işlem başarıyla tamamlandı."
}

# Script başlatma
main
