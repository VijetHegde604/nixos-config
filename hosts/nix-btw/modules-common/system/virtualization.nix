{ pkgs, settings, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Required for Windows 11 VMs (TPM support)
    };
  };

  users.users.${settings.username}.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  # 3. Essential packages for managing VMs
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    virtiofsd
  ];

  # 4. Networking: Enable the bridge interface
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # 5. Enable SPICE for copy-paste and file sharing between host and guest
  services.spice-vdagentd.enable = true;
}
