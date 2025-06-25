# 🚀 Docker NGINX Reverse Proxy with Golang & Python Microservices

This project demonstrates a microservices architecture using **Docker Compose**. It includes:
- 🐍 A Python application (Service 2)
- 🐹 A Golang application (Service 1)
- 🌐 NGINX reverse proxy to route traffic
- 💡 Docker Healthchecks, clean logging, and modular setup

---

## 🧱 Project Structure

```
docker-nginx-reverse-proxy/
│
├── nginx/
│   └── nginx.conf               # NGINX config with reverse proxy rules
│
├── service1/                    # Golang application
│   ├── main.go
│   └── Dockerfile
│
├── service2/                    # Python application
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── docker-compose.yml           # Defines multi-service Docker environment
└── README.md
```

---

## ⚙️ How It Works

- `NGINX` acts as a **reverse proxy** listening on port `80`.
- It forwards requests based on path:
  - `/service1` → Golang app
  - `/service2` → Python app
- Each service has a **healthcheck** to ensure it's running correctly.

---

## 🏃‍♂️ Quick Start (Run Locally)

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/docker-nginx-reverse-proxy.git
cd docker-nginx-reverse-proxy
```

2. **Build and start the containers**
```bash
docker compose up --build
```

3. **Test the applications**
Open your browser:

- 🔗 http://localhost/service1/ping → Go service output  
- 🔗 http://localhost/service2/ping → Python service output

4. **Stop all containers**
```bash
docker compose down
```

---

## 🩺 Healthcheck Details

Docker performs healthchecks every 30 seconds:
- **Go App**: Checks output of root endpoint
- **Python App**: Checks output of root endpoint
- Healthy status is shown using:

```bash
docker inspect --format='{{json .State.Health}}' <container_name>
```

---

## 🪵 Sample Logs

```bash
[service1] Server started on port 8001
[service2] Running on http://0.0.0.0:8002
[nginx] Reverse proxy up on port 80
```
⚙️ About uv

uv is a fast, modern Python package manager and virtual environment tool written in Rust. It aims to be a drop-in replacement for pip, pip-tools, and virtualenv with significantly better performance and unified workflows.

🔥 Why uv?

✅ Extremely fast dependency resolution and installation

✅ Single tool to manage:

Virtual environments (uv venv)

Lockfiles (uv lock)

Dependency syncing (uv sync)

Script execution (uv run)

✅ Supports modern pyproject.toml-based workflows

✅ Ideal for Docker-based Python projects due to speed and reproducibility

🐳 Using uv in Docker

In this project, uv is used inside the Python (Service 2) Docker container to:

Create a virtual environment:

RUN uv venv

Upgrade pip and install uv inside the venv:

RUN .venv/bin/python -m ensurepip && \
    .venv/bin/python -m pip install --upgrade pip && \
    .venv/bin/python -m pip install uv

Install all dependencies from uv.lock:

RUN .venv/bin/uv sync

Run the application using uv:

CMD ["uv", "run", "app.py"]

📦 Locking Dependencies

To lock your dependencies with uv:

uv lock

This reads from your pyproject.toml and generates a uv.lock file.

The uv.lock file ensures everyone — including Docker builds — installs the exact same dependency versions for reproducibility.

🧱 Summary of Benefits

Feature

Benefit

🔥 Speed

Much faster than pip + virtualenv

🧹 Simplicity

All-in-one dependency management

🐳 Docker-Friendly

Clean install, perfect for CI/CD

🎯 Reliable Builds

Lockfile ensures exact dependencies
---

## 📦 Environment Details

| Component | Version        |
|----------|----------------|
| Python    | 3.11           |
| Golang    | 1.21+          |
| Docker    | 24.x           |
| OS        | Linux/Windows  |
| uv        | latest (for Python dep) |

---

## 📌 Notes

- Reverse proxy routes are defined in `nginx/nginx.conf`.
- `.dockerignore` improves build performance by skipping unnecessary files.
- Both apps are independently dockerized and run on isolated internal ports (`8001`, `8002`).

---


🐞 Common Errors Faced and Solutions

❌ 1. uv: command not found during Docker build
Cause:
You tried to run uv in the container before it was installed.

Fix:
Installed uv manually using this block in the Dockerfile:

RUN curl -LO https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-unknown-linux-musl.tar.gz && \
    tar -xzf uv-x86_64-unknown-linux-musl.tar.gz && \
    mv uv /usr/local/bin/uv && chmod +x /usr/local/bin/uv

    
❌ 2. Failed to fetch deb.debian.org or apt-get update fails
Cause:
The Docker container couldn’t connect to the internet due to DNS issues.

Fix:
Configured Docker daemon DNS by editing /etc/docker/daemon.json:

{
  "dns": ["8.8.8.8", "1.1.1.1"]
}
Then restarted Docker:
sudo systemctl restart docker


❌ 3. uv lock error: No interpreter found for Python 3.13
Cause:
The Python version specified in pyproject.toml (>=3.13) wasn't installed on your system.

Fix:
Updated the requires-python in pyproject.toml to match the installed version:
requires-python = ">=3.11"
Then re-ran:
uv lock


❌ 4. service1 container showing (unhealthy) in Docker
Cause:
Healthcheck failed because curl was not installed in the Go container.

Fix:
Added curl installation to service_1/Dockerfile:
RUN apk add --no-cache curl
Also ensured the Go app had a valid /ping route that returned proper JSON.


❌ 5. docker-compose: command not found
Cause:
docker-compose v1 is deprecated or not installed.

Fix:
Used the correct modern CLI:
docker compose up --build
(Note the space between docker and compose)


❌ 6. nginx: host not found in upstream "service1" error
Cause:
Nginx started before service1 was ready, or service name was incorrect.

Fix:
Used depends_on in docker-compose.yml:
nginx:
  depends_on:
    - service1
    - service2
Also ensured the proxy_pass in nginx.conf used the Docker service names correctly:
proxy_pass http://service1:8001/;

❌ 7. .venv/bin/uv: not found during build
Cause:
You tried to use uv inside .venv before installing it.

Fix:
Installed uv manually inside the virtual environment:

RUN .venv/bin/python -m ensurepip && \
    .venv/bin/python -m pip install --upgrade pip && \
    .venv/bin/python -m pip install uv

---

## 🙌 Acknowledgements

Built as part of a DevOps Internship assignment for **DPDzero**.

---

## 📬 Contact

**Mohammed Yasin**  
Python & DevOps Intern  
Email: yasinmohammed1075@gmail.com 
GitHub: https://github.com/Mohammedyasin5
