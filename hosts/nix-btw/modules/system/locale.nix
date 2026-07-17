{ settings,pkgs, ... }:

{
  time.timeZone = settings.timezone;
  i18n.defaultLocale = settings.locale;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-mozc fcitx5-gtk];
  };
}
