# Charm-Crypto & PBC Development Environment (Python 3.7)

[![Docker Build](https://img.shields.io/badge/docker-build-blue.svg)](https://www.docker.com/)
[![Python](https://img.shields.io/badge/python-3.7-yellow.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## 📖 Overview

This repository provides a highly optimized, multi-stage Docker environment for working with **Charm-Crypto** and the **Stanford PBC (Pairing-Based Cryptography)** libraries.

Because these libraries often require legacy dependencies, this image compiles **Python 3.7 from source** on top of a modern Debian Bookworm base, ensuring you have a secure OS with the specific language version required for your cryptographic research.

## 🚀 Key Features

* **Legacy Support:** Compiles Python 3.7.17 from source (with LTO optimizations).
* **Cryptography Ready:** Pre-installed Stanford PBC (0.5.14) and Charm-Crypto.
* **Optimized Size:** Uses a multi-stage build to strip build artifacts, resulting in a slim runtime image.
* **Dev-Ready:** Configured to work seamlessly with VS Code Dev Containers.

## 🛠️ Installation & Usage

### Prerequisites

* Docker Desktop or Docker Engine

### 1. Build the Image

```bash
docker build -t charm-crypto-env .
```

### 2. Run the Container (Development Mode)

To persist your code changes, mount your current directory to `/app`:

```bash
docker run -d \
  --name charm-dev \
  -v $(pwd):/app \
  charm-crypto-env
```

### 3. Enter the Environment

```bash
docker exec -it charm-dev /bin/bash
```

Once inside, run your scripts:

```bash
python3.7 main.py
```

## 🤝 Contributing to Open Source

We strongly encourage the open-source community to improve this environment. Cryptography implementations can be tricky, and maintaining a stable environment is a community effort.

How you can help:

* Suggest build-time optimizations.
* Submit updates if Charm-Crypto gains compatibility with newer Python versions.
* Improve documentation and cryptographic examples.

See `CONTRIBUTING.md` for contribution guidelines.

## 📜 License

This project is available under the MIT License.
