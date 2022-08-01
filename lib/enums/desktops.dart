enum DESKTOPS {
  GNOME,
  CINNAMON,
  KDE,
  XFCE,
}

String getStringOfDesktopEnum(var desktop) {
  switch (desktop) {
    case DESKTOPS.GNOME:
      return "GNOME";
    case DESKTOPS.CINNAMON:
      return "CINNAMON";
    case DESKTOPS.KDE:
      return "KDE";
    case DESKTOPS.XFCE:
      return "XFCE";

    default:
      return "";
  }
}
