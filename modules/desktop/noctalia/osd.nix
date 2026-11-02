_: {
  programs.noctalia.settings.osd = {
    background_opacity = 0.6; # Same as bar
    kinds = {
      # Don't show OSD for
      lock_keys = false; # Caps Lock, Num Lock, Scroll Lock
      nightlight = false;
    };
  };
}
