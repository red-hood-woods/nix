## Nix Config: [ALICE]

This repository contains my personal NixOS and Home Manager configurations, managed via **Nix Flakes**. It’s designed to be a reproducible, declarative environment that works across different machines. Currently built for my laptop.

#### 25.11 Current

---

### Structure

The configuration is NOT organized, I SUCK at this:

- **`hosts/`**: Machine-specific configurations.
     - `common`: on the tin lmfao
     - `rabbit`: a test of old settings
     - `wonderland`: My primary laptop setup.

- **`modules/`**: The reusable bits.

    - `nixos`: System-level modules (like Flatpak support).

    - `home`: Home-manager modules (Sway, Foot, NixVim).

- **`users/`**: User-specific Home-Manager profiles (e.g., `alice`).

---

### Getting Started

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

### Features

* Greatest config of all time hahahahahh!
---

### Key Tools

| Component      | Description               |
| :------------- | :------------------------ |
| **Bootloader** | [[systemd-boot]]          |
| **Shell**      | [[Bash]]                  |
| **WM/DE**      | [[Sway]]                  |
| **Editor**     | [[Neovim/Emacs/VSCodium]] |
| **Fetch**      | [[Hyfetch/Fastfetch]]     |

---

### License

This project is licensed under the [*shrug*]. See the `LICENSE` file for details. ABSOLUTLY NO WARNETY!`
