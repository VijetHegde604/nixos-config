{
  disko.devices = {
    disk = {
      main = {
        # IMPORTANT: Verify this is your actual target drive
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "boot";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "root"; # Creates /dev/mapper/root
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Forces overwrite during formatting
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                    };
                    "@home" = {
                      mountpoint = "/home";
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      # Optional: mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
