# repinek's NixOS dotfiles
Declarative [NixOS](https://nixos.org) configuration with Home Manager for personal use.

##### Contents
- [Screenshots](#screenshots)
- [Features](#features-and-main-packages)
    - [Programs](#programs)
- [Structure](#structure)
- [Usage](#usage)
- [TODO](#todo)
- [License](#license)
- [Credits](#credits)

## Screenshots

<img src="assets/screenshots/screenshot_1.png" width="700" alt="Rose Pine Theme, Noctalia Shell, Hyprland, Alacritty and Control Center">
<img src="assets/screenshots/screenshot_2.png" width="700" alt="Creamy Forest Theme, Noctalia Shell, Hyprland, Nemo and Media">

## Features and Main Packages
- Flake-based, mostly modular system
- Supports multiple hosts and users
- Fully configured desktop experience with Hyprland and Noctalia Shell
- Theme management with Noctalia Shell for wallpapers, GTK, Qt5/6, btop, Alacritty, Fastfetch, Hyprland, and VSCodium
- Useful [aliases](modules/shell/fish/fish-aliases.nix)
- Ergonomic [keybindings](modules/desktop/hypr/hyprland/keybinds.nix) for Hyprland
- Own [packages](pkgs/)
- Daily incremental [Btrfs backups](services/backup/) with seven-day retention
- Secret management with [sops-nix](https://github.com/Mic92/sops-nix)

### Software 
See the full list with descriptions and configuration links in [docs/SOFTWARE.md](docs/SOFTWARE.md).

## Structure

```
nixos-dotfiles
├── assets                  # Static assets: screenshots, wallpapers, etc.
├── hosts                   # per-host configuration
│   └── desktop
│       ├── settings        # Host-specific settings
│       ├── home.nix        # Home Manager configuration for this host
│       ├── system.nix      # NixOS configuration for this host
│       └── hardware-configuration.nix
├── lib                     # Helpers
│   └── mkNixos.nix
├── modules                 # Reusable system and user modules
│   ├── cli
│   ├── core
│   │   ├── boot
│   │   ├── btrfs
│   │   ├── fonts
│   │   ├── nix
│   │   ├── packages        # Base system packages
│   │   ├── security
│   │   └── system
│   ├── desktop
│   │   ├── hypr            # hypr ecosystem
│   │   │   └── hyprland
│   │   ├── ly
│   │   ├── mime
│   │   ├── noctalia
│   │   └── theme
│   ├── editors
│   ├── games
│   ├── hardware
│   │   ├── audio
│   │   └── nvidia
│   ├── programs
│   └── shell
│       └── fish
├── pkgs                    # Custom packages (Standalone flake)
│   ├── google-sans
│   ├── ida-pro
│   ├── ida-pro-mcp
│   ├── flake.nix
│   └── README.md
├── services                # Reusable services
├── users                   # per-user configuration
│   └── repinek
│       ├── settings        # User-specific settings
│       ├── home.nix        # Home Manager configuration for this user
│       └── system.nix      # NixOS configuration for this user
└── flake.nix
```

## Usage
> [!WARNING]  
> This is my personal configuration, created only for me, for my personal hardware and workflow.  
> **DO NOT COPY & PASTE IT BLINDLY**  
> Use it only as a **reference** to build and configure your own config.  

If you know what you are doing and just want to look around:
```bash
git clone https://github.com/repinek/nixos-dotfiles.git
cd nixos-dotfiles
```

## TODO

Not needed right now, just ideas for when I have free time

- [ ] Refactor core folder a little
- [ ] Try Niri one day
- [ ] Add Filezilla
- [ ] Try Neovim
- [ ] proxypin, httptoolkit* or reqable*

There are also several `FIXME` comments.

## License
This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.

## Credits
- [datsfilipe dotfiles](https://github.com/datsfilipe/dotfiles) - Architecture is heavily inspired by these dotfiles
- [Ruject nixos-infra](https://git.ruject.fun/RuJect/nixos-infra) - Some modules and architectural ideas were adapted from this project
