enum DESKTOPS {
  GNOME,
  CINNAMON,
  KDE,
  XFCE,
}

String getNiceStringOfDesktopsEnum(var desktop) {
  switch (desktop) {
    case DESKTOPS.GNOME:
      return "Gnome";
    case DESKTOPS.CINNAMON:
      return "Cinnamon";
    case DESKTOPS.KDE:
      return "KDE";
    case DESKTOPS.XFCE:
      return "Xfce";
    default:
      return "";
  }
}

DESKTOPS getDektopEnumOfString(str) {
  return DESKTOPS.values.firstWhere((e) => e.toString() == str);
}
