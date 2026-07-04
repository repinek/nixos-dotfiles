{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.hid.system;
in {
  # FIXME: move to certain host, don't make this global module
  options.modules.hardware.hid.system.enable = mkEnableOption "udev rules for HID devices";

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      # Explored by usbutils lsusb
      # 352d:2383 Drunkdeer A75 Pro ANSI
      KERNEL=="hidraw*", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0660", GROUP="users", TAG+="uaccess"

      # 3554:f5f7 Compx SCYROX V8 Dongle
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f7", MODE="0660", GROUP="users", TAG+="uaccess"

      # 3554:f5f6 Compx SCYROX V8
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f5f6", MODE="0660", GROUP="users", TAG+="uaccess"
    '';
  };
}
