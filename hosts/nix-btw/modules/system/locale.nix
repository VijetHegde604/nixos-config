{ settings, ... }:

{
  time.timeZone = settings.timezone;
  i18n.defaultLocale = settings.locale;
}
