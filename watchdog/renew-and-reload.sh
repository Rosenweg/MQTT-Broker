#!/bin/sh

echo "🔄 Starte Certbot-Renew..."
certbot renew --dns-cloudflare --dns-cloudflare-credentials /cloudflare.ini --quiet

if [ $? -eq 0 ]; then
  echo "✅ Zertifikat erfolgreich erneuert. Mosquitto wird neu gestartet..."
  docker restart mosquitto
else
  echo "⚠️  Zertifikat nicht erneuert – Mosquitto bleibt wie er ist."
fi
