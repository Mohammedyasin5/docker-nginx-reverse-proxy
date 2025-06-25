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

## 🙌 Acknowledgements

Built as part of a DevOps Internship assignment for **DPDzero**.

---

## 📬 Contact

**Mohammed Yasin**  
Python & DevOps Intern  
Email: yasinmohammed1075@gmail.com 
GitHub: https://github.com/Mohammedyasin5
