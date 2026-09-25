{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.games.osu-lazer.user;
in {
  options.modules.games.osu-lazer.user.enable = mkEnableOption "osu!lazer";

  config = mkIf cfg.enable {
    home.packages = [
      # Play with Double Time
      (pkgs.gammastep.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            rm -f $out/share/applications/gammastep-indicator.desktop
          '';
    }))];

    programs.osu-lazer = {
      enable = true;

      nativeWayland = true;
      extraShellArgs = [ 
        "--set" "OSU_SDL3" "1"
        "--set" "SDL_VIDEO_DOUBLE_BUFFER" "1"
      ];
      channel = "tachyon";

      storagePath = "/home/repinek/Games/osu!";

      files."/home/repinek/Games/osu!" = {
        gameSettings = {
          # General
          Prefer24HourTime = true;
          ReleaseStream = "Tachyon";

          # Input
          MouseDisableButtons = true;
          MouseDisableWheel = true;

          # User Interface
          UIHoldActivationDelay = 0.0;
          IntroSequence = "Random";
          SeasonalBackgroundMode = "Always";
          ShowConvertedBeatmaps = false;
          ModSelectHotkeyStyle = "Classic";
          ModSelectTextSearchStartsActive = false;
          SongSelectBackgroundBlur = true;

          # Gameplay
          HitLighting = false;
          StarFountains = false; 
          DimLevel = 1.0;
          FadePlayfieldWhenHealthLow = false; 
          BeatmapSkins = false;
          BeatmapColours = false;
          BeatmapHitsounds = false;
          ShowStoryboard = false;
          KeyOverlay = true;
          GameplayLeaderboard = false;          
          AutoCursorSize = false;
          # Scroll speed mania 26.5

          # Graphics
          UIScale = 0.95;

          # Online
          PreferNoVideo = true;
          ShowOnlineExplicitContent = true;
          NotifyOnFriendPresenceChange = true; 

          # Not in settings
          # Song Select
          BeatmapDetailTab = "Local";

          # Beatmap listing
          BeatmapListingFeaturedArtistFilter = false; 

          # Profile
          ProfileCoverExpanded = false;

          # Editor
          EditorDim = 1.0;

          # Multiplayer
          MultiplayerRoomFilter = "Public";
        };

        frameworkSettings = {
          FrameSync = "Unlimited";
          Locale = "ua";
        };
      };
    };
  };
}
