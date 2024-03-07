import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/services/linux.dart';

class AfterInstallationService {
  /// The first element in the list describes the initial recognized state,
  /// the second one the desired state of the user.
  /// Then only on different states actions will be done.
  /// This should prevent unwanted uninstalls of apps.
  static List<bool> firefox = [false, false];
  static List<bool> chromium = [false, false];
  static List<bool> brave = [false, false];
  static List<bool> googleChrome = [false, false];
  static List<bool> vivaldi = [false, false];

  static List<bool> libreOffice = [false, false];
  static List<bool> onlyOffice = [false, false];
  static List<bool> wpsOffice = [false, false];

  static List<bool> thunderbird = [false, false];
  static List<bool> jitsiMeet = [false, false];
  static List<bool> element = [false, false];
  static List<bool> signal = [false, false];
  static List<bool> discord = [false, false];
  static List<bool> zoom = [false, false];
  static List<bool> microsoftTeams = [false, false];

  static bool applyUpdatesSinceRelease = true;
  static bool installMultimediaCodecs = true;
  static bool setupAutomaticSnapshots = true;
  // This will only be automatically set to true, if nvidia card is installed on system:
  static bool installNvidiaDrivers = false;
  static bool setupAutomaticUpdates = true;

  static Future<void> applyCurrentBrowserSituation() async {
    /// Start the Functions for parallel use

    Future fFirefox = applyApplicationActionIfNecessary(
        ["firefox", "mozillafirefox", "firefox-esr"], firefox);

    Future? fChromium;

    if (Linux.currentenvironment.distribution == DISTROS.UBUNTU ||
        Linux.currentenvironment.distribution == DISTROS.POPOS) {
      // Chromium for Ubuntu (snap):
      fChromium = applyApplicationActionIfNecessary(
          ["chromium-browser", "org.chromium.Chromium"], chromium);
    } else {
      // Chromium for others:
      fChromium = applyApplicationActionIfNecessary(
          ["chromium", "org.chromium.Chromium"], chromium);
    }

    Future fBrave = applyApplicationActionIfNecessary(
        ["com.brave.Browser", "brave"], brave);

    Future fChrome = applyApplicationActionIfNecessary(
        ["google-chrome-stable", "com.google.Chrome"], googleChrome);

    Future fVivaldi = applyApplicationActionIfNecessary(
        ["vivaldi", "com.vivaldi.Vivaldi"], vivaldi);

    /// We need to wait until every function has finished,
    /// because otherwise the command queue will get filled to late.
    await fFirefox;
    await fChromium;
    await fBrave;
    await fChrome;
    await fVivaldi;
  }

  static Future<void> applyCurrentOfficeSituation() async {
    Future fLibreOffice = applyApplicationActionIfNecessary([
      "libreoffice-common",
      "libreoffice",
      "org.libreoffice.LibreOffice",
      "libreoffice-writer",
      "libreoffice-calc",
      "libreoffice-impress"
    ], libreOffice);
    Future fOnlyOffice = applyApplicationActionIfNecessary(
        ["org.onlyoffice.desktopeditors", "onlyoffice-desktopeditors"],
        onlyOffice);
    Future fWPSOffice =
        applyApplicationActionIfNecessary(["com.wps.Office"], wpsOffice);

    await fLibreOffice;
    await fOnlyOffice;
    await fWPSOffice;
  }

  static Future<void> applyCommunicationSituation() async {
    Future fThunderbird = applyApplicationActionIfNecessary(
        ["thunderbird", "mozillathunderbird", "org.mozilla.Thunderbird"],
        thunderbird);
    Future fJitsi =
        applyApplicationActionIfNecessary(["org.jitsi.jitsi-meet"], jitsiMeet);
    Future fElement = applyApplicationActionIfNecessary(
        ["im.riot.Riot", "element-desktop"], element);
    Future fSignal =
        applyApplicationActionIfNecessary(["org.signal.Signal"], signal);
    Future fDiscord = applyApplicationActionIfNecessary(
        ["com.discordapp.Discord", "discord"], discord);
    Future fZoom = applyApplicationActionIfNecessary(
        ["us.zoom.Zoom", "zoom-client"], zoom);

    /// Here the snap is preferred, because it is offically supported by Microsoft.
    Future fTeams = applyApplicationActionIfNecessary(
        ["teams", "com.microsoft.Teams"], microsoftTeams);

    await fThunderbird;
    await fJitsi;
    await fElement;
    await fSignal;
    await fDiscord;
    await fZoom;
    await fTeams;
  }

  /// Only take action, if the user clicked on the card.
  /// This should prevent unwanted app removals.
  static Future<void> applyApplicationActionIfNecessary(
      List<String> appCodes, List<bool> stateList) async {
    assert(stateList.length == 2);
    if (stateList[0] != stateList[1]) {
      return Linux.ensureApplicationInstallation(appCodes,
          installed: stateList[1]);
    }
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
