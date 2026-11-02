{pkgs, ...}: {
  users.users.random = {
    isNormalUser = true;
    extraGroups = [];
    shell = pkgs.fish;
  };
}
