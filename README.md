## Nix Config: [ALICE]

This repository contains my personal NixOS and Home Manager configurations, managed via **Nix Flakes**. It’s designed to be a reproducible, declarative environment that works across different machines.

---

### Structure

The configuration is NOT organized, I SUCK at this:

* `flake.nix`: The main entry point for the entire configuration.

---

### 🚀 Getting Started

> [!WARNING]
> Do not run these configurations blindly. Review the code to ensure it matches your hardware and preferences.

#### 1. Requirements
* Nix installed with `flakes` and `nix-command` experimental features enabled.
* Git.

#### 2. Installation
To apply the system configuration for a specific host:

```bash
sudo nixos-rebuild switch --flake .#wonderland
```

To apply the Home Manager configuration:

```bash
home-manager switch --flake .#alice@wonderland
```

---

### ⚙️ Features

* Greastesxt config of all time hahahahahh!
---

### 🛠️ Key Tools

| Component | Description |
| :--- | :--- |
| **Bootloader** | [systemd-boot] |
| **Shell** | [Bash] |
| **WM/DE** | [Sway] |
| **Editor** | [Neovim/Emacs/VSCodium] |

---

### 📜 License

This project is licensed under the [*shrug*]. See the `LICENSE` file for details.
