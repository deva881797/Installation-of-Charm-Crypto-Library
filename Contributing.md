# Contributing Guidelines

Thank you for considering a contribution to this project. The goal of this environment is to maintain a clean, stable, and reproducible setup for working with Charm-Crypto and Stanford PBC. Contributions that improve reliability, clarity, or developer experience are welcome.

---

## 📌 How You Can Contribute

### 1. Improving the Docker Environment

* Optimize build steps in the Dockerfile.
* Reduce image size without breaking functionality.
* Update build flags or dependencies where possible.
* Propose enhancements for Python 3.7 compatibility.

### 2. Documentation Enhancements

* Improve existing guides for clarity.
* Add missing explanations or troubleshooting steps.
* Contribute working examples or tutorials.

### 3. Charm-Crypto or PBC Compatibility

* Test compatibility with newer toolchains.
* Provide patches for build failures.
* Document quirks or fixes you discover.

### 4. Issue Reports

If you find a problem, open an issue and include:

* Clear description of the issue
* Steps to reproduce
* Logs, errors, or screenshots
* Host OS and Docker version

---

## 📥 Pull Request Process

1. **Fork** the repository.
2. Create a new branch for your change:

   ```bash
   git checkout -b feature-description
   ```
3. Make your changes clean and well-documented.
4. Add or update documentation when necessary.
5. Test your changes inside the Docker environment.
6. Submit a Pull Request with a clear explanation.

---

## 🧪 Coding and Style Guidelines

* Keep code simple, readable, and consistent.
* Avoid adding unnecessary dependencies.
* Follow existing patterns in scripts and config files.
* When in doubt, prefer explicit clarity over clever tricks.

---

## 🧰 Development Setup

You can work inside the Dev Container or a manually launched container.

Inside VS Code Dev Container:

```bash
python3.7 your_script.py
```

Manual usage:

```bash
docker exec -it charm-dev /bin/bash
```

---

## 🤝 Community Values

* Be respectful and constructive.
* Write helpful commit messages.
* Keep the environment stable for all users.
* Contributions of any size are appreciated.

---

## 📜 License

By contributing, you agree that your contributions will be licensed under the **MIT License**.
