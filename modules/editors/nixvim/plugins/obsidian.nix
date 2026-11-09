{ pkgs, ... }: {
  plugins.obsidian = {
    enable = true;
    settings = {
      legacy_commands = false;

      workspaces = [
        {
          name = "Obsidian";
          path = "~/Personal/Obsidian";
        }
      ];
    };
  };

  extraPackages = [
    pkgs.ripgrep
  ];
}
