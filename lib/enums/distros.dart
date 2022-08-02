enum DISTROS {
  UBUNTU,
  LINUX_MINT,
}

String getStringOfDistrosEnum(var distro) {
  switch (distro) {
    case DISTROS.UBUNTU:
      return "Ubuntu";
    case DISTROS.LINUX_MINT:
      return "Linux Mint";
    default:
      return "";
  }
}
