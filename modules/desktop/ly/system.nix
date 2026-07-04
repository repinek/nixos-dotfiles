{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.ly.system;
in {
  options.modules.desktop.ly.system = {
    enable = mkEnableOption "ly Display Manager";
    remove_brightness_keys = mkEnableOption "Remove brightness keys";
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;

      settings = mkMerge [
        {
          hide_version_string = true;
          clock = "%d/%m %H:%M:%S";

          full_color = true;
          animation = "dur_file";
          dur_file_path = "/etc/ly/blackhole-smooth-240x67.dur";
        }
        (mkIf cfg.remove_brightness_keys {
          brightness_up_key = null;
          brightness_down_key = null;
        })
      ];
    };

    environment.etc."ly/blackhole-smooth-240x67.dur".source = ./../../../assets/ly/blackhole-smooth-240x67.dur;
  };
}
