# Technical Architecture

This document explains the internal structure of the Dockerfile used in this project. The environment relies on a multi-stage build strategy that separates the compile-time tasks from the lightweight runtime image.

## Stage 1: Builder ("build")

The build stage uses `debian:bookworm-slim` as the foundation. It serves as a workspace for compiling Python, PBC, and Charm-Crypto.

### Key Responsibilities

1. **Install Dependencies**
   Essential packages are installed, including `build-essential`, `libgmp-dev`, `libssl-dev`, and other required headers.

2. **Compile Python 3.7**
   Python 3.7 is downloaded as a source tarball because Debian Bookworm does not provide it natively. The build is configured with link time optimization for improved performance. Unnecessary components, such as test suites and development files, are removed to reduce the overall size.

3. **Compile Stanford PBC**
   The Pairing-Based Cryptography library is built from source. This ensures compatibility with the custom-built Python and the Charm-Crypto library.

4. **Build Charm-Crypto**
   The repository is cloned and the bindings are compiled directly against the freshly built Python and PBC installations.

## Stage 2: Runtime ("runtime")

A clean `debian:bookworm-slim` image is used for the runtime environment to avoid shipping unnecessary compilation tools.

### Key Responsibilities

1. **Transfer Artifacts**
   Only the `/usr/local` directory from the build stage is copied into the runtime image. This contains the compiled Python interpreter, PBC shared libraries, and Charm-Crypto modules.

2. **Install Runtime Dependencies**
   The runtime layer includes only non-development packages such as `libgmp10`. This keeps the final image minimal.

3. **Configure Linker Paths**
   The dynamic linker is configured so that the container can locate the PBC shared libraries correctly.

4. **Cleanup**
   Documentation files, temporary build caches, and unnecessary directories are removed to reduce the size of the resulting image.

## Entrypoint

The default command is `tail -f /dev/null`. This allows the container to stay active in the background so you can attach a shell session or use it within VS Code Dev Containers.
