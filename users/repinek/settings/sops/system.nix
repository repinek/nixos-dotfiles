{...}: {
  sops = {
    defaultSopsFile = ../../../../secrets/repinek/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/repinek/.config/sops/age/keys.txt";
  };
}
