{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.programs.nemo.user.enable {
    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file://${config.home.homeDirectory}/.config .config
      file://${config.home.homeDirectory}/.local .local
      file://${config.home.homeDirectory}/Programming Programming
      file://${config.home.homeDirectory}/Personal Personal
      file://${config.home.homeDirectory}/Media Media
      file://${config.home.homeDirectory}/Games Games
      file:///mnt/Old Old
    '';
  };
}
