_: {
  programs.noctalia.settings = {
    control_center = {
      sidebar = "full"; # Consider exposing this as an option for laptops
      width = 800; # Consider exposing this as an option for laptops

      # Noctalia supports at most six shortcuts
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
