# Podcast AI: Intelligenter Podcast-Generator

Podcast AI ist eine automatisierte Lösung zur Erstellung von Podcast-Episoden. Das System nutzt modernste Sprachmodelle (LLMs) zur Skripterstellung und hochwertige Text-to-Speech-Dienste (TTS), um aus einfachen Themenbeschreibungen oder Quelltexten fertige Audiobeiträge zu generieren.

## Hauptfunktionen

- **KI-Skripterstellung**: Generierung von Podcast-Skripten basierend auf Themen, gewünschter Dauer und Zielgruppe mittels Google Gemini.
- **Multi-Sprecher-Support**: Unterstützung für Dialoge zwischen verschiedenen Stimmen (z. B. Moderator und Gast).
- **Hochwertige Sprachausgabe**: Integration von Google Cloud Text-to-Speech für natürlich klingende Stimmen.
- **Web-Benutzeroberfläche**: Einfache Bedienung über ein Gradio-basiertes Web-Interface.
- **Historie & Verwaltung**: Speicherung generierter Podcasts und Metadaten in einer Datenbank zur späteren Verwaltung.

## Technische Architektur

Das Projekt folgt einem modularen Service-Repository-Muster:

- **Frontend**: Gradio-UI (`frontend/ui.py`), die mit dem Controller interagiert.
- **Services**: Kernlogik für den Workflow (`services/workflow.py`), LLM-Anbindung (`services/llm_service.py`) und TTS-Verarbeitung (`services/tts_service.py`).
- **Repositories**: Datenzugriffsschicht für Benutzer, Stimmen und Podcast-Metadaten (`repositories/`).
- **Datenbank**: SQLAlchemy-Anbindung an eine MariaDB/MySQL-Datenbank.

## Voraussetzungen

- **Python**: Version 3.11 oder höher.
- **System-Tools**: FFmpeg (für die Audioverarbeitung erforderlich).
- **API-Zugang**: 
  - Google Gemini API Key.
  - Google Cloud Service Account (JSON) für Text-to-Speech.

## Installation

1.  **Repository klonen**:
    ```bash
    git clone <repository-url>
    cd podcast-ai
    ```

2.  **Abhängigkeiten installieren**:
    Es wird empfohlen, eine virtuelle Umgebung zu verwenden:
    ```bash
    python -m venv .venv
    source .venv/bin/activate  # Unter Windows: .venv\Scripts\activate
    pip install -r requirements.txt
    ```

3.  **Umgebungsvariablen konfigurieren**:
    Erstelle eine `.env`-Datei im Hauptverzeichnis basierend auf der `.env.example`:
    ```env
    GEMINI_API_KEY=dein_gemini_key
    GOOGLE_APPLICATION_CREDENTIALS=pfad/zu/deinen/credentials.json
    DB_URL=mysql+pymysql://user:password@localhost/podcast_db
    HOST=127.0.0.1
    PORT=7860
    ```

## Anwendung starten

Starten Sie die Anwendung mit dem Hauptskript:

```bash
python main.py
```

Nach dem Start ist die Weboberfläche standardmäßig unter `http://127.0.0.1:7860` erreichbar.

## Projektstruktur

- `database/`: Datenbankmodelle und Initialisierungsskripte.
- `frontend/`: UI-Komponenten und Styling.
- `repositories/`: Kapselung der Datenbankzugriffe.
- `services/`: Geschäftslogik und API-Integrationen.
- `tests/`: Automatisierte Tests für die verschiedenen Module.
- `Output/`: Speicherort für die generierten MP3-Dateien.

---
*Dokumentation aktualisiert am 19. Februar 2026.*
