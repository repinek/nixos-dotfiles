{...}: {
  programs.noctalia.settings = {
    idle = {
      pre_action_fade_seconds = 0;

      # lock - 5 minutes, screenoff - 10 minutes, lock and suspend - disabled
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
