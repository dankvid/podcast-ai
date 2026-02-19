# 🚀 Deployment Guide: AI Podcast Generator

Diese Anleitung beschreibt, wie das System auf einer frischen VM (Ubuntu/Debian) installiert und abgesichert wird.

## 📋 Voraussetzungen

1.  **Server:** Eine VM mit mindestens 2GB RAM (4GB empfohlen).
2.  **Betriebssystem:** Ubuntu 22.04 LTS oder Debian 12.
3.  **Zugangsdaten:** 
    *   Dein öffentlicher SSH-Key (`~/.ssh/id_rsa.pub`).
    *   Google Cloud Service Account Key (`google-credentials.json`).
    *   Google Gemini API Key.

---

## 🛠 Schritt 1: Server-Provisionierung (Cloud-Init)

Beim Erstellen deiner VM (z.B. bei Hetzner, AWS oder DigitalOcean) kannst du die Datei `cloud-init.yaml` als **User Data** angeben.

**Was die Cloud-Init automatisch erledigt:**
*   Installation von Docker & Docker Compose.
*   Erstellung eines sicheren Users `deployuser`.
*   **SSH Hardening:** Deaktivierung von Root-Login und Passwort-Authentifizierung.
*   **Firewall (UFW):** Schließt alle Ports außer 22 (SSH) und 7860 (App).

> **Wichtig:** Trage vor dem Start deinen SSH-Key in die `cloud-init.yaml` unter `ssh_authorized_keys` ein!


---

## 🏗 Schritt 2: Anwendung installieren

Sobald die VM bereit ist, logge dich ein:
```bash
ssh deployuser@<deine-ip>
```

Navigiere in das Zielverzeichnis und klone das Repository:
```bash
cd /opt/podcast-ai
sudo git clone <deine-repo-url> .
sudo chown -R deployuser:deployuser .
```

---

## 🔑 Schritt 3: Konfiguration (.env)

Erstelle die Umgebungsvariablen aus der Vorlage:
```bash
cp .env.example .env
nano .env
```

Fülle die folgenden Felder aus:
*   `GEMINI_API_KEY`: Dein API-Key von Google.
*   `DB_PASSWORD`: Ein neues, sicheres Passwort für die MariaDB.
*   `GOOGLE_KEY_LOCAL_PATH`: `./google-credentials.json`.

**Wichtig:** Kopiere deine `google-credentials.json` per SCP auf den Server in den Ordner `/opt/podcast-ai/`.

---

## 🚢 Schritt 4: Start mit Docker Compose

Starte die gesamte Infrastruktur (App + Datenbank):
```bash
docker-compose up -d --build
```

Die App ist nun unter `http://<deine-ip>:7860` erreichbar.

---

## 🛡 Sicherheits-Checks (Für die Übergabe)

Um zu beweisen, dass das System gehärtet ist, kannst du folgende Befehle nutzen:

1.  **Firewall-Status:**
    ```bash
    sudo ufw status
    ```
    *Ergebnis: Nur 22 und 7860 sollten "ALLOW" sein.*

2.  **SSH Sicherheit:**
    ```bash
    grep "PermitRootLogin" /etc/ssh/sshd_config
    ```
    *Ergebnis: Sollte `no` sein.*

3.  **Docker Container Status:**
    ```bash
    docker ps
    ```
    *Ergebnis: Zwei Container (`podcast-generator` und `podcast-db`) müssen laufen.*

---

## 💡 Tipps & Tricks für den Betrieb

*   **Logs einsehen:** `docker-compose logs -f podcast-app` hilft bei der Fehlersuche.
*   **Datenbank-Zugriff:** Du musst nicht in den DB-Container. Die App kümmert sich um die Tabellen.
*   **Update:** Wenn du neuen Code hast: `git pull && docker-compose up -d --build`.

---

*Diese Dokumentation wurde für die Projektübergabe am 14. Februar 2026 erstellt.*
