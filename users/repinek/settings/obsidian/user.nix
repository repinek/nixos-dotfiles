{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  obsidianPkgs = import inputs.nixpkgs-obsidian {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in {
  config = lib.mkIf config.modules.editors.obsidian.user.enable {
    programs.obsidian.package = obsidianPkgs.obsidian;
    programs.obsidian.vaults."Personal/Obsidian".settings = {};
  };
}
