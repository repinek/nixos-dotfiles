{...}: {
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
}
