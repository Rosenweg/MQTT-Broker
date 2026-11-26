<p align="center"><img src="docs/logo.png" width="96" alt="Logo"></p>
<h1 align="center">Rosenweg MQTT-Broker</h1>
<p align="center">Mosquitto-Broker mit TLS und Let's-Encrypt-Zertifikaten – die Nachrichten-Drehscheibe für Zähler, Sensoren und Anzeigen im Rosenweg.</p>
<p align="center"><a href="docs/entwickeln.md#schnellstart">Einrichten</a> · <a href="docs/entwickeln.md">Für Entwickler</a></p>

## Was drin ist

- Mosquitto als Docker-Compose-Dienst, verschlüsselt (MQTT über TLS und WebSocket über TLS).
- Ein offener, nur lesender WebSocket-Zugang für öffentliche Werte (`public/#`).
- Zertifikate von Let's Encrypt, automatisch erneuert, Broker danach neu gestartet.
- Ein Einrichtungs-Skript, das alles auf einem neuen Rechner aufsetzt und aktuell hält.

## Läuft auf

Linux mit Docker.

## Entwickeln

Konfiguration in `mosquitto/config/`, Dienste in `docker-compose.yml`.
Ports, Schnellstart und Zertifikats-Erneuerung stehen in [docs/entwickeln.md](docs/entwickeln.md).

## Lizenz

Keine Lizenz hinterlegt – alle Rechte vorbehalten.
