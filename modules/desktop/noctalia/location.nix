_: {
  programs.noctalia.settings = {
    location = {
      auto_locate = false; # A VPN makes automatic location unreliable

      # Used for weather and night light
      address = "Yekaterinburg, Russia";
      latitude = 56.8355;
      longitude = 60.6061;
    };
  };
}
