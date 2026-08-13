{pkgs, ...}: {
  users.users.repinek = {
    isNormalUser = true;
    # adbusers is required by platform-tools
    extraGroups = ["wheel" "adbusers" "networkmanager"];
    shell = pkgs.fish;
  };

  virtualisation.vmVariant = {
    users.users.repinek.password = "123";
    users.users.root.password = "123";
  };
}
