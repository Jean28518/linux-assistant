import 'package:linux_assistant/services/linux.dart';

class AfterInstallationService {
  static bool firefox = false;
  static bool chromium = false;
  static bool googleChrome = false;

  static bool libreOffice = false;
  static bool onlyOffice = false;
  static bool wpsOffice = false;

  static bool thunderbird = false;
  static bool jitsiMeet = false;
  static bool element = false;
  static bool discord = false;
  static bool zoom = false;
  static bool microsoftTeams = false;

  static bool installMultimediaCodecs = true;
  static bool setupAutomaticSnapshots = true;
  // This will only be automatically set to true, if nvidia card is installed on system:
  static bool installNvidiaDrivers = false;
  static bool setupAutomaticUpdates = true;

  static void applyCurrentBrowserSituation() async {
    Linux.ensureApplicationInstallation(["firefox", "firefox-esr"],
        installed: firefox);
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

  static void applyCommunicationSituation() async {
    Linux.ensureApplicationInstallation(["thunderbird"],
        installed: thunderbird);
    Linux.ensureApplicationInstallation(["org.jitsi.jitsi-meet"],
        installed: jitsiMeet);
    Linux.ensureApplicationInstallation(["im.riot.Riot", "element-desktop"],
        installed: element);
    Linux.ensureApplicationInstallation(["com.discordapp.Discord", "discord"],
        installed: discord);
    Linux.ensureApplicationInstallation(["us.zoom.Zoom", "zoom-client"],
        installed: zoom);

    /// Here the snap is preferred, because it is offically supported by Microsoft.
    Linux.ensureApplicationInstallation(["teams", "com.microsoft.Teams"],
        installed: microsoftTeams);
  }

  static void applyAutomaticConfiguration() async {
    Linux.applyAutomaticConfigurationAfterInstallation(
        installMultimediaCodecs_: installMultimediaCodecs,
        installNvidiaDriversAutomatically: installNvidiaDrivers,
        setupAutomaticSnapshots: setupAutomaticSnapshots,
        setupAutomaticUpdates: setupAutomaticUpdates);
  }
}
