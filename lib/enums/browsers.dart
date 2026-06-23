enum BROWSERS {
  FIREFOX,
  CHROMIUM,
  CHROME,
  EDGE,
  BRAVE,
  OPERA,
  LIBREWOLF,
  WATERFOX,
  TORBROWSER,
}

BROWSERS getBrowserEnumOfString(str) {
  return BROWSERS.values.firstWhere((e) => e.toString() == str);
}
