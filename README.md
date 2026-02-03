# Auto Restart Webserver Httpd (Apache) Service (cPanel) + Discord Webhook

A lightweight script to automatically restart the **Apache Httpd** service on **cPanel servers**.  
The script sends **alerts to Discord via webhook** before, during, and after the restart process.

---

## Features
- Auto restart Apache Httpd
- Pre-restart alert (1 minute before)
- Discord webhook notifications (before, during, after)
- Cron-based scheduled execution
- Lightweight & fully compatible with cPanel

---

## Requirements
- cPanel server (root / sudo access)
- Apache Webserver (Httpd)
- curl
- Discord webhook URL

---

## Installation
```bash
git clone https://github.com/aldinowildhanku/alerting-auto-restart-webserver.git
cd auto-restart-httpd-cpanel
chmod +x restart_httpd.sh
