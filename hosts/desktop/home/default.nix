{...}: {
  imports = [
    ../../../modules/cli/gh/user.nix
    ../../../modules/cli/scrcpy/user.nix
    ../../../modules/cli/ssh/user.nix

    ../../../modules/desktop/hypr/user.nix
    ../../../modules/desktop/noctalia/user.nix
    ../../../modules/desktop/theme/user.nix

    ../../../modules/editors/detect-it-easy/user.nix
    ../../../modules/editors/jadx/user.nix
    ../../../modules/editors/rider/user.nix
    ../../../modules/editors/vscodium/user.nix

    ../../../modules/games/osu-lazer/user.nix

    ../../../modules/programs/alacritty/user.nix
    ../../../modules/programs/browsers/ungoogled-chromium/user.nix
    ../../../modules/programs/browsers/waterfox/user.nix
    ../../../modules/programs/losslesscut/user.nix
    ../../../modules/programs/messengers/element-desktop/user.nix
    ../../../modules/programs/messengers/telegram-desktop/user.nix
    ../../../modules/programs/messengers/vesktop/user.nix
    ../../../modules/programs/nemo/user.nix
    ../../../modules/programs/obs-studio/user.nix

    ../../../modules/services/gnome-keyring/user.nix
  ];

  modules.cli = {
    gh.user.enable = true;
    scrcpy.user.enable = true;
    ssh.user.enable = true;
  };

  modules.desktop = {
    hypr.user = {
      enable = true;
      hyprshot.enable = true;
      hyprpicker.enable = true;
    };

    noctalia.user.enable = true;
    theme.user.enable = true;
  };

  modules.editors = {
    detect-it-easy.user.enable = true;
    jadx.user.enable = true;
    rider.user.enable = true;
    vscodium.user.enable = true;
  };

  modules.games = {
    osu-lazer.user.enable = true;
  };

  modules.programs = {
    alacritty.user.enable = true;
    browsers = {
      ungoogled-chromium.user.enable = true;
      waterfox.user.enable = true;
    };
    losslesscut.user.enable = true;
    messengers = {
      element-desktop.user.enable = true;
      telegram-desktop.user.enable = true;
      vesktop.user.enable = true;
    };
    nemo.user.enable = true;
    obs-studio.user.enable = true;
  };

  modules.services.gnome-keyring.user.enable = true;
}
