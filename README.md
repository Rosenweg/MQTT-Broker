<p align="center"><img src="docs/logo.png" width="96" alt="Logo"></p>
<h1 align="center">Rosenweg MQTT-Broker</h1>
<p align="center">Mosquitto-Broker mit TLS und Let's-Encrypt-Zertifikaten – die Nachrichten-Drehscheibe für Zähler, Sensoren und Anzeigen im Rosenweg.</p>
<p align="center"><a href="#einrichten">Einrichten</a> · <a href="docs/entwickeln.md">Anleitung</a></p>

## Inhalt

- [Überblick](#überblick)
- [Läuft auf](#läuft-auf)
- [Ports und Zugänge](#ports-und-zugänge)
- [Rechte (ACL)](#rechte-acl)
- [Aufbau](#aufbau)
- [Einrichten](#einrichten)
- [Betrieb und Zertifikate](#betrieb-und-zertifikate)
- [Konfiguration](#konfiguration)
- [Lizenz](#lizenz)

## Überblick

Der Broker verteilt Messwerte im Rosenweg – etwa Stromzähler, ioBroker-Werte und Anzeigen. Er läuft als Docker-Compose-Dienst und holt sich seine Zertifikate selbst.

- **Verschlüsselt:** MQTT über TLS und WebSocket über TLS.
- **Öffentlich lesbar:** ein anonymer, nur lesender WebSocket-Zugang für `public/#`.
- **Zertifikate:** Let's Encrypt über die Cloudflare-DNS-Prüfung, automatisch erneuert, Mosquitto danach neu gestartet.
- **Einrichtung per Skript:** ein Befehl setzt einen neuen Rechner auf und hält ihn aktuell.

## Läuft auf

| Plattform | Stand |
|---|---|
| Linux mit Docker und Docker Compose | ja |

## Ports und Zugänge

| Port | Protokoll | Anmeldung | Zweck |
|---|---|---|---|
| 8883 | MQTT über TLS | Benutzer und Passwort | Geräte, ioBroker, Dienste |
| 8084 | WebSocket über TLS (wss) | Benutzer und Passwort | Web-Anwendungen |
| 8083 | WebSocket ohne TLS | anonym | nur lesen, nur `public/#` |

## Rechte (ACL)

Die Rechte stehen in `mosquitto/config/acl.conf`.

| Wer | darf |
|---|---|
| `r9-iobroker-technik` | `r9/#` lesen und schreiben |
| `r9-client1` | `r9/#` und `r13/strom/h1` lesen |
| anonym (nur Port 8083) | `public/#` lesen |

Passwörter liegen in `auth/passwd` (nicht im Repo); neue Benutzer mit `mosquitto_passwd`.

## Aufbau

| Teil | Inhalt |
|---|---|
| `docker-compose.yml` | Dienste `mosquitto`, `certbot` (dns-cloudflare) und `watchdog` (Erneuerung) |
| `mosquitto/config/mosquitto.conf` | Listener, TLS-Zertifikate, Passwort- und ACL-Datei |
| `mosquitto/config/acl.conf` | Rechte je Benutzer |
| `setup-mqtt-autopull.sh` | Einrichtung und Aktualisierung unter `/opt/docker/mqtt` |
| `watchdog/renew-and-reload.sh` | Zertifikate erneuern, Mosquitto neu starten |

## Einrichten

Auf dem Zielrechner (als root):

```bash
curl -fsSLO https://raw.githubusercontent.com/Rosenweg/MQTT-Broker/main/setup-mqtt-autopull.sh
bash setup-mqtt-autopull.sh
```

Das Skript klont bzw. aktualisiert das Repo nach `/opt/docker/mqtt`, fragt beim ersten Mal den Cloudflare-API-Token und einen Mosquitto-Benutzer ab, holt das erste Zertifikat und startet `docker compose up -d`.

Von Hand:

```bash
git clone https://github.com/Rosenweg/MQTT-Broker.git /opt/docker/mqtt
cd /opt/docker/mqtt
# certbot/cloudflare.ini und die Domain anpassen, dann:
docker compose up -d
```

**Vorher anpassen:** In `docker-compose.yml` und `mosquitto.conf` stehen Platzhalter (`mqtt.example.com`, `dein@email.tld`).

## Betrieb und Zertifikate

| Aufgabe | So geht's |
|---|---|
| Aktualisieren | `setup-mqtt-autopull.sh` erneut ausführen (holt den Stand von GitHub) |
| Zertifikat erneuern | läuft im Dienst `watchdog` alle 12 Stunden (`renew-and-reload.sh`) |
| Neustart | `docker restart mosquitto` |
| Logs | `docker compose logs -f mosquitto` |

## Konfiguration

Dateien auf dem Server, nicht im Repo – nur die Namen:

| Datei | Inhalt |
|---|---|
| `certbot/cloudflare.ini` | `dns_cloudflare_api_token` für die DNS-Prüfung |
| `auth/passwd` | Mosquitto-Benutzer und Passwort-Hashes |
| `certbot/conf/` | Zertifikate von Let's Encrypt |

Mehr: [docs/entwickeln.md](docs/entwickeln.md).

## Lizenz

Keine Lizenz hinterlegt – alle Rechte vorbehalten.
