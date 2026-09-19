# Programs

Note: Most descriptions were written by AI.

`*` - unfree, proprietary, or non-redistributable software.

## Desktop

- [Hyprland](https://github.com/hyprwm/Hyprland) - Fully configured Wayland compositor. [Configuration](../modules/desktop/hypr/)
- [Noctalia Shell](https://github.com/noctalia-dev/noctalia) - Desktop shell handling the bar, control centre, notifications, lock screen, wallpapers, and themes. [Configuration](../modules/desktop/noctalia/)
- [Ly](https://github.com/fairyglade/ly) - Terminal display manager. [Configuration](../modules/desktop/ly/system.nix)
- [Alacritty](https://github.com/alacritty/alacritty) - Terminal emulator. [Configuration](../modules/programs/alacritty/user.nix)
- [Nemo](https://github.com/linuxmint/nemo) - File manager with extensions, archive integration, previews, and video thumbnails. [Configuration](../modules/programs/nemo/user.nix)
- [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) and [qt6ct](https://github.com/trialuser02/qt6ct) - GTK and Qt theming support. [Configuration](../modules/desktop/theme/user.nix)

## Browsers

- [LibreWolf](https://codeberg.org/librewolf/source) - A custom version of Firefox focused on privacy, security, and freedom, with a declarative configuration. [Configuration](../modules/programs/browsers/librewolf/user.nix)
- [ungoogled-chromium](https://github.com/ungoogled-software/ungoogled-chromium) - Google Chromium without Google integration. [Configuration](../modules/programs/browsers/ungoogled-chromium/user.nix)

## CLI

- [fish](https://github.com/fish-shell/fish-shell) - Interactive shell with aliases and custom functions. [Configuration](../modules/shell/fish/)
- [Starship](https://github.com/starship/starship) - Shell prompt. [Configuration](../modules/shell/starship/)
- [Git](https://github.com/git/git) - [Configuration](../modules/cli/git/user.nix)
- [GitHub CLI](https://github.com/cli/cli) - Command-line client for GitHub. [Configuration](../modules/cli/gh/user.nix)
- [OpenSSH](https://github.com/openssh/openssh-portable) - [Configuration](../modules/cli/ssh/)
- [GnuPG](https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git) - [Configuration](../modules/cli/gpg/user.nix)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch) - [Configuration](../modules/cli/fastfetch/)
- [direnv](https://github.com/direnv/direnv), [nix-direnv](https://github.com/nix-community/nix-direnv), and [nixd](https://github.com/nix-community/nixd) - Automatic Nix development environments and a language server. [Configuration](../modules/core/packages/user.nix)
- [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [ripgrep](https://github.com/BurntSushi/ripgrep), [jq](https://github.com/jqlang/jq), and [trashy](https://github.com/oberblastmeister/trashy) - Command replacements and shell utilities. [Configuration](../modules/core/packages/user.nix)
- [scrcpy](https://github.com/Genymobile/scrcpy) and [Android platform tools](https://android.googlesource.com/platform/tools/base/) - Display, control, and debug Android devices. [Configuration](../modules/cli/scrcpy/user.nix), [platform tools](../modules/cli/platform-tools/system.nix)

## Editors and development

- [VSCodium](https://github.com/VSCodium/vscodium) - Binary releases of VS Code without Microsoft branding, telemetry, or licensing, with a declarative configuration. [Configuration](../modules/editors/vscodium/user.nix)
- [Vim](https://github.com/vim/vim) - Text editor with a declarative configuration. [Configuration](../modules/editors/vim/user.nix)
- [Zed](https://github.com/zed-industries/zed) - Code editor. [Configuration](../modules/editors/zed/user.nix)
- [Rider](https://www.jetbrains.com/rider/)* and .NET SDK 8 - JetBrains .NET IDE and .NET SDK. [Configuration](../modules/editors/rider/user.nix)
- [Codex](https://github.com/openai/codex) - Coding agent that runs in the terminal. [Configuration](../modules/editors/codex/user.nix), [settings](../users/repinek/settings/codex/user.nix)
- [OpenCode](https://github.com/anomalyco/opencode/) - Coding agent CLI. [Configuration](../modules/editors/opencode/user.nix)
- [IDA Pro](https://hex-rays.com/ida-pro)* with [ida-pro-mcp](https://github.com/mrexodia/ida-pro-mcp) - A powerful disassembler, decompiler, and versatile debugger with an MCP integration. [Configuration](../modules/editors/ida-pro/user.nix)
- [JADX](https://github.com/skylot/jadx) - Dex-to-Java decompiler. [Configuration](../modules/editors/jadx/user.nix)
- [Detect It Easy](https://github.com/horsicq/Detect-It-Easy) - Program for determining file types. [Configuration](../modules/editors/detect-it-easy/user.nix)

## Communication

- [Telegram Desktop](https://github.com/telegramdesktop/tdesktop) - [Configuration](../modules/programs/messengers/telegram-desktop/user.nix)
- [Vesktop](https://github.com/Vencord/Vesktop) - Discord client with [Vencord](https://github.com/Vendicated/Vencord). [Configuration](../modules/programs/messengers/vesktop/user.nix)
- [Element](https://github.com/element-hq/element-web) - Matrix client. [Configuration](../modules/programs/messengers/element-desktop/user.nix)
- [Obsidian](https://obsidian.md)* - Note-taking app whose vault is synchronized with Syncthing. [Configuration](../modules/programs/obsidian/user.nix), [settings](../users/repinek/settings/obsidian/user.nix)
- [Anki](https://github.com/ankitects/anki) - Smart spaced-repetition flashcards. [Configuration](../modules/programs/anki/user.nix), [settings](../users/repinek/settings/anki/user.nix)

## Security and wallets

- [KeePassXC](https://github.com/keepassxreboot/keepassxc) - Password manager. [Configuration](../modules/programs/keepassxc/user.nix)
- [Proton Authenticator](https://github.com/ProtonMail/WebClients/) - [Configuration](../modules/programs/proton-authenticator/user.nix)
- [Throne](https://github.com/throneproj/Throne) - VPN client powered by [sing-box](https://github.com/SagerNet/sing-box). [Configuration](../modules/programs/throne/system.nix)
- [Feather](https://github.com/feather-wallet/feather) - Monero wallet. [Configuration](../modules/programs/feather/user.nix)

## Media and utilities

- [OBS Studio](https://github.com/obsproject/obs-studio) - Software for live streaming and screen recording. [Configuration](../modules/programs/obs-studio/user.nix)
- [Audacity](https://github.com/audacity/audacity) - Audio editor. [Configuration](../modules/programs/audacity/user.nix)
- [LosslessCut](https://github.com/mifi/lossless-cut) - Lossless audio and video cutting. [Configuration](../modules/programs/losslesscut/user.nix)
- [Loupe](https://gitlab.gnome.org/GNOME/loupe) - Image viewer. [Configuration](../modules/programs/loupe/)
- [Showtime](https://gitlab.gnome.org/GNOME/showtime) - Video player. [Configuration](../modules/programs/showtime/)
- [Krita](https://github.com/kde/krita) - Digital painting application. [Configuration](../modules/programs/krita/user.nix)
- [LibreOffice](https://github.com/LibreOffice/core) - Office suite. [Configuration](../modules/programs/libreoffice/user.nix)
- [LocalSend](https://github.com/localsend/localsend) - File and message sharing over a local network. [Configuration](../modules/programs/localsend/system.nix)
- [qBittorrent](https://github.com/qbittorrent/qBittorrent) - [Configuration](../modules/programs/qbittorrent/user.nix)
- [GNOME Disk Utility](https://gitlab.gnome.org/GNOME/gnome-disk-utility) - Disk management utility. [Configuration](../modules/programs/gnome-disk-utility/user.nix)
- [Filelight](https://github.com/KDE/filelight) - Disk-usage visualizer. [Configuration](../modules/programs/filelight/user.nix)

## Games

- [Steam](https://store.steampowered.com/about/)* - [Configuration](../modules/games/steam/system.nix)
- [GameMode](https://github.com/FeralInteractive/gamemode) - [Configuration](../modules/games/gamemode/system.nix)
- [osu!lazer](https://github.com/ppy/osu)* - Rhythm game with [Gammastep](https://github.com/chinstrap/gammastep). [Configuration](../modules/games/osu-lazer/user.nix)
- [steamguard-cli](https://github.com/dyc3/steamguard-cli) - [Configuration](../modules/games/steamguard-cli/user.nix)
- [Touhou thcrap wrapper](https://github.com/nerusuki/thcrap-steam-proton-wrapper) - Steam Proton launcher using [thcrap](https://github.com/thpatch/thcrap), [neopatch](https://github.com/astral4/neopatch) and [thprac](https://github.com/touhouworldcup/thprac). [Configuration](../modules/games/touhou/user.nix)

## System tools

- `btop`, `strace`, `lsof`, `pciutils`, `psmisc`, `parted`, `file`, and `usbutils` - System maintenance tools. [Configuration](../modules/core/packages/system.nix)
- `git`, `wget`, `curl`, `zip`, `unzip`, `p7zip`, `rsync`, and `ffmpeg` - Base command-line utilities. [Configuration](../modules/core/packages/system.nix)
- [btrfs-progs](https://github.com/kdave/btrfs-progs) and [btrfs-list](https://github.com/speed47/btrfs-list) - Btrfs filesystem tools. [Configuration](../modules/core/btrfs/system.nix)
- `libva-utils` and `mesa-demos` - GPU and video-acceleration tools. [Configuration](../modules/hardware/nvidia/system.nix)

## Services

- [GNOME Keyring](https://gitlab.gnome.org/GNOME/gnome-keyring) - Credential storage for the system and user session. [Configuration](../services/gnome-keyring/)
- [Docker](https://github.com/moby/moby) - Rootless container runtime. [Configuration](../users/repinek/system.nix)
- [Syncthing](https://github.com/syncthing/syncthing) - Continuous file synchronization. [Configuration](../services/syncthing/system.nix)
- [LibreTranslate](https://github.com/LibreTranslate/LibreTranslate) - Local machine-translation service. [Configuration](../services/libretranslate/system.nix)
- [btrbk](https://github.com/digint/btrbk) and `rsync` - Daily Btrfs snapshots and incremental backups. [Configuration](../services/backup/system.nix)
- Nix garbage collection, store optimisation, and old-generation cleanup. [Configuration](../services/nix-gc/system.nix)
