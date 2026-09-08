{config, ...}: {
  sops = {
    defaultSopsFile = ../../../../secrets/repinek/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
