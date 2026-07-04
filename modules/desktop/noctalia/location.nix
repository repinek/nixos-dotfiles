{...}: {
  programs.noctalia.settings = {
    location = {
      auto_locate = false; # Not used since VPN

      # For weather and night light
      address = "Yekaterinburg, Russia";
      latitude = 56.8355;
      longitude = 60.6061;
    };
  };
}
