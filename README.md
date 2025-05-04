# 🧹 AutoBackup & Disk Extender Script for Linux

A powerful and interactive Bash script to **automatically back up** your entire Linux system and **extend the disk**—whether it's LVM or a traditional partition-based setup.

> 🔐 Supports password-based SCP, Rsync, and FTP transfer methods.
> 🧠 Smart detection of LVM and non-LVM environments.
> 🎨 Stylish CLI output with emoji and colored logs.

---

## 📌 Features

* 📆 Full system backup (excluding virtual/mounted dirs)
* 🔀 Transfer backups to remote servers via:

  * SCP (with password prompt)
  * Rsync (with password prompt)
  * FTP
* 🧠 Auto-detect if system uses LVM or regular partitions
* 🔧 Automatically resize disk and file system accordingly
* ✅ User confirmation before extending the disk
* 💬 Interactive prompts and user-friendly CLI

---

## 💻 Requirements

* Linux (tested on Ubuntu/Debian/CentOS)
* `tar`, `scp`, `rsync`, `ftp`, `parted`, `lvm2` tools installed
* Remote server with reachable credentials and disk space

> ❗ No SSH key or `sshpass` is required — password prompts are handled natively.

---

## 🚀 How to Use

1. **Clone this repo:**

```bash
git clone https://github.com/cagrisaltik/linux-disk-autoextend.git
cd linux-disk-autoextend
```

2. **Make the script executable:**

```bash
chmod +x extend.sh
```

3. **Run the script as root:**

```bash
sudo ./extend.sh
```

4. **Follow the on-screen prompts:**

   * Enter remote server credentials
   * Choose a transfer method (SCP, Rsync, FTP)
   * Wait for backup to complete and confirm to proceed
   * Let the script handle disk extension automatically 🚀

---

## 📁 What It Backs Up

* The **entire system**, excluding:

  * `/proc`, `/sys`, `/dev`, `/run`, `/tmp`, `/mnt`, `/media`, and `/lost+found`

Backups are stored as a compressed `.tar.gz` file in `/tmp` and then transferred.

---

## 📊 Disk Extension Behavior

* **LVM Detected**:

  * Creates PV on free disk
  * Extends VG and LV
  * Resizes filesystem (`xfs_growfs` or `resize2fs`)

* **Non-LVM Partition**:

  * Automatically resizes the root partition via `parted`
  * Expands filesystem accordingly

---

## 🧪 Example Output

```bash
📆 Creating full system backup...
✅ Backup complete!
📤 SCP transfer started...
✅ Transfer completed!
📆 Extending LVM volume...
✅ Disk extended!
🎉 All operations completed successfully.
```

---

## 📌 Notes

* This script modifies disk partitions — **use at your own risk** and test in a safe environment first.
* Ensure your remote server has enough storage for backups.
* Root privileges are required for disk operations.

---

## 📜 License

MIT © 2025 — [Çağrı Saltık](https://github.com/cagrisaltik)
