{...}: {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER"; # Set win as mainMod

    bind = [
      # Open apps with mainMod + key
      "$mainMod, Q, exec, $terminal"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, B, exec, $browser"

      # Manage window with mainMod + key
      "$mainMod, C, killactive"
      "$mainMod, F, fullscreen"
      "$mainMod, Y, pin"
      "$mainMod, P, pseudo"
      "$mainMod, V, exec, toggle-float 1200 700" # Using custom script
      "$mainMod, J, layoutmsg, togglesplit"

      # Quit hyprland with mainMod + M
      "$mainMod, M, exit"

      # Noctalia IPC with mainMod + key
      "$mainMod, R, exec, noctalia msg panel-toggle launcher"
      "$mainMod, L, exec, noctalia msg session lock"

      "$mainMod SHIFT, V, exec, noctalia msg panel-toggle clipboard"
      "$mainMod SHIFT, P, exec, noctalia msg panel-toggle session"

      # Take screenshots with Print
      ",             Print, exec, noctalia msg screenshot-region"
      # FIXME: shift + print exec hyprshot region + pipes to satty
      "CTRL,         Print, exec, noctalia msg screenshot-fullscreen DP-3"
      "CTRL SHIFT,   Print, exec, hyprpicker -a -n -b -r -s 7"

      # Switch workspaces with mainMod + [1/9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"

      # Move active window to a workspace and move to that workspace with mainMod + SHIFT + [1/9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"

      # Scroll through existing workspaces with mainMod + scroll whell [up/down]
      "$mainMod, mouse_up,   workspace, e-1"
      "$mainMod, mouse_down, workspace, e+1"

      # Move focus with mainMod + arrow keys
      "$mainMod, left,  movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up,    movefocus, u"
      "$mainMod, down,  movefocus, d"

      # Move window with mainMod + SHIFT + arrow keys
      "$mainMod SHIFT, left,  movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up,    movewindow, u"
      "$mainMod SHIFT, down,  movewindow, d"

      # Magic workspace with mainMod + S
      "$mainMod,       S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace,        special:magic"
    ];

    # Bind Mouse
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Bind Locked
    bindl = [
      # Noctalia OSD
      ", XF86AudioRaiseVolume, exec, noctalia msg volume-up"
      ", XF86AudioLowerVolume, exec, noctalia msg volume-down"
      ", XF86AudioPlay,        exec, noctalia msg media toggle"
      ", XF86AudioPause,       exec, noctalia msg media toggle"
    ];
  };
}
