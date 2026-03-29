# Vijet's NixOS Configuration

This repository contains the Nix flakes and host modules used to manage two machines:

- `nix-btw`: a desktop NixOS system with Home Manager, Niri, and Dank Material Shell.
- `nix-server`: a separate NixOS server profile.

It also exposes a portable Home Manager configuration for reusing the user environment outside NixOS.

## Flake outputs

The current flake exports these entry points:

```text
nixosConfigurations.nix-btw
nixosConfigurations.nix-server
homeConfigurations.vijeth-nixos
homeConfigurations.vijeth-portable
```

## Repository layout

```text
.
├── flake.nix
├── flake.lock
├── DMS/                              # Checked-in DMS and Niri override files
├── hosts/
│   ├── nix-btw/                      # Desktop host
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   ├── home-nixos.nix
│   │   ├── home-portable.nix
│   │   ├── modules-common/
│   │   ├── modules-portable/
│   │   ├── post-install.sh
│   │   └── settings.nix
│   └── nix-server/                   # Server host
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       ├── modules/
│       └── settings.nix
└── README.md
```

## What each profile does

### `nixosConfigurations.nix-btw`

Builds the full desktop system, including:

- system services and boot configuration
- Niri and desktop-related system settings
- Home Manager integration for the `vijeth` user
- Dank Material Shell and related user tooling

### `nixosConfigurations.nix-server`

Builds the server-specific NixOS system with its own module set.

### `homeConfigurations.vijeth-nixos`

Applies the Home Manager profile used on the desktop host.

### `homeConfigurations.vijeth-portable`

Applies the portable Home Manager profile for non-NixOS Linux systems.

## Requirements

Before using the flake, make sure:

1. Nix is installed.
2. Flakes are enabled in `/etc/nix/nix.conf`:

   ```conf
   experimental-features = nix-command flakes
   ```

3. On non-NixOS systems, Home Manager is installed and available in `PATH`.

## Desktop host setup (`nix-btw`)

### Fresh install workflow

After a fresh NixOS installation, clone this repository into `/etc/nixos/nixos-config` and apply the desktop configuration:

```bash
git clone https://github.com/VijetHegde604/nixos-config.git /etc/nixos/nixos-config
cd /etc/nixos/nixos-config
sudo nixos-rebuild switch --flake .#nix-btw
```

On a brand-new machine, run the first rebuild with flake config enabled so the CachyOS binary caches in `flake.nix` are used immediately:

```bash
sudo nixos-rebuild switch --flake .#nix-btw --accept-flake-config
```

If you want the repository to live in the user's home directory after installation, run the post-install script:

```bash
cd /etc/nixos/nixos-config
sudo ./hosts/nix-btw/post-install.sh
```

The script currently does the following:

- resolves the target user's home directory
- moves `/etc/nixos/nixos-config` to `/home/vijeth/nixos-config` if the home copy does not already exist
- creates the DMS and Niri user config directories if needed
- syncs the tracked DMS JSON and KDL files into the user's config directories
- fixes ownership under the repository and `.config`

The script is idempotent:

- if the repository is already in `/home/vijeth/nixos-config`, it will not move it again
- if destination files already match, they are left unchanged
- running it multiple times is safe and only re-applies ownership and changed config files

### Applying later changes on `nix-btw`

If the repository already lives in `~/nixos-config`, rebuild from there:

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nix-btw
```

To apply only the Home Manager profile on the desktop host:

```bash
home-manager switch --flake ~/nixos-config#vijeth-nixos
```

## Server host setup (`nix-server`)

To build or switch the server profile:

```bash
sudo nixos-rebuild switch --flake .#nix-server
```

## Portable Home Manager setup

On a non-NixOS Linux system:

```bash
git clone https://github.com/VijetHegde604/nixos-config.git ~/nixos-config
cd ~/nixos-config
home-manager switch --flake .#vijeth-portable
```

The portable profile is intended for user-level tooling and avoids NixOS-only system services.

## DMS-managed files in this repository

The repository keeps these user-managed files under `DMS/`:

- `settings.json`
- `clsettings.json`
- `overrides.kdl`
- `binds.kdl`
- `windowrules.kdl`

The post-install script currently syncs:

- `settings.json`
- `clsettings.json`
- `overrides.kdl`
- `windowrules.kdl`

## Useful commands

| Task | Command |
| --- | --- |
| Rebuild desktop host | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-btw` |
| Rebuild server host | `sudo nixos-rebuild switch --flake ~/nixos-config#nix-server` |
| Apply desktop Home Manager | `home-manager switch --flake ~/nixos-config#vijeth-nixos` |
| Apply portable Home Manager | `home-manager switch --flake ~/nixos-config#vijeth-portable` |
| Update flake inputs | `nix flake update --flake ~/nixos-config` |
| Run the post-install sync | `sudo ~/nixos-config/hosts/nix-btw/post-install.sh` |

## Notes

- This is a personal configuration repository and assumes the primary desktop user is `vijeth` unless overridden via environment variables for the post-install script.
- Hardware-specific files and module selections may need adjustment before reuse on another machine.
- The post-install script is intended for local machine setup and should be run as root.
