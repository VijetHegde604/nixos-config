# Vijet's NixOS Configuration

This repository is a flake-based setup for two machines and one Home Manager profile family:

- **`nix-btw`**: personal desktop/laptop NixOS profile (Niri + Dank Material Shell + Home Manager).
- **`nix-server`**: server NixOS profile with static networking, Docker, and Tailscale.
- **portable Home Manager profile**: a non-NixOS user profile target (`vijeth-portable`) intended for Linux hosts.

---

## Flake outputs

Defined in `flake.nix`:

```text
nixosConfigurations.nix-btw
nixosConfigurations.nix-server
homeConfigurations.vijeth-nixos
homeConfigurations.vijeth-portable
```

The flake also sets custom binary caches in `nixConfig` and pins:

- `nixpkgs` (`nixos-unstable`) for desktop + Home Manager
- `nixpkgs-stable` (`nixos-25.11`) for server
- `home-manager`, `niri-flake`, `DankMaterialShell`, `danksearch`, `helium-nix`, `nix-cachyos-kernel`

---

## Repository layout (current)

```text
.
├── flake.nix
├── flake.lock
├── DMS/
│   ├── binds.kdl
│   ├── clsettings.json
│   ├── overrides.kdl
│   ├── settings.json
│   └── windowrules.kdl
└── hosts/
    ├── nix-btw/
    │   ├── configuration.nix
    │   ├── hardware-configuration.nix
    │   ├── home-nixos.nix
    │   ├── home-portable.nix
    │   ├── settings.nix
    │   ├── modules/system/
    │   ├── modules/home/
    │   └── modules-portable/
    └── nix-server/
        ├── configuration.nix
        ├── hardware-configuration.nix
        ├── settings.nix
        └── modules/
```

---

## Configuration overview

## 1) `nixosConfigurations.nix-btw` (desktop)

Main file: `hosts/nix-btw/configuration.nix`

### System modules

- **Boot (`modules/system/boot.nix`)**
  - Limine bootloader
  - optional Secure Boot toggle from `settings.secureBoot`
  - CachyOS kernel (`pkgs.cachyosKernels.linuxPackages-cachyos-latest`)
  - Plymouth theming and quiet boot tuning

- **Networking (`modules/system/networking.nix`)**
  - NetworkManager enabled
  - Tailscale enabled
  - custom resolver/fallback DNS

- **Desktop (`modules/system/desktop.nix`)**
  - `greetd` starts `niri-session`
  - Niri enabled at system level
  - XDG portal with GTK portal

- **Hardware + multimedia (`modules/system/hardware.nix`)**
  - PipeWire stack
  - Intel graphics/media runtime packages
  - Bluetooth with experimental features
  - power/perf services (`thermald`, `upower`, `ananicy`, etc.)
  - battery threshold oneshot service (80%)

- **Packages (`modules/system/packages.nix`)**
  - core system tools + dev toolchain
  - Firefox, nix-ld, Podman (docker compat), fonts

- **Nix behavior (`modules/system/nix.nix`)**
  - flakes + nix-command
  - `programs.nh`
  - weekly `system.autoUpgrade`

- **Services (`modules/system/services.nix`)**
  - GNOME keyring, GVFS, udisks2, accounts-daemon, tumbler, zram

### Home Manager for `vijeth`

`home-nixos.nix` imports:

- shell, starship, git, fastfetch, packages, ghostty, xdg-user-dirs, zed, webapps
- plus DMS/Niri bindings when `settings.desktopShell == "dms"`

DMS module details (`modules/home/dms/dms.nix`):

- imports DMS + Niri + dsearch modules from flake inputs
- enables DMS systemd user service
- includes Niri fragments and explicit user overrides

---

## 2) `nixosConfigurations.nix-server`

Main file: `hosts/nix-server/configuration.nix`

### Highlights

- systemd-boot + latest kernel
- static network on `enp2s0` (no NetworkManager)
- firewall disabled
- Tailscale enabled
- Docker enabled
- OpenSSH enabled (`PermitRootLogin = no`, password auth on)
- mounted extra filesystems (`/media`, `/backup`)
- user `vijeth` + service `sys-monitor-api`
- daily Nix garbage collection

---

## 3) Home Manager outputs

### `homeConfigurations.vijeth-nixos`

Backed by `hosts/nix-btw/home-nixos.nix`, intended for NixOS host usage.

### `homeConfigurations.vijeth-portable`

Backed by `hosts/nix-btw/home-portable.nix` and `modules-portable/*`.

> **Important:** `home-portable.nix` currently references `./modules-common/home/*`, but this directory is not present in this repository. As written, this output may fail to evaluate until those imports are fixed or restored.

---

## DMS / Niri managed files

Tracked canonical files are in `DMS/`.

`hosts/nix-btw/modules/system/post-install.sh` is designed to:

1. Move repo from `/etc/nixos/nixos-config` to `/home/<user>/nixos-config` (if needed).
2. Set ownership to target user.
3. Create **symlinks** from user config locations to tracked repo files:
   - `DMS/settings.json` → `~/.config/DankMaterialShell/settings.json`
   - `DMS/clsettings.json` → `~/.config/DankMaterialShell/clsettings.json`
   - `DMS/overrides.kdl` → `~/.config/niri/dms/user/overrides.kdl`
   - `DMS/windowrules.kdl` → `~/.config/niri/dms/windowrules.kdl`

This keeps runtime config and repository state in sync without copy drift.

---

## Usage

## Requirements

- Nix installed
- Flakes enabled:

```conf
experimental-features = nix-command flakes
```

- For Home Manager standalone usage: `home-manager` CLI available

## Fresh desktop install (`nix-btw`)

```bash
git clone https://github.com/VijetHegde604/nixos-config.git /etc/nixos/nixos-config
cd /etc/nixos/nixos-config
sudo nixos-rebuild switch --flake .#nix-btw --accept-flake-config
```

(Optional, to migrate repo into user home and wire DMS/Niri symlinks):

```bash
sudo ./hosts/nix-btw/modules/system/post-install.sh
```

## Apply updates later

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nix-btw
```

## Server apply

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nix-server
```

## Home Manager apply

```bash
# NixOS desktop user profile
home-manager switch --flake ~/nixos-config#vijeth-nixos

# Portable profile (currently requires fixing missing modules-common imports)
home-manager switch --flake ~/nixos-config#vijeth-portable
```

---

## Handy commands

| Task | Command |
|---|---|
| Show flake outputs | `nix flake show ~/nixos-config` |
| Rebuild desktop | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-btw` |
| Rebuild server | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-server` |
| Apply desktop HM | `home-manager switch --flake ~/nixos-config#vijeth-nixos` |
| Update lockfile | `nix flake update --flake ~/nixos-config` |
| Run post-install linker | `sudo ~/nixos-config/hosts/nix-btw/modules/system/post-install.sh` |

---

## Notes

- This is a personal configuration repo and defaults assume username `vijeth`.
- Hardware-specific files (`hardware-configuration.nix`) and static network values should be adapted before reuse.
- Some modules contain host-specific values (disk UUIDs, gateway, local DNS).
