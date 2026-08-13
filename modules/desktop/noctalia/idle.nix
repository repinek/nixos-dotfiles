_: {
  programs.noctalia.settings = {
    idle = {
      pre_action_fade_seconds = 0;

      # Lock after 5 minutes; turn the screen off after 10; suspend is disabled
      behavior_order = ["lock" "screen-off" "lock-and-suspend"];
      behavior = {
        lock = {
          action = "lock";
          enabled = true;
          timeout = 300.0;
        };
        "lock-and-suspend" = {
          action = "lock_and_suspend";
          enabled = false;
          timeout = 900.0;
        };
        "screen-off" = {
          action = "screen_off";
          enabled = true;
          timeout = 600.0;
        };
      };
    };
  };
}
