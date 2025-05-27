# MQTT Docker mit Let's Encrypt (Cloudflare DNS Challenge)

## Features

- Mosquitto mit TLS (8883)
- WebSocket über TLS (8084)
- WebSocket ohne TLS (8083), anonym, nur Leserechte auf `public/#`
- Let's Encrypt Zertifikate über Cloudflare DNS
- Automatische Erneuerung & Mosquitto-Neustart

## Schnellstart

```bash
git clone https://github.com/deinuser/mqtt-docker-letsencrypt.git
cd mqtt-docker-letsencrypt

# Passe cloudflare.ini und deine Domain an, dann:
docker-compose up -d
```
