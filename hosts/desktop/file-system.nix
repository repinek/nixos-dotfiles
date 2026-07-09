{...}: {
  # subvol   - specify btrfs subvolume, / if none
  # noatime  - don't update access time
  # atime    - update access time every read
  # relatime - update access time only if previous atime is older than the mtime
  # compress - transparent file compression [LZO / ZSTD / Zlib]. You can also set a compression ratio by doing zstd:[1-19]
  # discard  - TRIM [async]
  # ro       - Read Only

  # Can be discovered using lsblk --fs

  fileSystems."/home/repinek/Media" = {
    device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
    fsType = "btrfs";
    options = ["subvol=@home/repinek/Media" "noatime" "compress=zstd"];
  };

  fileSystems."/home/repinek/Programming" = {
    device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
    fsType = "btrfs";
    options = ["subvol=@home/repinek/Programming" "noatime" "compress=zstd"];
  };

  fileSystems."/home/repinek/Personal" = {
    device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
    fsType = "btrfs";
    options = ["subvol=@home/repinek/Personal" "noatime" "compress=zstd"];
  };

  fileSystems."/home/repinek/Games" = {
    device = "/dev/disk/by-uuid/096a158b-7ba7-42e1-905e-a3c09b510f4e";
    fsType = "btrfs";
    options = ["subvol=@home/repinek/Games" "noatime" "compress=zstd"];
  };

  # My second drive
  fileSystems."mnt/Old" = {
    device = "/dev/disk/by-uuid/a224ed41-0f38-47b5-baa8-8f318d3a8cfa";
    fsType = "btrfs";
    options = ["subvol=/" "ro" "noatime" "compress=zstd"];
  };
}
