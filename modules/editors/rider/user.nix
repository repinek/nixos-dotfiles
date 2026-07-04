{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.rider.user;
in {
  options.modules.editors.rider.user.enable = mkEnableOption "JetBrains Rider";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [jetbrains.rider dotnet-sdk_8 dotnetCorePackages.sdk_8_0];

    home.sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    };
  };
}
