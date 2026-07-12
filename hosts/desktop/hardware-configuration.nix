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

  # btrfs flags
  # subvol   - specify btrfs subvolume, / if none
  # noatime  - don't update access time
  # atime    - update access time every read
  # relatime - update access time only if previous atime is older than the mtime
  # compress - transparent file compression [LZO / ZSTD / Zlib]. You can also set a compression ratio by doing zstd:[1-19]
  # discard  - TRIM [async]
  # ro       - Read Only

  # Can be discovered using lsblk --fs

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

    # My second drive
    "/mnt/Old" = {
      device = "/dev/disk/by-uuid/a224ed41-0f38-47b5-baa8-8f318d3a8cfa";
      fsType = "btrfs";
      options = ["subvol=/" "ro" "noatime" "compress=zstd"];
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
