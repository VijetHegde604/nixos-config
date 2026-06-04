# Vijet's NixOS Configuration

This repository is a flake-based NixOS and Home Manager setup for two machines, plus a portable Home Manager profile.

- **`nix-btw`**: personal desktop/laptop NixOS profile with Niri, Dank Material Shell, Home Manager, and declarative Disko partitioning.
- **`nix-server`**: server NixOS profile with static networking, Docker, Tailscale, and additional storage mounts.
- **`vijeth-portable`**: standalone Home Manager profile intended for non-NixOS Linux hosts.

---

## Flake outputs

Defined in `flake.nix`:

```text
nixosConfigurations.nix-btw
nixosConfigurations.nix-server
homeConfigurations.vijeth-nixos
homeConfigurations.vijeth-portable
```

The flake sets custom binary caches in `nixConfig` and pins these major inputs:

- `nixpkgs` (`nixos-unstable`) for the desktop and Home Manager profiles
- `nixpkgs-stable` (`nixos-26.05`) for the server profile
- `home-manager`, `niri-flake`, Dank Material Shell (`dms`), `danksearch`, `dms-plugin-registry`, `helium-nix`, `nix-cachyos-kernel`, `vicinae`, `vicinae-extensions`, and `nix-flatpak`

---

## Repository layout

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
    │   ├── disko-config.nix
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

### 1) `nixosConfigurations.nix-btw` desktop

Main file: `hosts/nix-btw/configuration.nix`

#### Declarative partitioning with Disko

`hosts/nix-btw/disko-config.nix` defines the intended desktop disk layout:

- target disk: `/dev/nvme0n1`
- GPT partition table
- EFI system partition mounted at `/boot`
- encrypted LUKS container named `root`
- Btrfs filesystem inside LUKS with subvolumes for:
  - `/` (`@`)
  - `/home` (`@home`)
  - `/nix` (`@nix`)
  - `/var/log` (`@log`)
- Btrfs mount options tuned for SSD usage, compression, noatime, async discard, and `space_cache=v2`

> **Destructive warning:** Disko formatting modes can erase the target disk. Confirm `device = "/dev/nvme0n1"` in `hosts/nix-btw/disko-config.nix` is the correct install disk before running Disko.

#### System modules

- **Boot (`modules/system/boot.nix`)**
  - Limine bootloader
  - optional Secure Boot toggle from `settings.secureBoot`
  - CachyOS kernel (`pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3`)
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
  - battery threshold oneshot service at 80%

- **Packages (`modules/system/packages.nix`)**
  - core system tools and development toolchain
  - Firefox, nix-ld, Podman with Docker compatibility, and fonts

- **Nix behavior (`modules/system/nix.nix`)**
  - flakes and `nix-command`
  - `programs.nh`
  - weekly `system.autoUpgrade`

- **Services (`modules/system/services.nix`)**
  - GNOME keyring, GVFS, udisks2, accounts-daemon, tumbler, and zram

#### Home Manager for `vijeth`

`home-nixos.nix` imports shell, starship, git, fastfetch, packages, Ghostty, XDG user directories, Zed, and webapp modules. It also imports the DMS/Niri module when `settings.desktopShell == "dms"`.

DMS module details (`modules/home/niri/dms.nix`):

- imports DMS, Niri, and dsearch modules from flake inputs
- enables the DMS systemd user service
- includes Niri fragments and explicit user overrides

---

### 2) `nixosConfigurations.nix-server`

Main file: `hosts/nix-server/configuration.nix`

Highlights:

- systemd-boot and latest kernel
- static network on `enp2s0` without NetworkManager
- firewall disabled
- Tailscale enabled
- Docker enabled
- OpenSSH enabled (`PermitRootLogin = no`, password auth on)
- mounted extra filesystems (`/media`, `/backup`)
- user `vijeth` and service `sys-monitor-api`
- daily Nix garbage collection

---

### 3) Home Manager outputs

#### `homeConfigurations.vijeth-nixos`

Backed by `hosts/nix-btw/home-nixos.nix`, intended for NixOS desktop usage.

#### `homeConfigurations.vijeth-portable`

Backed by `hosts/nix-btw/home-portable.nix` and `modules-portable/*`.

> **Important:** `home-portable.nix` currently references `./modules-common/home/*`, but this directory is not present in this repository. As written, this output may fail to evaluate until those imports are fixed or restored.

---

## DMS / Niri managed files

Tracked canonical files are in `DMS/`.

`hosts/nix-btw/modules/system/post-install.sh` is designed to:

1. Move the repo from `/etc/nixos/nixos-config` to `/home/<user>/nixos-config` when needed.
2. Set ownership to the target user.
3. Create symlinks from user config locations to tracked repo files:
   - `DMS/settings.json` → `~/.config/DankMaterialShell/settings.json`
   - `DMS/clsettings.json` → `~/.config/DankMaterialShell/clsettings.json`
   - `DMS/overrides.kdl` → `~/.config/niri/dms/user/overrides.kdl`
   - `DMS/windowrules.kdl` → `~/.config/niri/dms/windowrules.kdl`

This keeps runtime config and repository state in sync without copy drift.

---

## Usage

### Requirements

- Nix installed
- Flakes enabled:

```conf
experimental-features = nix-command flakes
```

- For standalone Home Manager usage: `home-manager` CLI available

### Fresh desktop install with Disko (`nix-btw`)

From a NixOS installer environment, clone the repo into a temporary location first:

```bash
git clone https://github.com/VijetHegde604/nixos-config.git /tmp/nixos-config
cd /tmp/nixos-config
```

Inspect and update the Disko target disk if necessary:

```bash
$EDITOR hosts/nix-btw/disko-config.nix
```

Format and mount the declared layout:

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
  --mode destroy,format,mount ./hosts/nix-btw/disko-config.nix
```

Copy the repo into the mounted system so it persists after installation:

```bash
sudo mkdir -p /mnt/etc/nixos
sudo cp -a /tmp/nixos-config /mnt/etc/nixos/nixos-config
cd /mnt/etc/nixos/nixos-config
```

Install the desktop profile:

```bash
sudo nixos-install --flake .#nix-btw --accept-flake-config
```

After first boot, optionally migrate the repo into the user's home directory and wire DMS/Niri symlinks:

```bash
sudo /etc/nixos/nixos-config/hosts/nix-btw/modules/system/post-install.sh
```

### Rebuild the desktop later

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nix-btw --accept-flake-config
```

### Rebuild the server

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nix-server --accept-flake-config
```

### Apply Home Manager profiles

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
| Show flake outputs | `nix flake show ~/nixos-config --accept-flake-config` |
| Rebuild desktop | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-btw --accept-flake-config` |
| Rebuild server | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-server --accept-flake-config` |
| Apply desktop Home Manager | `home-manager switch --flake ~/nixos-config#vijeth-nixos` |
| Update lockfile | `nix flake update --flake ~/nixos-config --accept-flake-config` |
| Run Disko format/mount for desktop | `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ~/nixos-config/hosts/nix-btw/disko-config.nix` |
| Run post-install linker | `sudo ~/nixos-config/hosts/nix-btw/modules/system/post-install.sh` |

---

## Notes

- This is a personal configuration repo and defaults assume username `vijeth`.
- Hardware-specific files, static network values, and disk targets should be adapted before reuse.
- The desktop Disko config is intentionally destructive when run in formatting modes; always verify the target disk first.
- Some modules contain host-specific values such as disk UUIDs, gateway addresses, and local DNS.
