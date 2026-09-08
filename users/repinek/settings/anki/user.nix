{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.programs.anki.user.enable {
    sops.secrets."repinek/anki/username" = {};
    sops.secrets."repinek/anki/key" = {};

    programs.anki.profiles."repinek" = {
      default = true;

      sync = {
        autoSync = true;
        usernameFile = config.sops.secrets."repinek/anki/username".path;
        keyFile = config.sops.secrets."repinek/anki/key".path;
      };
    };
  };
}
