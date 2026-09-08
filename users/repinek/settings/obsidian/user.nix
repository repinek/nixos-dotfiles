{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.programs.obsidian.user.enable {
    programs.obsidian.vaults."Personal/Obsidian".settings = {};
  };
}
