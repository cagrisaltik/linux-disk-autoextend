## 📢 Genel Yayın: AutoBackup & Disk Extender v1.0

Linux sistemleri için geliştirdiğimiz AutoBackup & Disk Extender aracının ilk genel sürümünü duyurmaktan mutluluk duyuyoruz!
Bu interaktif Bash betiği, tam sistem yedekleme ve disk genişletme işlemlerini tek adımda ve güvenli bir şekilde otomatikleştirir.

***



🧰 Bu Nedir?

Bu betik sayesinde şunları zahmetsizce yapabilirsiniz:

📦 Linux sisteminizin tamamını .tar.gz formatında sıkıştırılmış bir arşiv olarak yedekleyin (dinamik veya geçici dizinler otomatik olarak hariç tutulur).

🚀 Kök dosya sisteminizi otomatik olarak genişletin. LVM kullanımı varsa algılanır ve uygun adımlar uygulanır.

📤 Yedekleri uzak bir sunucuya güvenli bir şekilde aktarın. SCP, rsync veya FTP yöntemlerinden birini seçebilirsiniz.
🔐 SSH anahtarı veya sshpass gerektirmez — kullanıcı adı ve şifre ile işlem yapılır.

***



🔑 Öne Çıkan Özellikler

🧠 Akıllı disk yapı algılaması (LVM olup olmadığını belirler)

💬 Kullanıcıdan onay alan etkileşimli komut satırı (CLI) arayüzü

🌈 Emoji destekli, renkli ve okunabilir terminal çıktısı

🔐 Şifre ile güvenli aktarım yöntemleri

⚙️ Sadece yerleşik Linux araçlarını kullanır (tar, scp, rsync, ftp, parted, lvm2 vs.)

⚠️ Hatalar için gelişmiş kontrol ve kullanıcıya geri bildirim mekanizması

⏱️ Tüm yedekler zaman damgalı olarak /tmp klasörüne alınır

***



💡 Kullanım Senaryoları

Sistem güncellemesi öncesi tam yedekleme

Bulut tabanlı VM’lerde disk genişletme öncesi koruma

Haftalık yedekleme otomasyonları

Disk operasyonları öncesinde hızlı snapshot oluşturma

***



📦 Desteklenen Aktarım Yöntemleri

Yedekleme tamamlandığında aşağıdaki 3 aktarım yöntemi arasından seçim yapabilirsiniz:

1️⃣ SCP – Basit ve güvenli

2️⃣ rsync – Hızlı, fark tabanlı ve verimli

3️⃣ FTP – Klasik yöntem (açık ağlarda önerilmez)

Script, uzak sunucu kullanıcı adı ve şifresini sizden ister ve bağlantıyı sağlar.

***



🚨 Güvenlik ve Uyarılar

✔️ Kullanıcının onayı olmadan hiçbir işlem yapılmaz
✔️ Kritik sistem dizinleri asla yedeklenmez veya değiştirilmez
✔️ Tüm işlem adımları açıkça loglanır ve kullanıcıya gösterilir
❗ Ancak: Bu script disk üzerinde gerçek değişiklikler yapar — üretim ortamlarında kullanmadan önce test ortamında mutlaka deneyin.

***



📁 Depo ve Belgeler

📚 Kurulum, kullanım ve katkı yönergeleri için README.md dosyasına göz atabilirsiniz.

***



🛡️ Lisans

MIT — özgürce kullanabilir, düzenleyebilir ve paylaşabilirsiniz.

Bu araç, Linux sistem yönetimini daha hızlı, güvenli ve kullanıcı dostu hale getirmek için geliştirildi.
Geri bildirimlerinizi ve katkılarınızı memnuniyetle karşılarız! 🙌

