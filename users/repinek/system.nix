{pkgs, ...}: {
  users.users.repinek = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "gamemode"];
    shell = pkgs.fish;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.vmVariant = {
    users.users.repinek.password = "123";
    users.users.root.password = "123";
  };
}
