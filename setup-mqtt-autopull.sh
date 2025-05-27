#!/bin/bash

set -e

REPO_URL="https://github.com/Rosenweg/MQTT-Broker.git"
TARGET_DIR="/opt/docker/mqtt"

echo "📦 Klone oder aktualisiere Repository..."
if [ -d "$TARGET_DIR/.git" ]; then
  cd "$TARGET_DIR"
  git pull --rebase
else
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

# Cloudflare credentials setup (only if not exist)
if [ ! -f certbot/cloudflare.ini ]; then
  echo "🔐 Bitte Cloudflare API Token eintragen:"
  read -s -p "API Token: " TOKEN
  mkdir -p certbot
  echo "dns_cloudflare_api_token = $TOKEN" > certbot/cloudflare.ini
  chmod 600 certbot/cloudflare.ini
  echo
fi

# Passwort-Datei initialisieren, falls nicht vorhanden
if [ ! -f auth/passwd ]; then
  mkdir -p auth
  echo "⚙️  Lege Mosquitto-Benutzer an:"
  read -p "Benutzername: " USERNAME
  read -s -p "Passwort: " PASSWORD
  echo
  mosquitto_passwd -b auth/passwd "$USERNAME" "$PASSWORD"
fi

echo "🚀 Starte Docker Compose..."
docker-compose pull
docker-compose up -d

echo "✅ Fertig. MQTT läuft jetzt unter /opt/docker/mqtt"
