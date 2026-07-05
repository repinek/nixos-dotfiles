{pkgs, ...}: {
  users.users.repinek = {
    isNormalUser = true;
    # adbusers required from platform-tools
    extraGroups = ["wheel" "adbusers"];
    shell = pkgs.fish;
  };

  virtualisation.vmVariant = {
    users.users.repinek.password = "123";
    users.users.root.password = "123";
  };
}
