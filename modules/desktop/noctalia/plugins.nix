_: {
  programs.noctalia.settings.plugins = {
    source = [
      {
        king = "git";
        location = "https://github.com/repinek/noctalia-plugins";
        name = "repinek-plugins";
        auto_update = true;
      }
    ];
    enabled = ["repinek/screentime-widget"];
  };
}
