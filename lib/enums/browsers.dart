enum BROWSERS {
  FIREFOX,
  CHROMIUM,
  CHROME,
  EDGE,
  BRAVE,
  OPERA,
}

BROWSERS getBrowserEnumOfString(str) {
  return BROWSERS.values.firstWhere((e) => e.toString() == str);
}
