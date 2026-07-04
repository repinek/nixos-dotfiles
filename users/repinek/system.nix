{pkgs, ...}: {
  users.users.repinek = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
}
