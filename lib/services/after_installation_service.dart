import 'package:linux_assistant/services/linux.dart';

class AfterInstallationService {
  static bool firefox = false;
  static bool chromium = false;
  static bool googleChrome = false;

  static bool libreOffice = false;
  static bool onlyOffice = false;
  static bool wpsOffice = false;

  static void applyCurrentBrowserSituation() async {
    Linux.ensureApplicationInstallation(["firefox"], installed: firefox);
    Linux.ensureApplicationInstallation(["chromium"], installed: chromium);
    Linux.ensureApplicationInstallation(
        ["google-chrome-stable", "com.google.Chrome"],
        installed: googleChrome);
  }

  static void applyCurrentOfficeSituation() async {
    Linux.ensureApplicationInstallation(["libreoffice-common"],
        installed: libreOffice);
    Linux.ensureApplicationInstallation(
        ["org.onlyoffice.desktopeditors", "onlyoffice-desktopeditors"],
        installed: onlyOffice);
    Linux.ensureApplicationInstallation(["com.wps.Office"],
        installed: wpsOffice);
  }
}
