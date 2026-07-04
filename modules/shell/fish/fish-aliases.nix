let
  dotfilesPath = "~/nixos-dotfiles";
in {
  # FIXME: add cd aliases
  btw = "echo I use NixOS, btw";

  # NixOS
  nixos-switch = "sudo nixos-rebuild switch --flake ${dotfilesPath}#desktop";
  nixos-test = "sudo nixos-rebuild test --flake ${dotfilesPath}#desktop";
  nixos-vm = "sudo nixos-rebuild build-vm --flake ${dotfilesPath}#desktop";

  # Nix
  nix-update = "dt && nix flake update";
  nix-search = "nix search nixpkgs";
  nix-gc = "sudo nix-store --gc";

  # Replace ls & tree with eza
  # a - all, l - long
  ls = "eza -al --color=always --group-directories-first --icons=always";
  la = "eza -a  --color=always --group-directories-first --icons=always";
  lt = "eza -aT --color=always --group-directories-first --icons=always";
  ld = "eza -a  --color=never | rg '^\.'";
  tree = "lt";

  # Replace grep with ripgrep
  grep = "rg";
  rgi = "rg --ignore-case";
  rgl = "rg --files-with-matches";

  # Replace rm with trashy
  fm = "rm";
  rm = "trash";
  rml = "trash list";
  rmr = "trash restore";
  rme = "trash empty";

  # Replace cat with bat
  cat = "bat --color=always --wrap=never --plain";

  # tar
  untar = "tar -axvf";
  tarnow = "tar -acf";

  # Directories
  dt = "cd ${dotfilesPath}";

  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # Other
  exp = "nemo -t $PWD"; # Open nemo EXPlorer in current folder
  mkdir = "mkdir -p";
  wget = "wget -c";
  myip = "curl api.ipify.org";
  please = "sudo";
}
