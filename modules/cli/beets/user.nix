{
  lib,
  config,
  ...
}: with lib;
let
  cfg = config.modules.cli.beets.user;
in {
  options.modules.cli.beets.user.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    programs.beets = {
      enable = true;
      settings = {
        library = "~/Media/Music/.beets/beets-library.db";
        directory = "~/Media/Music/Library";

        import = {
          copy = true;
          move = false;
          write = true;
          timid = true; # Ask
          resume = "ask";
          log = "~/Media/Music/.beets/beets.log";
          languages = [ "ru" "en" "ja" ];
        };

        paths = {
          # for example with goreshit
          # goreshit/2015 - tomboyish love for soda pop and apple sweets digipak/01 - ima, ai ni yukimasu
          default = "$albumartist/$year - $album%aunique{}/$track - $title";
          singleton = "$artist/$year - $title/$track - $title"; # for random songs
          comp = "Compilations/$year - $album%aunique{}/$track - $artist - $title";
        };
      };
    };
  };
}
