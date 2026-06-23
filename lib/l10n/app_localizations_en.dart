// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get enterASearchTerm => 'Enter a search term...';

  @override
  String get securityCheckDescription =>
      'Keep the security of your computer in track.';

  @override
  String get warpinatorDescription =>
      'Send files quickly over the local network. To Linux, Android, iOS and Windows.';

  @override
  String get securityCheck => 'Security Check';

  @override
  String get afterInstallation => 'First steps after installation';

  @override
  String get afterInstallationDescription =>
      'Set up your linux machine to your needs.';

  @override
  String get openX => 'Open';

  @override
  String get searchInWebFor => 'Search in web for';

  @override
  String get lookForOnlineResults => 'Look for online results..';

  @override
  String get sendFeedback => 'Send Feedback';

  @override
  String get clear => 'Clear';

  @override
  String get loading => 'Loading...';

  @override
  String get preparingSearch => 'Preparing search...';

  @override
  String get analysingSystemSecurity => 'Analysing System Security ...';

  @override
  String get additionalSoftwareSources => 'Additional Software Sources';

  @override
  String get securityCheckFailedBecauseNoRoot =>
      'That didn\'t work. You need root rights to run the security check.';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Retry';

  @override
  String get backToSearch => 'Back to search';

  @override
  String get reload => 'Reload';

  @override
  String get analyzingSystemScurity => 'Analysing system security...';

  @override
  String get updates => 'Updates';

  @override
  String get systemIsUpToDate => 'Great! Your system is up to date.';

  @override
  String get xPackagesShouldBeUpdated => 'packages should be updated.';

  @override
  String get homeFolder => 'Home folder';

  @override
  String get homeFolderRightsOkay =>
      'Your home folder rights are okay. Other users can\'t see your files.';

  @override
  String get homeFolderRightsNotOkay =>
      'Your home folder is not secure. Other users could see your files.';

  @override
  String get networkSecurity => 'Network security';

  @override
  String get noFirewallRecognized =>
      'No firewall recognized on your system.\\nA firewall is recommended for computers with access from the internet.';

  @override
  String get firewallIsRunning => 'Your firewall is up and running. Great job!';

  @override
  String get password => 'Password';

  @override
  String get firewallIsInactive =>
      'Your firewall is inactive. A firewall is recommended for computers with access from the internet.';

  @override
  String get sshFoundOnYourComputer =>
      'SSH server found on your computer. Your computer could be accessible from the outside. Uninstall ssh-server if you don\'t need it.';

  @override
  String get noFail2BanFound =>
      'No fail2ban instance found on your computer. With it your computer is more imune to ssh brute force attacks.';

  @override
  String get xrdpRunningOnYourComputer =>
      'Xrdp is running at your computer. It\'s recommended to uninstall if you don\'t really need it.';

  @override
  String get additionalSoftwareSourcesDetected =>
      'Some additional software sources where found. These are potentially unsafe.\\nIf you don\'t need security updates from these it is recommended to deactivate them.';

  @override
  String get noAdditionalSoftwareSourcesFound =>
      'Good! No additional software sources found.';

  @override
  String get changePasswordDescription => 'Change password of current user';

  @override
  String get userProfile => 'User Profile';

  @override
  String get changeUserProfile => 'Change userdetails';

  @override
  String get systemInformation => 'System information';

  @override
  String get distribution => 'Distribution';

  @override
  String get version => 'Version';

  @override
  String get desktop => 'Desktop';

  @override
  String get language => 'Language';

  @override
  String get next => 'Next';

  @override
  String get selectYourDistribution => 'Select your distribution';

  @override
  String get selectYourDesktop => 'Select your desktop';

  @override
  String get isTheRecognizedSystemCorrect =>
      'Is your recognized system correct?';

  @override
  String get noIWantToChange => 'No, I want to change';

  @override
  String get yes => 'Yes';

  @override
  String get recognizingSystem => 'Recognizing system...';

  @override
  String get yourLinuxAssistant => 'Your. Linux. Assistant.';

  @override
  String get linuxAssistantLongDescription =>
      'Linux Assistant is distribution-independent and designed to help and guide you through your daily usage. Just enter some keywords into the search field and find whatever you desire! Linux Assistant comes with useful shortcuts to files, folders and applications and also has some routines. Links to settings and e.g. the included PC-Security checker are also available.';

  @override
  String get welcomeToYourLinuxMachine => 'Welcome to your new linux machine!';

  @override
  String get afterInstallationGreetingDescription =>
      'In the next minutes you will configure your linux machine to your needs.';

  @override
  String get letsStart => 'Let\'s start!';

  @override
  String get includeBasicSystemInformation =>
      'Include basic system information';

  @override
  String get setUpXWithRecommendedSettings => 'Setup';

  @override
  String get setUpXWithRecommendedSettingsPart2 => 'with recommended settings?';

  @override
  String get manualConfiguration => 'Manual Configuration';

  @override
  String get afterInstallationManualConfigurationDescription =>
      'Exit this routine and keep the full control of every change on your pc.';

  @override
  String get automaticConfiguration => 'Automatic Configuration';

  @override
  String get applyConfiguration => 'Apply software configuration';

  @override
  String get thisProcessCouldTakeManyMinutesDependingSoftwareChoosed =>
      'This process could take many minutes depending on what software configuration you selected...';

  @override
  String get selectSpecificActionsOnTheNextSite =>
      'Select the specific automatic actions on the next page.';

  @override
  String get installMultimediaCodecs => 'Install Multimedia Codecs';

  @override
  String get installMultimediaCodecsDescription =>
      'Install additional proprietary multimedia codes for playing videos and music.';

  @override
  String get automaticSnapshots => 'Automatic Snapshots';

  @override
  String get automaticSnapshotsDescription =>
      'Configure automatic snapshots with timeshift. Timeshift will be configured to 2 monthly automatic snapshots on your root partition. It will not backup your personal files.';

  @override
  String get automaticNvidiaDriverInstallation =>
      'Automatic Nividia-Driver installation';

  @override
  String get automaticNvidiaDriverInstallationDesciption =>
      'All recommended drivers will be installed.';

  @override
  String get automaticUpdateManagerConfiguration =>
      'Automatic Update Manager Configuration';

  @override
  String get feedbackPlaceholder =>
      'Are you missing a search result? For what are you searching? Do you have suggestions for improvement?...';

  @override
  String get automaticUpdateManagerConfigurationDescription =>
      'Automatic updates and (if included) maintainance will be configured.';

  @override
  String get welcomeToYourNewSystem => 'Welcome to your new system!';

  @override
  String get automaticConfigurationIsRunningDescription =>
      'Your system is setting up and applying your software configuration. This process could take many minutes depending on what actions and software you selected...';

  @override
  String get browserSelection => 'Browser Selection';

  @override
  String get firefoxDescription =>
      'Open Source browser with focus on privacy by Mozilla.';

  @override
  String get chromiumDescription =>
      'Open Source browser. Free base of Google Chrome.';

  @override
  String get braveDescription => 'Open Source browser with focus on privacy.';

  @override
  String get chromeDescription => 'Proprietary browser from Google.';

  @override
  String get librewolfDescription =>
      'Open Source fork of Firefox, focused on privacy, security and user freedom.';

  @override
  String get waterfoxDescription =>
      'Open Source browser based on Firefox, designed for privacy and performance.';

  @override
  String get torbrowserDescription =>
      'Open Source browser designed to protect your privacy and anonymity online using the Tor network.';

  @override
  String get thunderbirdDescription =>
      'Open Source E-Mail Client from Mozilla.';

  @override
  String get jitsiDescription => 'Open Source video conference tool.';

  @override
  String get elementDescription =>
      'Open Source messaging tool based on matrix protocol.';

  @override
  String get signalDescription =>
      'Open source messenger. Works only with the smartphone app.';

  @override
  String get discordDescription => 'Proprietary community chat software';

  @override
  String get zoomDescription => 'Proprietary conference software.';

  @override
  String get whatsieDescription => 'Simple WhatsApp Web client.';

  @override
  String get telegramDescription =>
      'Popular, fast and secure messaging application.';

  @override
  String get threemaDescription =>
      'Secure messenger with a strong focus on privacy and anonymity.';

  @override
  String get communicationSoftware => 'Communication Software';

  @override
  String get flatpakIsNotInstalled =>
      'Flatpak isn\'t installed on your system.';

  @override
  String get flatpakDescription =>
      'For easy access to many popular apps Flatpak is highly recommended. Flatpak is a new utility for packet management for Linux. It is offering a sandbox environment in which apps can run in isolation of the rest of the system. By binding the \'Flathub\' (biggest repository for flatpaks) you get access to over 1800 different Linux apps. As a downside Flatpaks require more diskpace.';

  @override
  String get skip => 'Skip';

  @override
  String get settingUpFlatpak => 'Set up Flatpak';

  @override
  String get officeSelection => 'Office Selection';

  @override
  String get libreOfficeDescription =>
      'Open Source Office Suite from The Document Foundation. Great for the Open Document Format (.odt, .ods, .odp).';

  @override
  String get onlyOfficeDescription =>
      'Open Source Office Suite. Good for the Microsoft Document Format (.docx, .xls, .ppt).';

  @override
  String get wpsOfficeDescription =>
      'Proprietary Office Suite. Good for the Microsoft Document Format (.docx, .xls, .ppt).';

  @override
  String get includeSearchTermAndResults =>
      'Include search term and search results';

  @override
  String get submit => 'Submit';

  @override
  String get thankYouForTheFeedback => 'Thank you very much for your feedback!';

  @override
  String get feedbackSentSuccessfully =>
      'Your feedback was sent to the developers successfully.';

  @override
  String get close => 'Close';

  @override
  String get sendingFeedbackFailed => 'Sending feedback failed.';

  @override
  String get sendingFeedback => 'Sending feedback...';

  @override
  String get startAfterInstallationRoutine => 'Start initial setup of computer';

  @override
  String get timeToSetupYourComputer => 'Time to setup your computer';

  @override
  String get timeToSetupYourComputerDescription =>
      'Configure your linux machine to your needs.';

  @override
  String get activateHotkey => 'Activate hotkey';

  @override
  String get openLinuxAssistantFaster => 'Open Linux Assistant faster.';

  @override
  String openLinuxAssistantFasterDescription(Object modifier) {
    return 'You could open Linux Assistant with the keys $modifier + <Q>.\nThis is higly recommended to maximize your productivity under linux.';
  }

  @override
  String get yesSetUpHotkey => 'Yes, setup hotkey';

  @override
  String get introduction => 'Introduction';

  @override
  String get theFollowingContentCanBeSearched =>
      'You can search for following content:';

  @override
  String get applications => 'Applications';

  @override
  String get applicationSearchDescription =>
      'Search for all your favorite applications and start them in a fraction of a second.';

  @override
  String get folders => 'Folders';

  @override
  String get folderSearchDescription =>
      'Linux Assistant scans all your important folders and offers them you also in your result list.';

  @override
  String get recentFiles => 'Recent files';

  @override
  String get recentFilesDescription =>
      'As long your system stores recently used files, you can find these and also your starred files.';

  @override
  String get browserBookmarks => 'Bookmarks of your webbrowser';

  @override
  String get browserBookmarksDescription =>
      'Find your favorite sites if you marked them as bookmark in your webbrowser.';

  @override
  String get specialFunctions => 'Special functions by Linux-Assistant';

  @override
  String get specialFunctionsDescription =>
      'Start the security check or the after installation service and also many other small routines which make your daily linux use easier. These are presented under the search bar in radomized order.';

  @override
  String get hint => 'Hint';

  @override
  String get youCanOpenThisWindowBySearchingForIntroduction =>
      'You can reopen this site by searching for \'Introduction to Linux-Assistant\'.';

  @override
  String youCanOpenLinuxAssistantWithHotkey(Object modifier) {
    return 'You can always open Linux Assistant with the key combination $modifier + <Q>. If this does not work yet, call \'keyboard shortcut\' in the search.';
  }

  @override
  String get introductionToLinuxAssistant => 'Introduction to Linux-Assistant';

  @override
  String get introductionToLinuxAssistantDescription =>
      'Presentation of of all possibilites and search entries of Linux-Assistant.';

  @override
  String get changeBackground => 'Change background';

  @override
  String get analysingLinuxHealth => 'Analysing linux health...';

  @override
  String get linuxHealth => 'Linux health';

  @override
  String get linuxHealthDescription =>
      'Check the current status of your linux system.';

  @override
  String uptimeWarning(Object time, Object unit) {
    return 'Your Linux system has not been rebooted for a long time. To avoid potential errors, regular reboots are recommended. The last reboot was $time $unit ago.';
  }

  @override
  String uptimePass(Object time, Object unit) {
    return 'Your Linux system has only been running for $time $unit. That\'s good!';
  }

  @override
  String get diskspaceWarning1 => 'Your partition \'';

  @override
  String get diskspaceWarning2 =>
      '\' is very full! Try to free up some memory. Remaining available memory: ';

  @override
  String get diskspacePass =>
      'Your partitions are not overfilled. This results in better performance. Very good!';

  @override
  String processesWithZombiesMessage(Object processes, Object zombies) {
    return 'Currently $processes processes are running. Of these $zombies zombies where found.';
  }

  @override
  String removableDevicesWarning(Object removableDevices) {
    return '$removableDevices removable storage devices/(partitions) were found. If you do not currently need them, it is recommended to remove them due to security reasons and the health of these devices.';
  }

  @override
  String get removableDevicesPass =>
      'No removable storage devices were detected.';

  @override
  String get swapsPass =>
      'Your system uses swap space. You do not need to do anything in this regard.';

  @override
  String get swapsWarning =>
      'Your system doesn\'t have swap memory. If your memory is full, your system has no further possibility to swap it. Add either a swap file or a swap partition to your system.';

  @override
  String get topMemoryProcesses => 'Currently most memory-intensive processes';

  @override
  String get topCPUProcesses =>
      'Currently most computationally intensive processes';

  @override
  String get cpuUsage => 'CPU usage';

  @override
  String get memoryUsage => 'RAM usage';

  @override
  String get process => 'Process';

  @override
  String get runtime => 'Runtime';

  @override
  String get memoryAndStorage => 'Memory and storage';

  @override
  String get applyUpdatesSinceRelease =>
      'Update the system to the latest version';

  @override
  String applyUpdatesSinceReleaseDescription(Object distro) {
    return 'Since the release of the current $distro version, updates may be available. Apply these updates.';
  }

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hours';

  @override
  String get days => 'days';

  @override
  String get linuxAssistantKeyboardShortcut =>
      'Linux Assistant keyboard shortcut';

  @override
  String setUpLinuxAssistantKeyboardShortcut(Object modifier) {
    return 'Set up the keyboard combination $modifier + <Q> to quickly open Linux Assistant from anywhere.';
  }

  @override
  String get update => 'Update';

  @override
  String get aNewVersionIsAvailable => 'A new version is available!';

  @override
  String get doYouWantToUpdateNow =>
      'New features are waiting for you. Do you want to update Linux-Assistant now? This usually takes only a few seconds.';

  @override
  String get later => 'Later';

  @override
  String get updateNow => 'Update now';

  @override
  String get linuxAssistantIsUpdating =>
      'Linux-Assistant is updating itself. After that, restarting the application is recommended.';

  @override
  String get fix => 'Fix';

  @override
  String get hardInfoDescription => 'System information and benchmark tool';

  @override
  String installX(Object app) {
    return 'Install $app';
  }

  @override
  String installingXDescription(Object app) {
    return 'Installing $app...\nYou have to open $app after separatly.';
  }

  @override
  String get redshiftDescription => 'Filters blue light to reduce eye strain.';

  @override
  String get redshiftIsInstalledAlready =>
      'Redshift is already installed.\nPlease open Redshift independently from your system menu.';

  @override
  String get settings => 'Setting';

  @override
  String get searchSettings => 'Search settings';

  @override
  String get on => 'On';

  @override
  String get off => 'Off';

  @override
  String get includeApplications => 'Include applications.';

  @override
  String get includeBasicFolders => 'Include basic folders.';

  @override
  String get includeRecentlyUsedFilesAndFolders =>
      'Include recently used files and folders.';

  @override
  String get includeFavoriteFilesAndFolderBookmarks =>
      'Include favorite files and folder bookmarks.';

  @override
  String get includeBrowserBookmarks => 'Include browser bookmars.';

  @override
  String get shutdown => 'Shutdown';

  @override
  String get shutdownDescription =>
      'Turn off your Linux machine now or set a timing for it.';

  @override
  String get shutdownIn => 'Shutdown in';

  @override
  String get exit => 'Exit';

  @override
  String get exitDescription => 'Close Linux-Assistant.';

  @override
  String get appearance_settings => 'Appearance settings';

  @override
  String get darkThemeEnabled => 'Dark theme (restart required)';

  @override
  String get mainColorSetting => 'Main color (restart required)';

  @override
  String get secondaryColorSetting => 'Secondary color (restart required)';

  @override
  String get colorfulBackground => 'Colorful background';

  @override
  String get theFollowingCommandsWillBeExecuted =>
      'The following commands will be executed';

  @override
  String get command => 'Command';

  @override
  String get showCommands => 'Show commands';

  @override
  String get hideCommands => 'Hide commands';

  @override
  String get description => 'Description';

  @override
  String get root => 'Root';

  @override
  String get no => 'No';

  @override
  String get selfLearningSearch => 'Self-learning search';

  @override
  String get updateSystemDescription =>
      'Update your Linux machine and all applications (updates).\nThis process may take a few minutes.';

  @override
  String get featureOverview => 'Feature overview';

  @override
  String get powerMode => 'Power mode';

  @override
  String get powerModeDescription =>
      'Switch between power saving and performance mode.';

  @override
  String get powerSaver => 'power saving mode';

  @override
  String get performance => 'performance mode';

  @override
  String get balanced => 'balanced mode';

  @override
  String get activate => 'Activate';

  @override
  String get active => 'Active';

  @override
  String get installPowerProfilesDeamonDescription =>
      'To change the power mode you need power-profiles-deamon. Do you want to install this?';

  @override
  String get folderRecursionDepth => 'Folder recursion depth';

  @override
  String get shutdownAfterwards => 'Shutdown Linux afterwards';

  @override
  String get versionOfLinuxAssistant => 'Version of Linux Assistant';

  @override
  String get urls => 'URL';

  @override
  String get urlsDescription =>
      'Enter an URL and open it in your default browser.';

  @override
  String get packageWillBeInstalled =>
      'Your package will be installed in a few moments...';

  @override
  String get thisApplicationWillBeRemoved =>
      'This application will be removed.';

  @override
  String uninstallingXDescription(Object app) {
    return 'Uninstalling $app...';
  }

  @override
  String uninstallApp(Object app) {
    return 'Uninstall $app';
  }

  @override
  String uninstallAppWarning(Object app) {
    return 'Do you really want to uninstall $app?\nThe system might not work properly afterwards.\nPlease uninstall only programs you installed yourself.';
  }

  @override
  String get welcome => 'Welcome!';

  @override
  String get flathubPermissionsDescription =>
      'Only two more steps are necessary to get started.\nFor Linux-Assistant to work, it needs additional settings that cannot be set by default due to flathub.org.\nWith the additional settings, Linux-Assistant can access your Linux and e.g. manage software.\nLinux-Assistant is nevertheless technically limited so that system administration can only happen with your permission.\n\nPlease enter the following command into a terminal and press the Enter key. No additional text appears, which is perfectly ok.';

  @override
  String get pleaseRestartLinuxAssistant =>
      'Afterwards, Linux-Assistant has to be restarted once. Please exit Linux-Assistant and start it again immediately. See you soon!';

  @override
  String get cleanDiskspace => 'Clean diskspace';

  @override
  String get cleanDiskspaceDescription =>
      'Clean your diskspace by removing old packages and caches.';

  @override
  String get clean => 'Clean';

  @override
  String get cleaningDiskspace => 'Cleaning diskspace...';

  @override
  String get free => 'Free';

  @override
  String cleanX(Object app) {
    return 'Clean $app';
  }

  @override
  String get removeSoftware => 'Remove software';

  @override
  String get remove => 'Remove';

  @override
  String get back => 'Back';

  @override
  String get analyseDiskspace => 'Analyse diskspace';

  @override
  String get allBiggestFolders => 'All biggest folders';

  @override
  String get automaticCleanup => 'Automatic cleanup';

  @override
  String get automaticCleanupDescription =>
      'Automatically clean up your storage by deleting temporary files and package caches. Trash cans will also be emptied.';

  @override
  String get diskUsage => 'Disk usage';

  @override
  String get settingUpFirewall => 'Configure firewall...';

  @override
  String get fixPackageManager => 'Repair package management';

  @override
  String get fixPackageManagerDescription =>
      'Updates or installations can no longer be carried out? Try the automatic repair of the package management.';

  @override
  String get executeInTerminal => 'Execute in terminal';

  @override
  String get setupSnap => 'Set up Snap';

  @override
  String get setupSnapDescription =>
      'Install Snap and the Snap Store to install many more applications.\nAfterwards a restart of the computer is recommended.';

  @override
  String get vivaldiDescription =>
      'Proprietary browser with focus on privacy and many customization options.';

  @override
  String get makeAdministrator => 'Make the current user an administrator';

  @override
  String get makeAdministratorDescription =>
      'Add the current user to the \'sudo\' group to obtain root rights. The password of the root user is required for this.\nAfterwards a restart of the computer is recommended.';

  @override
  String get yayInstalled =>
      'Yay was found. Yay is an AUR helper that makes it easier for you to install AUR packages. The AUR is a community repository where many packages are maintained by the community and could be potentially harmful.';

  @override
  String get openSoftwareCenter => 'Open Software Center';

  @override
  String get openSoftwareCenterDescription =>
      'Open the Software Center to install additional applications/apps.';

  @override
  String get disableCdromSource => 'Disable CD-ROM source';

  @override
  String get disableCdromSourceDescription =>
      'A relic of the Debian installation. Disable the CDROM source to avoid error messages.';

  @override
  String get grubConfiguration => 'Grub configuration';

  @override
  String get grubConfigurationDescription =>
      'Configure the Grub bootloader. This step is recommended for advanced users only.';

  @override
  String get grubVisible => 'Bootmenu visible';

  @override
  String get enableBigFont => 'Enable large font';

  @override
  String get grubCountdown => 'Time until automatic start (in seconds)';

  @override
  String get startLastBootedEntry => 'Start the last booted entry';

  @override
  String get save => 'Save';

  @override
  String get distribution_selection => 'Distribution selection';

  @override
  String get copyCommands => 'Copy commands';

  @override
  String get errorThisDidntWork => 'That didn\'t work.';

  @override
  String get complete => 'Complete';

  @override
  String get hideFolders => 'Hide folders';

  @override
  String get showFolders => 'Show folders';

  @override
  String get hidePackageManagerActions => 'Hide package manager actions';

  @override
  String get showPackageManagerActions => 'Show package manager actions';
}
