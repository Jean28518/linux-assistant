import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/services/linux.dart';

class AfterInstallationService {
  static bool firefox = false;
  static bool chromium = false;
  static bool brave = false;
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

  static bool applyUpdatesSinceRelease = true;
  static bool installMultimediaCodecs = true;
  static bool setupAutomaticSnapshots = true;
  // This will only be automatically set to true, if nvidia card is installed on system:
  static bool installNvidiaDrivers = false;
  static bool setupAutomaticUpdates = true;

  static Future<void> applyCurrentBrowserSituation() async {
    await Linux.ensureApplicationInstallation(["firefox", "firefox-esr"],
        installed: firefox);

    if (Linux.currentenvironment.distribution == DISTROS.UBUNTU ||
        Linux.currentenvironment.distribution == DISTROS.POPOS) {
      // Chromium for Ubuntu (snap):
      await Linux.ensureApplicationInstallation(
          ["chromium-browser", "org.chromium.Chromium"],
          installed: chromium);
    } else {
      // Chromium for others:
      await Linux.ensureApplicationInstallation(
          ["chromium", "org.chromium.Chromium"],
          installed: chromium);
    }

    await Linux.ensureApplicationInstallation(["com.brave.Browser"],
        installed: brave);

    await Linux.ensureApplicationInstallation(
        ["google-chrome-stable", "com.google.Chrome"],
        installed: googleChrome);
  }

  static Future<void> applyCurrentOfficeSituation() async {
    Linux.ensureApplicationInstallation(
        ["libreoffice-common", "org.libreoffice.LibreOffice"],
        installed: libreOffice);
    Linux.ensureApplicationInstallation(
        ["org.onlyoffice.desktopeditors", "onlyoffice-desktopeditors"],
        installed: onlyOffice);
    Linux.ensureApplicationInstallation(["com.wps.Office"],
        installed: wpsOffice);
  }

  static Future<void> applyCommunicationSituation() async {
    Linux.ensureApplicationInstallation(
        ["thunderbird", "org.mozilla.Thunderbird"],
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

  static void applyAutomaticConfiguration() {
    Linux.applyAutomaticConfigurationAfterInstallation(
        applyUpdatesSinceRelease: applyUpdatesSinceRelease,
        installMultimediaCodecs_: installMultimediaCodecs,
        installNvidiaDriversAutomatically: installNvidiaDrivers,
        setupAutomaticSnapshots: setupAutomaticSnapshots,
        setupAutomaticUpdates: setupAutomaticUpdates);
  }
}
