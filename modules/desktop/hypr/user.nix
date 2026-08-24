{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hypr.user;
  toLua = generators.toLua {};
  startupCommands = import ./hyprland/execs.nix {inherit lib pkgs;};
in {
  options.modules.desktop.hypr.user = {
    enable = mkEnableOption "Hypr ecosystem (Hyprland, Hyprshot, and Hyprpicker)";
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          output = mkOption {
            type = types.str;
            description = "Monitor output name or description";
          };
          mode = mkOption {
            type = types.str;
            default = "preferred";
            description = "Monitor resolution and refresh rate";
          };
          position = mkOption {
            type = types.str;
            default = "auto";
            description = "Monitor position in the virtual layout";
          };
          scale = mkOption {
            type = types.either types.number types.str;
            default = 1;
            description = "Monitor scale factor";
          };
        };
      });
      default = [];
      description = "Monitor configuration for Hyprland.";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "lua";

      settings.monitor = cfg.monitors;

      extraLuaFiles = {
        "config.init" = ./hyprland/init.lua;

        "config.env" = {
          content = ./hyprland/env.lua;
          autoLoad = false;
        };
        "config.general" = {
          content = ./hyprland/general.lua;
          autoLoad = false;
        };
        "config.helpers" = {
          content = ./hyprland/helpers.lua;
          autoLoad = false;
        };
        "config.input" = {
          content = ./hyprland/input.lua;
          autoLoad = false;
        };
        "config.keybinds" = {
          content = ./hyprland/keybinds.lua;
          autoLoad = false;
        };
        "config.rules" = {
          content = ./hyprland/rules.lua;
          autoLoad = false;
        };
        "config.variables" = {
          content = ./hyprland/variables.lua;
          autoLoad = false;
        };
      };

      extraConfig = ''
        hl.on("hyprland.start", function()
        ${concatMapStringsSep "\n" (command: "  hl.exec_cmd(${toLua command})") startupCommands}
        end)

        -- Noctalia generates ~/.config/hypr/noctalia.lua at runtime.
        local noctalia_ok, noctalia = pcall(function()
          return require("noctalia")
        end)
        if noctalia_ok then
          noctalia.apply_theme()
        end
      '';
    };

    home.packages = with pkgs; [hyprshot satty hyprpicker wl-clipboard];
  };
}
