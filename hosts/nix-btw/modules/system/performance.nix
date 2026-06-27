{ ... }:

{
  # CachyOS-like latency tuning for an interactive desktop.
  # Keep the CachyOS kernel, but make the scheduler and VM choices explicit so
  # the machine does not silently fall back to conservative upstream defaults.
  boot.kernelParams = [
    "preempt=full"
    "split_lock_detect=off"
  ];

  boot.kernel.sysctl = {
    # Favor quick desktop response under compile/browser/game load.
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;

    # Keep file metadata hot and prevent long dirty-writeback stalls.
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 10;
    "vm.page-cluster" = 0;

    # Prefer compressed RAM over disk pressure; earlyoom below remains the guardrail.
    "vm.swappiness" = 120;

    # Match modern gaming/launcher expectations and avoid mmap-heavy app limits.
    "vm.max_map_count" = 2147483642;
  };

  services.scx = {
    enable = true;
    # CachyOS defaults to bpfland with low-latency flags; make NixOS do the same
    # instead of relying on the NixOS scx default scheduler.
    scheduler = "scx_bpfland";
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 10;
  };

  services.udev.extraRules = ''
    # Low-latency I/O defaults for fast local SSD/NVMe storage.
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
  '';

}
