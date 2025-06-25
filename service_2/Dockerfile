FROM python:3.11-slim

# Install system tools and uv manually
RUN apt-get update && apt-get install -y \
    python3-venv \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/* && \
    curl -LO https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-unknown-linux-musl.tar.gz && \
    tar -xzf uv-x86_64-unknown-linux-musl.tar.gz && \
    mv uv-x86_64-unknown-linux-musl/uv /usr/local/bin/uv && \
    chmod +x /usr/local/bin/uv && \
    rm -rf uv-x86_64-unknown-linux-musl*

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN uv venv

# ✅ Corrected pip install
RUN .venv/bin/python -m ensurepip && \
    .venv/bin/python -m pip install --upgrade pip && \
    .venv/bin/python -m pip install uv

RUN .venv/bin/uv sync

COPY . .

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

CMD ["uv", "run", "app.py"]

