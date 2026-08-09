{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editors.ida-pro.user;
in {
  options.modules.editors.ida-pro.user.enable = mkEnableOption "IDA Pro - disassembler and debugger";

  config = mkIf cfg.enable {
    home.packages = [pkgs.ida-pro];

    # ida-pro-mcp plugin
    home.file.".idapro/plugins/ida_mcp.py".source = "${pkgs.ida-pro-mcp}/lib/ida-pro-mcp/ida_mcp.py";
    home.file.".idapro/plugins/ida_mcp".source = "${pkgs.ida-pro-mcp}/lib/ida-pro-mcp/ida_mcp";

    # IDA can't find python, so we pointing it here
    home.activation.ida-python = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.ida-pro}/opt/ida-pro-9.2/idapyswitch --force-path ${pkgs.python314}/lib/libpython3.14.so
    '';
  };
}
