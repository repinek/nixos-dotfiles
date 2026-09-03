{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.rider.user;
in {
  options.modules.editors.rider.user.enable = mkEnableOption "Rider C# IDE";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [jetbrains.rider dotnet-sdk_8 ];

    home.sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    };
  };
}
