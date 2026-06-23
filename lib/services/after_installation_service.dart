import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/models/linux_command.dart';
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
  static List<bool> librewolf = [false, false];
  static List<bool> waterfox = [false, false];
  static List<bool> torBrowser = [false, false];

  static List<bool> libreOffice = [false, false];
  static List<bool> onlyOffice = [false, false];
  static List<bool> wpsOffice = [false, false];

  static List<bool> thunderbird = [false, false];
  static List<bool> jitsiMeet = [false, false];
  static List<bool> element = [false, false];
  static List<bool> signal = [false, false];
  static List<bool> discord = [false, false];
  static List<bool> zoom = [false, false];
  static List<bool> whatsie = [false, false];
  static List<bool> telegram = [false, false];
  static List<bool> threema = [false, false];

  static List<bool> keepassxc = [false, false];
  static List<bool> bitwarden = [false, false];
  static List<bool> pikaBackup = [false, false];
  static List<bool> nextcloudClient = [false, false];
  static List<bool> vorta = [false, false];
  static List<bool> obsidian = [false, false];
  static List<bool> terminalTools = [false, false];

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
        ["brave-browser", "com.brave.Browser", "brave"], brave);

    Future fChrome = applyApplicationActionIfNecessary(
        ["google-chrome-stable", "com.google.Chrome"], googleChrome);

    Future fVivaldi = applyApplicationActionIfNecessary(
        ["vivaldi", "com.vivaldi.Vivaldi"], vivaldi);

    Future fLibreWolf = applyApplicationActionIfNecessary(
        ["librewolf", "io.gitlab.librewolf-community", "librewolf"], librewolf);

    Future fWaterfox = applyApplicationActionIfNecessary(
        ["waterfox", "net.waterfox.waterfox", "waterfox"], waterfox);

    Future fTorBrowser = applyApplicationActionIfNecessary(
        ["torbrowser-launcher", "org.torproject.torbrowser-launcher"], torBrowser);

    /// We need to wait until every function has finished,
    /// because otherwise the command queue will get filled to late.
    await fFirefox;
    await fChromium;
    await fBrave;
    await fChrome;
    await fVivaldi;
    await fLibreWolf;
    await fWaterfox;
    await fTorBrowser;
  }

  static Future<void> applyCurrentOfficeSituation() async {
    Future fLibreOffice = applyApplicationActionIfNecessary([
      "libreoffice-still",
      "libreoffice",
      "libreoffice-common",
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

    Future fWhatsie = applyApplicationActionIfNecessary(
        ["whatsie"], whatsie);
    Future fTelegram = applyApplicationActionIfNecessary(
        ["telegram-desktop", "org.telegram.desktop", "telegram-desktop"], telegram);
    Future fThreema = applyApplicationActionIfNecessary(
        ["ch.threema.threema-desktop"], threema);

    await fThunderbird;
    await fJitsi;
    await fElement;
    await fSignal;
    await fDiscord;
    await fZoom;
    await fWhatsie;
    await fTelegram;
    await fThreema;
  }

  static Future<void> applyUtilitiesSituation() async {
    Future fKeePassXC = applyApplicationActionIfNecessary(
        ["keepassxc", "org.keepassxc.KeePassXC"], keepassxc);
    Future fBitwarden = applyApplicationActionIfNecessary(
        ["bitwarden", "com.bitwarden.desktop"], bitwarden);
    Future fPika = applyApplicationActionIfNecessary(
        ["pika-backup", "org.gnome.World.PikaBackup"], pikaBackup);
    Future fNextcloud = applyApplicationActionIfNecessary(
        ["nextcloud-desktop", "nextcloud-client", "com.nextcloud.desktopclient.nextcloud"], nextcloudClient);
    Future fVorta = applyApplicationActionIfNecessary(
        ["vorta", "com.borgbase.Vorta"], vorta);
    Future fObsidian = applyApplicationActionIfNecessary(
        ["obsidian", "md.obsidian.Obsidian"], obsidian);

    Future? fTerminalTools;
    if (terminalTools[0] != terminalTools[1]) {
      if (terminalTools[1]) {
        fTerminalTools = installTerminalTools();
      } else {
        fTerminalTools = removeTerminalTools();
      }
    }

    await fKeePassXC;
    await fBitwarden;
    await fPika;
    await fNextcloud;
    await fVorta;
    await fObsidian;
    if (fTerminalTools != null) {
      await fTerminalTools;
    }
  }

  static Future<void> installTerminalTools() async {
    for (SOFTWARE_MANAGERS softwareManager in Linux.currentenvironment.installedSoftwareManagers) {
      if (softwareManager == SOFTWARE_MANAGERS.APT) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cron tree -y",
            userId: 0,
            environment: const {"DEBIAN_FRONTEND": "noninteractive"},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.ZYPPER) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive install vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.DNF) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.DNF)} install vim-enhanced ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree -y",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.PACMAN) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.PACMAN)} -S --needed --noconfirm vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
    }
  }

  static Future<void> removeTerminalTools() async {
    for (SOFTWARE_MANAGERS softwareManager in Linux.currentenvironment.installedSoftwareManagers) {
      if (softwareManager == SOFTWARE_MANAGERS.APT) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} remove vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cron tree -y",
            userId: 0,
            environment: const {"DEBIAN_FRONTEND": "noninteractive"},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.ZYPPER) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive remove vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.DNF) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.DNF)} remove vim-enhanced ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree -y",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
      if (softwareManager == SOFTWARE_MANAGERS.PACMAN) {
        Linux.commandQueue.add(
          LinuxCommand(
            command: "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.PACMAN)} -Rs --noconfirm vim ufw ncdu htop git pwgen curl unzip psmisc fail2ban cronie tree",
            userId: 0,
            environment: const {},
          ),
        );
        return;
      }
    }
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
