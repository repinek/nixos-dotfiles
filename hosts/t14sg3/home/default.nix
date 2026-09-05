{...}: {
  imports = [
    ../../../modules/cli/scrcpy/user.nix

    ../../../modules/desktop/hypr/user.nix
    ../../../modules/desktop/mime/user.nix
    ../../../modules/desktop/noctalia/user.nix
    ../../../modules/desktop/theme/user.nix

    ../../../modules/editors/vscodium/user.nix
    ../../../modules/editors/zed/user.nix

    ../../../modules/programs/alacritty/user.nix
    ../../../modules/programs/anki/user.nix
    ../../../modules/programs/browsers/ungoogled-chromium/user.nix
    ../../../modules/programs/browsers/waterfox/user.nix
    ../../../modules/programs/libreoffice/user.nix
    ../../../modules/programs/loupe/user.nix
    ../../../modules/programs/messengers/element-desktop/user.nix
    ../../../modules/programs/messengers/telegram-desktop/user.nix
    ../../../modules/programs/messengers/vesktop/user.nix
    ../../../modules/programs/nemo/user.nix
    ../../../modules/programs/obsidian/user.nix
    ../../../modules/programs/proton-authenticator/user.nix
    ../../../modules/programs/showtime/user.nix

    ../../../services/gnome-keyring/user.nix
  ];

  modules.cli.scrcpy.user.enable = true;

  modules.desktop = {
    hypr.user = {
      enable = true;
      monitors = [
        {
          output = "DP-3";
          mode = "2560x1440@165.0";
          position = "0x0";
          scale = 1;
        }
      ];
    };

    mime.user.enable = true;
    noctalia.user.enable = true;
    theme.user.enable = true;
  };

  modules.editors = {
    vscodium.user.enable = true;
    zed.user.enable = true;
  };

  modules.programs = {
    alacritty.user.enable = true;
    anki.user.enable = true;
    browsers = {
      ungoogled-chromium.user.enable = true;
      waterfox.user.enable = true;
    };
    libreoffice.user.enable = true;
    loupe.user.enable = true;
    messengers = {
      element-desktop.user.enable = true;
      telegram-desktop.user.enable = true;
      vesktop.user.enable = true;
    };
    nemo.user.enable = true;
    obsidian.user.enable = true;
    proton-authenticator.user.enable = true;
    showtime.user.enable = true;
  };

  services.gnome-keyring.user.enable = true;
}
