{pkgs, ...}: {
  users.users.repinek = {
    isNormalUser = true;
    # adbusers required from platform-tools
    extraGroups = ["wheel, adbusers"];
    shell = pkgs.fish;
  };
}
