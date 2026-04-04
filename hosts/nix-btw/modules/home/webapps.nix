{ pkgs, ... }:

let
  # Pre-fetching icons so they actually show up in your launcher
  whatsappIcon = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png";
    sha256 = "sha256-onbglLXom+IuTMduXAIAtujJSghEmtwW/PEd0dSe4Pw=";
  };
  ytMusicIcon = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube-music.png";
    sha256 = "sha256-2XzJkhMPbmLjuHiD/kIh7qA9B5gZ3Uby60U2nQC2dqI=";
  };
in
{
  xdg.desktopEntries = {
    "whatsapp" = {
      name = "WhatsApp";
      genericName = "Messaging";
      exec = "xdg-open https://web.whatsapp.com"; # Fixed your URL (was excalidraw!)
      icon = "${whatsappIcon}";
      terminal = false;
      categories = [
        "Network"
        "InstantMessaging"
      ];
    };
    "youtube-music" = {
      name = "YouTube Music";
      exec = "xdg-open https://music.youtube.com";
      icon = "${ytMusicIcon}";
      type = "Application";
      categories = [
        "Audio"
        "Music"
      ];
    };
  };
}
