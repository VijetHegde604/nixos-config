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
  notionIcon = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png";
    sha256 = "1wgnfflmchapad67ic3lrgz6j6xjpnqyxqvyjssnphvdk473cp9q";
  };
in
{
  xdg.desktopEntries = {
    "whatsapp" = {
      name = "WhatsApp";
      genericName = "Messaging";
      exec = "helium --app=https://web.whatsapp.com";
      icon = "${whatsappIcon}";
      terminal = false;
      categories = [
        "Network"
        "InstantMessaging"
      ];
    };
    "youtube-music" = {
      name = "YouTube Music";
      exec = "helium --app=https://music.youtube.com";
      icon = "${ytMusicIcon}";
      type = "Application";
      categories = [
        "Audio"
        "Music"
      ];
    };
    "notion" = {
      name = "Notion";
      exec = "helium --app=https://notion.so";
      icon = "${notionIcon}";
      type = "Application";
      categories = [
        "Office"
        "Utility"
      ];
    };
  };
}
