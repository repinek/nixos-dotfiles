{...}: {
  programs.noctalia.settings = {
    control_center = {
      sidebar = "full"; # Maybe for laptop don't enable it, make option here
      width = 800; # Same here

      # We can have only 6
      shortcuts = [
        {type = "caffeine";}
        {type = "nightlight";}
        {type = "notification";}
        {type = "dark_mode";}
        {type = "clipboard";}
        {type = "screen_time";}
      ];
    };
  };
}
