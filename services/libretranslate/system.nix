{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.libretranslate.system;
in {
  options.services.libretranslate.system.enable = mkEnableOption "LibreTranslate";

  config = mkIf cfg.enable {
    services.libretranslate = {
      enable = true;

      host = "127.0.0.1";
      port = 5000;

      updateModels = true;

      extraArgs = {
        disable-files-translation = true;
        url-prefix = "translate";
        load-only = "en,ru,uk,zh";
      };
    };
  };
}
