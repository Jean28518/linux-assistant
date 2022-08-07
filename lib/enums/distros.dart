enum DISTROS {
  UBUNTU,
  LINUX_MINT,
  DEBIAN,
}

String getNiceStringOfDistrosEnum(var distro) {
  switch (distro) {
    case DISTROS.UBUNTU:
      return "Ubuntu";
    case DISTROS.LINUX_MINT:
      return "Linux Mint";
    case DISTROS.DEBIAN:
      return "Debian";
    default:
      return "";
  }
}

DISTROS getDistrosEnumOfString(str) {
  return DISTROS.values.firstWhere((e) => e.toString() == str);
}
