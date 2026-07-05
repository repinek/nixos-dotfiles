# repinek's NixOS dotfiles
Declarative [NixOS](https://nixos.org) config for personal use. 

## Screenshots

<img src="assets/screenshots/screenshot_1.png" width="700" alt="Rose Pine Theme, Noctalia Shell, Hyprland, Alacritty and Control Center">
<img src="assets/screenshots/screenshot_2.png" width="700" alt="Creamy Forest Theme, Noctalia Shell, Hyprland, Nemo and Media">

## Features and Main Packages
- Flake-based with fully modular system
- Supports multiple hosts and users
- Fully configured desktop experience with Hyprland and Noctalia Shell
- Theme management with Noctalia Shell: handles wallpapers, GTK, Qt5/6, btop, Alacritty, fastfetch, Hyprland, VSCodium 
- A lot of useful [aliases](modules/shell/fish/fish-aliases.nix)
- Ergonomic [keybindings](modules/desktop/hypr/hyprland/keybinds.nix) for Hyprland

### Programs
- WM: Hyprland  
- Desktop Shell: Noctalia Shell  
- Terminal: Alacritty  
- Shell: fish
- File Manager: Nemo
- Messengers:  
    - Telegram desktop  
    - Vesktop (Discord)
    - TODO: Element
- Editors:  
    - Rider (not configured yet)  
    - VSCodium  
    - Vim (not configured yet)  
    - opencode CLI
    - _TODO Neovim_
- Browsers:
    - Waterfox (3-rd party flake)
    - ungoogled-chromium
- VPN Client: Throne (powered by sing-box)
- Games: 
    - osu!lazer _(w/ gammastep)_
    - Steam
    - _TODO gamemoded_
- Other Utilities with GUI:
    - OBS Studio
- Other CLI Utilities:
    - btrfs related, gh, git, ssh, fastfetch, platform-tools (adb and fastboot), [see more](modules/core/packages/)

_TODO: add links_

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
- [ ] Configure Dissasembler (IDA Pro, but maybe I should give a try to Ghidra)
- [ ] Configure Element
- [ ] Configure Rider
- [ ] Configure Neovim
- [ ] Configure MIME types

Also, there's a lot of `FIXME` comments 

## License
This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.

## Credits
[datsfilipe dotfiles](https://github.com/datsfilipe/dotfiles) - Highly inspired  
[Ruject nixos-infra](https://git.ruject.fun/RuJect/nixos-infra)
