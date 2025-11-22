# Charm-Crypto & PBC Development Environment (Python 3.7)

[![Docker Build](https://img.shields.io/badge/docker-build-blue.svg)](https://www.docker.com/)
[![Python](https://img.shields.io/badge/python-3.7-yellow.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## 📖 Overview

This repository provides a highly optimized, multi-stage Docker environment for working with **Charm-Crypto** and the **Stanford PBC (Pairing-Based Cryptography)** libraries.

Because these libraries often require legacy dependencies, this image compiles **Python 3.7.17 from source** on a modern Debian Bookworm base, ensuring a secure OS with the specific language version needed for cryptographic research.

---

## 🚀 Key Features

* **Legacy Support:** Builds Python 3.7.17 from source with LTO optimizations.
* **Cryptography Ready:** Pre-installed Stanford PBC (0.5.14) and Charm-Crypto.
* **Optimized Image Size:** Multi-stage build strips unnecessary components.
* **Developer Friendly:** Fully compatible with VS Code Dev Containers.

---

## 🛠️ Installation & Usage

### Prerequisites

* Docker Desktop or Docker Engine installed

---

## 1. Build the Image

```bash
docker build -t charm-crypto-env .
```

---

## 2. Run the Container (Development Mode)

To persist your project files, mount your current directory into `/app`:

```bash
docker run -d \
  --name charm-dev \
  -v $(pwd):/app \
  charm-crypto-env
```

---

## 3. Enter the Running Container

```bash
docker exec -it charm-dev /bin/bash
```

Once inside, run your Python scripts normally:

```bash
python3.7 main.py
```

---

# 🧩 VS Code Dev Container Support

This repository includes a preconfigured Dev Container setup using `.devcontainer/devcontainer.json`.
If you use **Visual Studio Code**, this allows you to open the entire project inside a fully configured Docker environment without installing dependencies on your machine.

---

## 📦 What the Dev Container Provides

* Python 3.7.17 (built from source)
* Stanford PBC 0.5.14
* Charm-Crypto
* Automatic installation of Python extensions inside VS Code
* Consistent development environment across machines
* Clean isolation from host dependencies

---

## 📁 File Structure

```
.devcontainer/
└── devcontainer.json
```

---

## 🧰 devcontainer.json (Included)

```json
{
    "name": "Charm-Crypto Dev Environment",
    "build": {
        "dockerfile": "../Dockerfile",
        "context": ".."
    },
    "customizations": {
        "vscode": {
            "extensions": [
                "ms-python.python",
                "ms-python.vscode-pylance"
            ]
        }
    },
    "workspaceFolder": "/app",
    "postCreateCommand": "python3.7 --version"
}
```

---

## 🚀 How to Use the Dev Container

1. Install **Visual Studio Code**
2. Install the **Dev Containers** extension
3. Open this repository in VS Code
4. VS Code will detect the `.devcontainer` directory
5. Click **Reopen in Container**
6. Wait for Docker to build the environment
7. Your VS Code workspace runs completely inside the container

---

## 🧪 Running Code in the Dev Container

Open the VS Code integrated terminal:

```
Terminal → New Terminal
```

Then execute your Python scripts:

```bash
python3.7 main.py
```

Your code runs inside the same environment every time, ensuring reproducibility.

---

# 🤝 Contributing to Open Source

We welcome contributions from the community.
You can help by:

* Suggesting build-time optimizations
* Improving Charm-Crypto compatibility with newer Python versions
* Enhancing documentation and adding cryptographic examples

See `CONTRIBUTING.md` for details.

---

# 📜 License

This project is available under the **MIT License**.
