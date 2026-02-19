# 🎙️ Podcast-AI Generator

Dieses Projekt generiert automatisch Podcast-Inhalte mithilfe von KI (Gemini API) und anderen Services. Es ist für ein automatisches Deployment via Docker auf einer Linux-Instanz vorbereitet.

---

## 🚀 Deployment mit Cloud-Init

Die Datei `cloud-init.yaml` ermöglicht es dir, einen frischen Server (z.B. bei Hetzner, DigitalOcean oder AWS) in wenigen Minuten vollautomatisch aufzusetzen.

### ⚠️ Wichtige Vorbereitungen
Bevor du die `cloud-init.yaml` nutzt, **musst** du folgende Platzhalter in der Datei manuell ersetzen:

1.  **SSH-Key:**
    - Suche nach `<public_ssh_key>` und füge deinen öffentlichen SSH-Schlüssel (`id_rsa.pub` oder `ed25519.pub`) ein.
    - **Wichtig:** Nach dem Deployment ist der SSH-Zugriff nur noch über **Port 2222** möglich!

2.  **API Keys & Secrets (`.env` Sektion):**
    - `GEMINI_API_KEY`: Dein API-Key von Google AI Studio.
    - `MAILGUN_API_KEY` & `DOMAIN`: Falls du E-Mails versenden möchtest.
    - `DB_PASSWORD`: Ändere das Standard-Passwort für die Datenbank.

3.  **Google Cloud Service Account:**
    - Suche nach der Sektion `/opt/podcast-ai/google-key.json` und füge dort deinen echten Service-Account JSON-Inhalt ein (wird für Google Cloud APIs benötigt).

4.  **Repository-Zugriff:**
    - Die Cloud-Init geht davon aus, dass das Repository **öffentlich** ist.
    - Falls dein Repository **privat** ist, musst du die Git-URL in der `runcmd`-Sektion anpassen (z.B. mit einem Personal Access Token).

### 🛠️ Nach dem Deployment
Sobald der Server gestartet ist, kannst du den Fortschritt der Installation mit folgendem Befehl auf dem Server prüfen:

```bash
tail -f /var/log/cloud-init-output.log
```

Verbindung zum Server (ersetze `IP_ADRESSE` durch deine Server-IP):
```bash
ssh admin@IP_ADRESSE -p 2222
```

---

## 💻 Lokale Entwicklung
Für die lokale Entwicklung benötigst du Python und Docker:

1. `.env` Datei basierend auf den Beispielen erstellen.
2. `docker compose up --build` ausführen.
