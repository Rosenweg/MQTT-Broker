# MQTT Docker mit Let's Encrypt (Cloudflare DNS Challenge)

## Features

- Mosquitto mit TLS (8883)
- WebSocket über TLS (8084)
- WebSocket ohne TLS (8083), anonym, nur Leserechte auf `public/#`
- Let's Encrypt Zertifikate über Cloudflare DNS
- Automatische Erneuerung & Mosquitto-Neustart

## Schnellstart

Auf dem Zielrechner (als root):

```bash
curl -fsSLO https://raw.githubusercontent.com/Rosenweg/MQTT-Broker/main/setup-mqtt-autopull.sh
bash setup-mqtt-autopull.sh
```

Das Skript klont bzw. aktualisiert dieses Repo nach `/opt/docker/mqtt`, fragt beim
ersten Mal den Cloudflare-API-Token (`certbot/cloudflare.ini`) sowie einen
Mosquitto-Benutzer (`auth/passwd`) ab, holt das erste Zertifikat und startet
`docker compose up -d`. Von Hand geht es auch so:

```bash
git clone https://github.com/Rosenweg/MQTT-Broker.git /opt/docker/mqtt
cd /opt/docker/mqtt
# certbot/cloudflare.ini und die Domain anpassen, dann:
docker compose up -d
```

`watchdog/renew-and-reload.sh` erneuert die Zertifikate (certbot, Cloudflare-DNS)
und startet Mosquitto danach neu.
