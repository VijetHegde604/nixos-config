{ settings, ... }:
{
  # Timezone
  time.timeZone = settings.timezone;

  # Locale
  i18n.defaultLocale = settings.locale;
}
