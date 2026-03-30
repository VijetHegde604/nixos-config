{ settings, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
  users.extraGroups.vboxusers.members = [ settings.username ];
}
