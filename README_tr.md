# 📦 AutoBackup & Disk Extender

**AutoBackup & Disk Extender**, Linux sistemler için etkileşimli bir Bash betiğidir.  
Bu betik, sisteminizi yedekler ve disk genişletme işlemlerini otomatik olarak gerçekleştirir.

---

## 🚀 Özellikler

- 📦 Tüm sistemin yedeğini `.tar.gz` olarak oluşturur
- 🔒 Yedekleri SCP, FTP veya rsync ile uzak bir sunucuya aktarır
- 💬 Kullanıcı onayı ister, işlemler boyunca rehberlik eder
- ⚙️ LVM ve standart disk bölümlerini algılar ve genişletir
- 🌈 Renkli CLI çıktısı, emojiler ve okunabilir log mesajları içerir
- 🔐 SSH anahtarı veya `sshpass` gerekmez – şifreli doğrulama desteklenir

---

## 💡 Kullanım Senaryoları

- Sunucu yükseltmeleri öncesi tam yedek alma
- Yeni disk ekledikten sonra otomatik genişletme
- Bulut/VM ortamlarında düşük riskli disk yönetimi
- Otomatik yedekleme sistemlerine entegrasyon

---

## ⚙️ Gereksinimler

- `tar`, `scp`, `rsync`, `ftp`, `parted`, `lvm2`
- root ayrıcalıkları
- Hedef sunucuda kullanıcı adı ve şifresi ile bağlantı izni

---

## 🧪 Nasıl Kullanılır?

```bash
chmod +x extend.sh
sudo ./extend.sh
```

Script sizi sırasıyla şunlar için yönlendirecektir:

1. Uzak sunucu bilgileri (kullanıcı adı, IP, dizin)
2. Aktarım yöntemi seçimi (SCP, rsync, FTP)
3. Tüm sistemin yedeği alınır
4. Yedek aktarılır
5. Disk tipi algılanır (LVM / standart)
6. Disk genişletme yapılır

---

## 📤 Desteklenen Aktarım Yöntemleri

| Yöntem | Açıklama |
|--------|----------|
| `SCP`  | Basit ve güvenli dosya aktarımı |
| `rsync` | Hızlı ve fark tabanlı aktarım |
| `FTP`  | Klasik yöntem (şifreli değilse dikkatli kullanın) |

---

## 📁 Dosya Konumu

Yedekler `/tmp` altında zaman damgalı dosya olarak oluşturulur:

```
/tmp/full_backup_YYYYMMDD_HHMMSS.tar.gz
```

---

## 🔐 Güvenlik Notları

- Yedekleme öncesinde kullanıcıdan açık onay alınır
- `tar` işlemi sistemin sadece güvenli bölümlerini yedekler
- Şifre ile oturum açma desteklenir (anahtarsız)
- `sshpass` veya özel kurulumlara ihtiyaç yoktur

---

## 🧾 Lisans

MIT Lisansı – açık kaynak, özgürce kullanılabilir ve düzenlenebilir.

---

## 🤝 Katkı Sağlayın

Pull request ve issue’larınızı memnuniyetle bekliyoruz!  
Geliştirme, yeni özellik önerileri veya hata bildirimleri için katkı sağlayabilirsiniz.

---

> Geliştirici: [cagrisaltik]  
> Script: `extend.sh`  
> Sürüm: v1.0  
> Durum: 🚀 Kararlı (Stable)
