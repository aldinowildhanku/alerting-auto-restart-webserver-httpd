#!/bin/bash

WEBHOOK_URL="https://discord.com/api/webhooks/??????"  # Ganti dengan webhook Discord kamu
ALERT_VERSION="v1.1"
SERVER_NAME=$(hostname)

send_discord_embed() {
    local TITLE="$1"
    local DESCRIPTION="$2"
    local COLOR="$3"

    curl -H "Content-Type: application/json" \
        -X POST \
        -d "{
            \"embeds\": [{
                \"title\": \"$TITLE\",
                \"description\": \"$DESCRIPTION\",
                \"color\": $COLOR,
                \"footer\": { \"text\": \"Alerting restart webserver $ALERT_VERSION\" },
                \"timestamp\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"
            }]
        }" \
        "$WEBHOOK_URL" >/dev/null 2>&1
}

echo "⚠️ Mengirim alert H-1 menit..."
send_discord_embed \
    "⚠️ Restart Webserver Httpd Terjadwal - $SERVER_NAME" \
    "Restart Httpd akan dilakukan dalam **1 menit**.\nServer: **$SERVER_NAME**" \
    15105570

sleep 60

echo "🔄 Mengirim alert: Proses restart sedang berjalan..."
send_discord_embed \
    "🔄 Proses Restart Webserver Httpd" \
    "Restart Webserver Httpd sedang berjalan...\nServer: **$SERVER_NAME**" \
    3447003

echo "⏳ Menjalankan restart Webserver Httpd..."
/scripts/restartsrv_httpd --hard
STATUS_RESTART=$?

if [ $STATUS_RESTART -eq 0 ]; then
    echo "✅ Restart Webserver Httpd selesai."
    send_discord_embed \
        "✅ Restart Webserver Sudah Selesai - $SERVER_NAME" \
        "Restart Webserver berhasil.\nStatus: **SUKSES**" \
        3066993
else
    echo "❌ Restart Webserver Httpd gagal! Exit code: $STATUS_RESTART"
    send_discord_embed \
        "❌ Restart Webserver Gagal - $SERVER_NAME" \
        "Terjadi error saat restart Webserver.\nExit Code: $STATUS_RESTART" \
        15158332
fi
