FROM ghcr.io/astral-sh/uv:python3.11-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
COPY pyproject.toml uv.lock ./

RUN --mount=type=cache,taget=/root/.cache/uv \
    uv.sync --frozen --no-cache --no-dev --no-install-project

COPY . .

RUN uv sync --frozen --no-cache --no-dev

ENV PORT=7860
ENV HOST=0.0.0.0
ENV PATH="/app/.venv/bin:$PATH"

# Wir verlinken den Ordner auf sich selbst, damit team04.Frontend gefunden wird
RUN ln -s . team04

EXPOSE 7860

CMD ["python", "main.py"]
