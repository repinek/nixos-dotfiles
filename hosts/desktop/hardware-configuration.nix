# I don't care, I will modify this file!!
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Btrfs mount options
  # subvol   - Select a Btrfs subvolume, defaults to /
  # noatime  - Do not update access time
  # atime    - Update access time on every read
  # relatime - Update access time only when it is older than modification time
  # compress - Enable transparent compression (LZO, ZSTD, or Zlib), use zstd:[1-19] for a level
  # discard  - Enable asynchronous TRIM
  # ro       - Mount read-only

  # Discover filesystem UUIDs with lsblk --fs

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@log"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@nix"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E115-5AB8";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/home/repinek/Media" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@home/repinek/Media" "noatime" "compress=zstd"];
    };

    "/home/repinek/Programming" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@home/repinek/Programming" "noatime" "compress=zstd"];
    };

    "/home/repinek/Personal" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@home/repinek/Personal" "noatime" "compress=zstd"];
    };

    "/home/repinek/Games" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvol=@home/repinek/Games" "noatime" "compress=zstd"];
    };

    # Secondary backup drive
    "/mnt/Old" = {
      device = "/dev/disk/by-uuid/a224ed41-0f38-47b5-baa8-8f318d3a8cfa";
      fsType = "btrfs";
      options = ["subvol=/" "noatime" "compress=zstd"];
    };

    # Used by btrbk to snapshot source subvolumes
    "/btrfs" = {
      device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
      fsType = "btrfs";
      options = ["subvolid=5" "noatime" "compress=zstd"];
    };
  };

  swapDevices = [];
  zramSwap = {
    enable = true;
    memoryPercent = 100; # 32 GB on this machine
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
