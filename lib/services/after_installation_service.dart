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
    /// Start the Functions for parallel use
    Future fFirefox = Linux.ensureApplicationInstallation(
        ["firefox", "mozillafirefox", "firefox-esr"],
        installed: firefox);

    Future? fChromium;

    if (Linux.currentenvironment.distribution == DISTROS.UBUNTU ||
        Linux.currentenvironment.distribution == DISTROS.POPOS) {
      // Chromium for Ubuntu (snap):
      fChromium = Linux.ensureApplicationInstallation(
          ["chromium-browser", "org.chromium.Chromium"],
          installed: chromium);
    } else {
      // Chromium for others:
      fChromium = Linux.ensureApplicationInstallation(
          ["chromium", "org.chromium.Chromium"],
          installed: chromium);
    }

    Future fBrave = Linux.ensureApplicationInstallation(["com.brave.Browser"],
        installed: brave);

    Future fChrome = Linux.ensureApplicationInstallation(
        ["google-chrome-stable", "com.google.Chrome"],
        installed: googleChrome);

    /// We need to wait until every function has finished,
    /// because otherwise the command queue will get filled to late.
    await fFirefox;
    await fChromium;
    await fBrave;
    await fChrome;
  }

  static Future<void> applyCurrentOfficeSituation() async {
    Future fLibreOffice = Linux.ensureApplicationInstallation(
        ["libreoffice-common", "libreoffice", "org.libreoffice.LibreOffice"],
        installed: libreOffice);
    Future fOnlyOffice = Linux.ensureApplicationInstallation(
        ["org.onlyoffice.desktopeditors", "onlyoffice-desktopeditors"],
        installed: onlyOffice);
    Future fWPSOffice = Linux.ensureApplicationInstallation(["com.wps.Office"],
        installed: wpsOffice);

    await fLibreOffice;
    await fOnlyOffice;
    await fWPSOffice;
  }

  static Future<void> applyCommunicationSituation() async {
    Future fThunderbird = Linux.ensureApplicationInstallation(
        ["thunderbird", "mozillathunderbird", "org.mozilla.Thunderbird"],
        installed: thunderbird);
    Future fJitsi = Linux.ensureApplicationInstallation(
        ["org.jitsi.jitsi-meet"],
        installed: jitsiMeet);
    Future fElement = Linux.ensureApplicationInstallation(
        ["im.riot.Riot", "element-desktop"],
        installed: element);
    Future fDiscord = Linux.ensureApplicationInstallation(
        ["com.discordapp.Discord", "discord"],
        installed: discord);
    Future fZoom = Linux.ensureApplicationInstallation(
        ["us.zoom.Zoom", "zoom-client"],
        installed: zoom);

    /// Here the snap is preferred, because it is offically supported by Microsoft.
    Future fTeams = Linux.ensureApplicationInstallation(
        ["teams", "com.microsoft.Teams"],
        installed: microsoftTeams);

    await fThunderbird;
    await fJitsi;
    await fElement;
    await fDiscord;
    await fZoom;
    await fTeams;
  }

  static Future<void> applyAutomaticConfiguration() async {
    await Linux.applyAutomaticConfigurationAfterInstallation(
        applyUpdatesSinceRelease: applyUpdatesSinceRelease,
        installMultimediaCodecs_: installMultimediaCodecs,
        installNvidiaDriversAutomatically: installNvidiaDrivers,
        setupAutomaticSnapshots: setupAutomaticSnapshots,
        setupAutomaticUpdates: setupAutomaticUpdates);
  }
}
