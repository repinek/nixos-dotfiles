{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.il2cpp-inspector-redux.user;
in {
  options.modules.editors.il2cpp-inspector-redux.user.enable = mkEnableOption "Il2CppInspectorRedux";

  config = mkIf cfg.enable {
    home.packages = [pkgs.il2cpp-inspector-redux];
  };
}
