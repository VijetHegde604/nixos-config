{
  config,
  pkgs,
  settings,
  ...
}:

{
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  users.users.${settings.username}.extraGroups = [ "vboxusers" ];
  # virtualisation.virtualbox.guest.enable = true;
}
