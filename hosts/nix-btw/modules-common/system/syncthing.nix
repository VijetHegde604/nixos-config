{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "vijeth";
    dataDir = "/home/vijeth/Documents";
    configDir = "/home/vijeth/.config/syncthing";

    overrideDevices = true;
    overrideFolders = true;
    openDefaultPorts = true;

    settings = {
      devices = {
        "Nix-Server" = {
          id = "KNMCRVS-4FVELJS-WYJHZYN-33RA4ZE-BHKBQ4H-TJWOHB3-ZIUHD2P-MDOSNQ3";
        };
      };
    };
  };
}
