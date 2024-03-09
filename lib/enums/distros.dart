enum DISTROS {
  UBUNTU,
  LINUX_MINT,
  DEBIAN,
  POPOS,
  MXLINUX,
  ZORINOS,
  KDENEON,
  OPENSUSE,
  LMDE,
  FEDORA,
  ARCH,
  MANJARO,
  ENDEAVOUR,
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
    case DISTROS.KDENEON:
      return "KDE neon";
    case DISTROS.OPENSUSE:
      return "openSUSE";
    case DISTROS.LMDE:
      return "LMDE";
    case DISTROS.FEDORA:
      return "Fedora";
    case DISTROS.ARCH:
      return "Arch";
    case DISTROS.MANJARO:
      return "Manjaro";
    case DISTROS.ENDEAVOUR:
      return "EndeavourOS";
    default:
      return "";
  }
}

DISTROS getEnumFromString(String str) {
  return DISTROS.values.firstWhere((e) => e.name == str);
}
