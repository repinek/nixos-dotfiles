{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.editors.obsidian.user.enable {
    programs.obsidian.vaults."Personal/Obsidian".settings = {};
  };
}
