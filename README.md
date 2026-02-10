# nixos-config

Declarative and reproducible **NixOS configuration** using **Nix flakes** and **Home Manager**.

This repository contains my personal NixOS setup, structured to be modular, reproducible, and easy to maintain. It manages both system-level configuration and user-level environments in a single, version-controlled codebase.

---

## Overview

NixOS is a declarative Linux distribution where the entire system configuration is defined in code. This repository leverages that model to achieve:

* Fully reproducible system builds
* Version-controlled operating system and user environment
* Easy portability across machines
* Clear separation between system and user configuration
* Modular and extensible structure

The configuration uses **Nix flakes** for dependency pinning and **Home Manager** for user environment management.

---

## Repository Structure

```text
.
├── flake.nix
├── flake.lock
├── configuration.nix
├── hardware-configuration.nix
├── home.nix
└── modules/
    └── ...
```

### File and Directory Description

* **flake.nix**
  Entry point of the configuration. Defines inputs such as `nixpkgs` and `home-manager`, and exposes system and home configurations as flake outputs.

* **flake.lock**
  Locks all flake inputs to exact versions to ensure reproducibility.

* **configuration.nix**
  Main NixOS system configuration. Includes system services, packages, bootloader, networking, and global settings.

* **hardware-configuration.nix**
  Auto-generated hardware configuration created during NixOS installation. Contains disk, filesystem, and hardware-specific settings.

* **home.nix**
  Home Manager configuration defining user-level packages, shell configuration, dotfiles, and development tools.

* **modules/**
  Custom Nix modules used to organize configuration logically and keep files maintainable.

---

## Features

* Declarative system configuration using NixOS
* Flake-based workflow for reproducibility
* Home Manager integration for user environments
* Modular structure for scalability and clarity
* Version-controlled OS and dotfiles

---

## Usage

### Prerequisites

* NixOS installed
* Flakes enabled (`nix.settings.experimental-features = [ "nix-command" "flakes" ];`)
* Basic familiarity with Nix and NixOS concepts

### Clone the Repository

```bash
git clone https://github.com/VijetHegde604/nixos-config.git
cd nixos-config
```

### Rebuild the System

```bash
sudo nixos-rebuild switch --flake .#
```

This command builds and activates the system configuration defined in `flake.nix`.

---

## Home Manager

User-specific configuration is managed using Home Manager and is integrated through the flake.

To apply the Home Manager configuration:

```bash
home-manager switch --flake .#
```

The exact target depends on the hostname or user defined in the flake outputs.

---

## Extending the Configuration

New features and services can be added by creating additional modules under the `modules/` directory and importing them into `configuration.nix` or `home.nix`.

Example:

```text
modules/
├── desktop/
├── services/
├── shell/
└── packages/
```

This approach keeps the configuration clean and easy to scale across multiple systems.

---

## Notes

* `hardware-configuration.nix` is machine-specific and may need regeneration on new hardware.
* This configuration is opinionated and tailored for personal use; review before deploying on another system.
* Flakes ensure deterministic builds, but upgrading inputs should be done consciously.
