{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.messengers.telegram-desktop.user;
in {
  options.modules.programs.messengers.telegram-desktop.user.enable = mkEnableOption "Telegram Desktop";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "telegram-desktop";
        paths = [pkgs.telegram-desktop];
        nativeBuildInputs = [pkgs.makeWrapper];

        # Fixed by AI: disable explicit sync for Telegram WebViews on NVIDIA and Wayland
        # https://github.com/telegramdesktop/tdesktop/issues/31055
        # https://github.com/telegramdesktop/tdesktop/issues/31424
        #
        # Maybe I can just put this in hyprland env, but idk
        postBuild = ''
          wrapProgram "$out/bin/Telegram" \
            --set __NV_DISABLE_EXPLICIT_SYNC 1

          service=share/dbus-1/services/org.telegram.desktop.service
          rm "$out/$service"
          substitute "${pkgs.telegram-desktop}/$service" "$out/$service" \
            --replace-fail "${pkgs.telegram-desktop}/bin/Telegram" "$out/bin/Telegram"
        '';
      })
    ];
  };
}
