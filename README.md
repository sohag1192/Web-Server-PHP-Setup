

---

## ✅ Web Server & PHP Setup
1. **Install essentials**
   ```bash
   sudo apt update
   sudo apt install -y curl apache2 unzip
   sudo apt install -y php php-cli php-common php-curl php-mbstring php-xml php-mysql php-zip php-gd
   ```

2. **Enable Apache modules**
   ```bash
   sudo a2enmod rewrite headers mime
   sudo systemctl restart apache2
   ```

---

## 📂 Deploy Your App
1. **Unzip into web root**
   ```bash
   sudo unzip v2.zip -d /var/www/html/
   ```

2. **Set permissions**
   ```bash
   sudo chown -R www-data:www-data /var/www/html
   sudo find /var/www/html -type f -exec chmod 644 {} \;
   sudo find /var/www/html -type d -exec chmod 755 {} \;
   ```

---

## 🔄 Automating Updates
You’ve tried both **cron** and **systemd timers**. Pick one for clarity:

### Option A: Cron
Edit crontab:
```bash
* * * * * php /var/www/html/v2/update.php > /dev/null 2>&1
```

### Option B: Systemd Timer (cleaner)
1. **Service file** (`/etc/systemd/system/v2-update.service`)
   ```ini
   [Unit]
   Description=Run v2 cache update

   [Service]
   Type=oneshot
   ExecStart=/usr/bin/php /var/www/html/v2/update.php
   ```

2. **Timer file** (`/etc/systemd/system/v2-update.timer`)
   ```ini
   [Unit]
   Description=Run v2 cache update every minute

   [Timer]
   OnCalendar=*:0/1
   Persistent=true

   [Install]
   WantedBy=timers.target
   ```

3. **Enable & start**
   ```bash
   sudo systemctl daemon-reexec
   sudo systemctl enable --now v2-update.timer
   sudo systemctl status v2-update.timer
   ```

---

## 🛠️ Debugging
- Check Apache logs:
  ```bash
  sudo tail -f /var/log/apache2/error.log
  ```
- Check systemd logs:
  ```bash
  sudo journalctl -u v2-update.service -f
  ```
  
## 🛠️Manual PHP Debugging
- Check php file :

  ```bash
  php /var/www/html/v2/update.php
---


