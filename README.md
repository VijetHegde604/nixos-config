# Vijet’s NixOS + Home Manager Config

Declarative and reproducible configuration for **NixOS** and **Home Manager** (portable across any Linux distro) using **Nix flakes**.

This repository manages:

- **NixOS system configuration** (services, packages, kernels, hardware settings)
- **Home Manager user environments** (dotfiles, shells, prompts, dev tools)
- A split architecture supporting:
  - `vijeth-nixos` — Full NixOS + Home Manager config
  - `vijeth-portable` — Standalone Home Manager for non-NixOS distros (e.g., CachyOS, Arch)

---

## Repository Structure

```

.
├── flake.nix                     # Flake entrypoint supporting NixOS + Portable HM
├── flake.lock                    # Locked inputs for reproducibility
├── configuration.nix            # NixOS system config
├── hardware-configuration.nix   # Hardware config from NixOS install
├── home-nixos.nix               # Home Manager modules for NixOS
├── home-portable.nix            # Home Manager modules for non-NixOS
├── modules-common/              # Shared reusable modules
├── modules-nixos/               # NixOS-specific modules
└── modules-portable/            # Portable modules for non-NixOS use

````

---

## Features

- Full **flaketized** approach — pin your inputs and configs
- **Modular and reusable** structure
- Seamless integration with **Home Manager**
- Supports hybrid workflows (NixOS + portable Linux)
- User tools and dotfiles managed declaratively

---

## How It Works

### Supported Flake Outputs

Your flake exposes:

```text
nixosConfigurations.nix-btw
homeConfigurations.vijeth-nixos
homeConfigurations.vijeth-portable
````

* `nixosConfigurations.nix-btw`: Full NixOS configuration
* `homeConfigurations.vijeth-nixos`: Home Manager config on NixOS
* `homeConfigurations.vijeth-portable`: Home Manager config for any Linux distro

---

## 🧪 Usage

### On NixOS

Make sure **flakes** are enabled in `/etc/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

Then:

```bash
git clone https://github.com/VijetHegde604/nixos-config.git
cd nixos-config

sudo nixos-rebuild switch --flake .#nix-btw
```

This will build and activate your full system configuration.

To apply Home Manager on NixOS:

```bash
home-manager switch --flake .#vijeth-nixos
```

---

### On a Non-NixOS Distro (e.g., CachyOS, Arch)

1. Install Nix with flakes enabled.
2. Clone this repository:

```bash
git clone https://github.com/VijetHegde604/nixos-config.git
cd nixos-config
```

3. Apply Home Manager for your portable configuration:

```bash
home-manager switch --flake .#vijeth-portable
```

---

## About Home Manager Split

The portable config uses only:

* portable + common modules
* no system services
* no GPU / compositor enablement

This ensures your **dotfiles and user tools** work on any Linux distro without NixOS system components.

NixOS config includes:

* system services
* bootloader
* package configuration
* system-wide modules

---

## 🛠 Example Modules

In `modules-common/` you’ll find shared things like:

* shell configuration
* git config
* starship prompt
* xdg dirs

In `modules-portable/`:

* Ghostty config (config-only, binary installed via distro)
* shell-configuration with home-manager tailored aliases
* other portable modules

---

## Cleanup and GC (Non-NixOS)

To purge old generations from Home Manager and free space:

```bash
home-manager expire-generations 0
nix gc
```

---

## Notes

* This repository is **personal and opinionated** — review before reusing
* Home Manager config is split for clarity and portability
* Hardware-specific portions (like `hardware-configuration.nix`) may vary per machine

---

## Useful Commands

| Task               | Command                                         |
| ------------------ | ----------------------------------------------- |
| Update flakes      | `nix flake update`                              |
| Apply portable HM  | `home-manager switch --flake .#vijeth-portable` |
| Apply NixOS HM     | `home-manager switch --flake .#vijeth-nixos`    |
| Apply NixOS system | `sudo nixos-rebuild switch --flake .#nix-btw`   |

---
