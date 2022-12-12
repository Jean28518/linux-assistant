enum DISTROS {
  UBUNTU,
  LINUX_MINT,
  DEBIAN,
  POPOS,
  MXLINUX,
  ZORINOS,
}

String getNiceStringOfDistrosEnum(var distro) {
  switch (distro) {
    case DISTROS.UBUNTU:
      return "Ubuntu";
    case DISTROS.LINUX_MINT:
      return "Linux Mint";
    case DISTROS.DEBIAN:
      return "Debian";
    case DISTROS.POPOS:
      return "Pop!_OS";
    case DISTROS.MXLINUX:
      return "MX Linux";
    case DISTROS.ZORINOS:
      return "Zorin OS";
    default:
      return "";
  }
}

DISTROS getDistrosEnumOfString(str) {
  return DISTROS.values.firstWhere((e) => e.toString() == str);
}
