# SRVB OS

<p align="center">
  <img src="system_files/usr/share/plymouth/themes/srvb/logo.png" alt="SRVB OS Logo" width="180">
</p>

<p align="center">
  Ein vorkonfiguriertes Fedora-bootc-Image mit GNOME.
</p>

## Überblick

SRVB OS ist ein unveränderliches Desktop-Linux auf Basis von Fedora bootc. Das
System verwendet GNOME als moderne Wayland-Desktopumgebung und bringt einen
persönlich vorkonfigurierten Arbeitsbereich mit. SRVB OS ist eine persönliche
Distribution-Konfiguration und erhebt nicht den Anspruch, eine allgemeingültige
Desktop-Distribution zu sein.

Das Image wird als OCI-Container gebaut und kann direkt mit `bootc` installiert
oder aktualisiert werden.

## Enthalten

- Fedora bootc als Basis
- GNOME als Wayland-Desktopumgebung
- GDM als Anmeldemanager
- Persönlich vorkonfigurierter GNOME-Desktop
- PipeWire und WirePlumber für Audio
- NetworkManager, Bluetooth, firewalld (+ firewall-config), fwupd und Power Profiles
- NVIDIA-Unterstützung über die vorbereiteten Kernel- und Dracut-Konfigurationen
- Vorinstallierte Flatpak-Anbindung mit Flathub und GNOME-Anwendungen
- Ghostty-Terminal mit Cursor-Shadern sowie Fish und Starship
- Zusätzliche Gaming-/Daily-Driver-Pakete und Flatpaks (u. a. Steam, Lutris, Heroic, OBS)

## Image

Das veröffentlichte Image ist:

```text
ghcr.io/srvb/srvb-os:latest
```

Die Images werden durch GitHub Actions gebaut und in die GitHub Container
Registry veröffentlicht. Signierte Images werden mit Cosign erstellt.

## Installation und Update

Auf einem bestehenden bootc-System kann das Image mit folgendem Befehl
installiert werden:

```bash
sudo bootc switch ghcr.io/srvb/srvb-os:latest
sudo systemctl reboot
```

Für spätere Updates genügt:

```bash
sudo bootc upgrade
```

## Hinweis zur Verwendung

SRVB OS ist eine persönliche Konfiguration und wird ohne Garantie für jeden
Anwendungsfall bereitgestellt. Die Verwendung, Installation und Aktualisierung
erfolgt auf eigene Gefahr. Vor einem Wechsel sollte ein Backup wichtiger Daten
vorhanden sein.

Das Image
ist für eine Neuinstallation oder den Wechsel von einem kompatiblen Fedora-
Atomic/bootc-System gedacht.

## Lizenz

Die Dateien dieses Projekts stehen, sofern nicht anders angegeben, unter der
Apache License 2.0. Der vollständige Lizenztext befindet sich in
[LICENSE](LICENSE).

Die im Image enthaltenen Komponenten und Pakete stammen von Drittanbietern und
unterliegen ihren jeweiligen Lizenzen. Für diese gelten die Lizenz- und
Urheberrechtshinweise der jeweiligen Projekte und Pakete.