enum DESKTOPS {
  GNOME,
  CINNAMON,
  KDE,
  XFCE,
}

DESKTOPS getDektopEnumOfString(str) {
  return DESKTOPS.values.firstWhere((e) => e.toString() == str);
}
