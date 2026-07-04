{...}: {
  programs.noctalia.settings = {
    # FIXME: BROKEN, fix with vars
    screenshot = {
      directory = "/home/repinek/Media/Screenshots/%Y-%m";
      filename_pattern = "Screenshot_%Y%m%d_%H%M%S";
      save_to_file = true;
    };
  };
}
