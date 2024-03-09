enum SOFTWARE_MANAGERS {
  FLATPAK,
  SNAP,
  APT,
  ZYPPER,
  DNF,
  PACMAN,
}

String getNiceStringOfSoftwareManagerEnum(SOFTWARE_MANAGERS input) {
  switch (input) {
    case SOFTWARE_MANAGERS.FLATPAK:
      return "Flatpak";
    case SOFTWARE_MANAGERS.SNAP:
      return "Snap";
    case SOFTWARE_MANAGERS.APT:
      return "APT";
    case SOFTWARE_MANAGERS.ZYPPER:
      return "Zypper";
    case SOFTWARE_MANAGERS.DNF:
      return "DNF";
    case SOFTWARE_MANAGERS.PACMAN:
      return "Pacman";
    default:
      return "";
  }
}

SOFTWARE_MANAGERS getSoftwareManagerEnumOfString(str) {
  return SOFTWARE_MANAGERS.values.firstWhere((e) => e.toString() == str);
}
