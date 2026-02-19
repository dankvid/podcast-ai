FROM ghcr.io/astral-sh/uv:latest AS uv_bin
FROM python:3.11-slim

# Kopiere uv aus dem offiziellen Image
COPY --from=uv_bin /uv /uvx /bin/

WORKDIR /app

# Installiere System-Abhängigkeiten
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Kopiere Konfigurationsdateien für das Dependency-Caching
COPY pyproject.toml uv.lock ./

# Installiere Abhängigkeiten (ohne das Projekt selbst)
# Wir nutzen den Cache-Mount für schnellere Re-Builds
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev --no-install-project

# Kopiere den Rest der App
COPY . .

# Synchronisiere das Projekt (installiert jetzt das eigene Paket/Code)
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

# Umgebungsvariablen setzen
ENV PORT=7860
ENV HOST=0.0.0.0
# Stelle sicher, dass die virtuelle Umgebung von uv genutzt wird
ENV PATH="/app/.venv/bin:$PATH"

# Verlinkung für Team-Struktur
RUN ln -s . team04

EXPOSE 7860

CMD ["python", "main.py"]
