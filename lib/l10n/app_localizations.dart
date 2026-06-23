import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('it'),
    Locale('fi')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a search term...'**
  String get enterASearchTerm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Keep the security of your computer in track.'**
  String get securityCheckDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Send files quickly over the local network. To Linux, Android, iOS and Windows.'**
  String get warpinatorDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Security Check'**
  String get securityCheck;

  ///
  ///
  /// In en, this message translates to:
  /// **'First steps after installation'**
  String get afterInstallation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Set up your linux machine to your needs.'**
  String get afterInstallationDescription;

  /// open folder/ open file/, ...
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openX;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search in web for'**
  String get searchInWebFor;

  ///
  ///
  /// In en, this message translates to:
  /// **'Look for online results..'**
  String get lookForOnlineResults;

  ///
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  ///
  ///
  /// In en, this message translates to:
  /// **'Preparing search...'**
  String get preparingSearch;

  ///
  ///
  /// In en, this message translates to:
  /// **'Analysing System Security ...'**
  String get analysingSystemSecurity;

  ///
  ///
  /// In en, this message translates to:
  /// **'Additional Software Sources'**
  String get additionalSoftwareSources;

  ///
  ///
  /// In en, this message translates to:
  /// **'That didn\'t work. You need root rights to run the security check.'**
  String get securityCheckFailedBecauseNoRoot;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  ///
  ///
  /// In en, this message translates to:
  /// **'Back to search'**
  String get backToSearch;

  ///
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  ///
  ///
  /// In en, this message translates to:
  /// **'Analysing system security...'**
  String get analyzingSystemScurity;

  ///
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Great! Your system is up to date.'**
  String get systemIsUpToDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'packages should be updated.'**
  String get xPackagesShouldBeUpdated;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home folder'**
  String get homeFolder;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your home folder rights are okay. Other users can\'t see your files.'**
  String get homeFolderRightsOkay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your home folder is not secure. Other users could see your files.'**
  String get homeFolderRightsNotOkay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Network security'**
  String get networkSecurity;

  ///
  ///
  /// In en, this message translates to:
  /// **'No firewall recognized on your system.\\nA firewall is recommended for computers with access from the internet.'**
  String get noFirewallRecognized;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your firewall is up and running. Great job!'**
  String get firewallIsRunning;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your firewall is inactive. A firewall is recommended for computers with access from the internet.'**
  String get firewallIsInactive;

  ///
  ///
  /// In en, this message translates to:
  /// **'SSH server found on your computer. Your computer could be accessible from the outside. Uninstall ssh-server if you don\'t need it.'**
  String get sshFoundOnYourComputer;

  ///
  ///
  /// In en, this message translates to:
  /// **'No fail2ban instance found on your computer. With it your computer is more imune to ssh brute force attacks.'**
  String get noFail2BanFound;

  ///
  ///
  /// In en, this message translates to:
  /// **'Xrdp is running at your computer. It\'s recommended to uninstall if you don\'t really need it.'**
  String get xrdpRunningOnYourComputer;

  ///
  ///
  /// In en, this message translates to:
  /// **'Some additional software sources where found. These are potentially unsafe.\\nIf you don\'t need security updates from these it is recommended to deactivate them.'**
  String get additionalSoftwareSourcesDetected;

  ///
  ///
  /// In en, this message translates to:
  /// **'Good! No additional software sources found.'**
  String get noAdditionalSoftwareSourcesFound;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change password of current user'**
  String get changePasswordDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change userdetails'**
  String get changeUserProfile;

  ///
  ///
  /// In en, this message translates to:
  /// **'System information'**
  String get systemInformation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Distribution'**
  String get distribution;

  ///
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  ///
  ///
  /// In en, this message translates to:
  /// **'Desktop'**
  String get desktop;

  ///
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  ///
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select your distribution'**
  String get selectYourDistribution;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select your desktop'**
  String get selectYourDesktop;

  ///
  ///
  /// In en, this message translates to:
  /// **'Is your recognized system correct?'**
  String get isTheRecognizedSystemCorrect;

  ///
  ///
  /// In en, this message translates to:
  /// **'No, I want to change'**
  String get noIWantToChange;

  ///
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Recognizing system...'**
  String get recognizingSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your. Linux. Assistant.'**
  String get yourLinuxAssistant;

  /// description at start screen
  ///
  /// In en, this message translates to:
  /// **'Linux Assistant is distribution-independent and designed to help and guide you through your daily usage. Just enter some keywords into the search field and find whatever you desire! Linux Assistant comes with useful shortcuts to files, folders and applications and also has some routines. Links to settings and e.g. the included PC-Security checker are also available.'**
  String get linuxAssistantLongDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Welcome to your new linux machine!'**
  String get welcomeToYourLinuxMachine;

  ///
  ///
  /// In en, this message translates to:
  /// **'In the next minutes you will configure your linux machine to your needs.'**
  String get afterInstallationGreetingDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Let\'s start!'**
  String get letsStart;

  ///
  ///
  /// In en, this message translates to:
  /// **'Include basic system information'**
  String get includeBasicSystemInformation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setUpXWithRecommendedSettings;

  ///
  ///
  /// In en, this message translates to:
  /// **'with recommended settings?'**
  String get setUpXWithRecommendedSettingsPart2;

  ///
  ///
  /// In en, this message translates to:
  /// **'Manual Configuration'**
  String get manualConfiguration;

  ///
  ///
  /// In en, this message translates to:
  /// **'Exit this routine and keep the full control of every change on your pc.'**
  String get afterInstallationManualConfigurationDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Automatic Configuration'**
  String get automaticConfiguration;

  ///
  ///
  /// In en, this message translates to:
  /// **'Apply software configuration'**
  String get applyConfiguration;

  ///
  ///
  /// In en, this message translates to:
  /// **'This process could take many minutes depending on what software configuration you selected...'**
  String get thisProcessCouldTakeManyMinutesDependingSoftwareChoosed;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select the specific automatic actions on the next page.'**
  String get selectSpecificActionsOnTheNextSite;

  ///
  ///
  /// In en, this message translates to:
  /// **'Install Multimedia Codecs'**
  String get installMultimediaCodecs;

  ///
  ///
  /// In en, this message translates to:
  /// **'Install additional proprietary multimedia codes for playing videos and music.'**
  String get installMultimediaCodecsDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Automatic Snapshots'**
  String get automaticSnapshots;

  ///
  ///
  /// In en, this message translates to:
  /// **'Configure automatic snapshots with timeshift. Timeshift will be configured to 2 monthly automatic snapshots on your root partition. It will not backup your personal files.'**
  String get automaticSnapshotsDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Automatic Nividia-Driver installation'**
  String get automaticNvidiaDriverInstallation;

  ///
  ///
  /// In en, this message translates to:
  /// **'All recommended drivers will be installed.'**
  String get automaticNvidiaDriverInstallationDesciption;

  ///
  ///
  /// In en, this message translates to:
  /// **'Automatic Update Manager Configuration'**
  String get automaticUpdateManagerConfiguration;

  ///
  ///
  /// In en, this message translates to:
  /// **'Are you missing a search result? For what are you searching? Do you have suggestions for improvement?...'**
  String get feedbackPlaceholder;

  ///
  ///
  /// In en, this message translates to:
  /// **'Automatic updates and (if included) maintainance will be configured.'**
  String get automaticUpdateManagerConfigurationDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Welcome to your new system!'**
  String get welcomeToYourNewSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your system is setting up and applying your software configuration. This process could take many minutes depending on what actions and software you selected...'**
  String get automaticConfigurationIsRunningDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Browser Selection'**
  String get browserSelection;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source browser with focus on privacy by Mozilla.'**
  String get firefoxDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source browser. Free base of Google Chrome.'**
  String get chromiumDescription;

  /// No description provided for @braveDescription.
  ///
  /// In en, this message translates to:
  /// **'Open Source browser with focus on privacy.'**
  String get braveDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Proprietary browser from Google.'**
  String get chromeDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source E-Mail Client from Mozilla.'**
  String get thunderbirdDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source video conference tool.'**
  String get jitsiDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source messaging tool based on matrix protocol.'**
  String get elementDescription;

  /// No description provided for @signalDescription.
  ///
  /// In en, this message translates to:
  /// **'Open source messenger. Works only with the smartphone app.'**
  String get signalDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Proprietary community chat software'**
  String get discordDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Proprietary conference software.'**
  String get zoomDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Proprietary team communication software.'**
  String get teamsDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Communication Software'**
  String get communicationSoftware;

  ///
  ///
  /// In en, this message translates to:
  /// **'Flatpak isn\'t installed on your system.'**
  String get flatpakIsNotInstalled;

  ///
  ///
  /// In en, this message translates to:
  /// **'For easy access to many popular apps Flatpak is highly recommended. Flatpak is a new utility for packet management for Linux. It is offering a sandbox environment in which apps can run in isolation of the rest of the system. By binding the \'Flathub\' (biggest repository for flatpaks) you get access to over 1800 different Linux apps. As a downside Flatpaks require more diskpace.'**
  String get flatpakDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Set up Flatpak'**
  String get settingUpFlatpak;

  ///
  ///
  /// In en, this message translates to:
  /// **'Office Selection'**
  String get officeSelection;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source Office Suite from The Document Foundation. Great for the Open Document Format (.odt, .ods, .odp).'**
  String get libreOfficeDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Source Office Suite. Good for the Microsoft Document Format (.docx, .xls, .ppt).'**
  String get onlyOfficeDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Proprietary Office Suite. Good for the Microsoft Document Format (.docx, .xls, .ppt).'**
  String get wpsOfficeDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Include search term and search results'**
  String get includeSearchTermAndResults;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Thank you very much for your feedback!'**
  String get thankYouForTheFeedback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your feedback was sent to the developers successfully.'**
  String get feedbackSentSuccessfully;

  ///
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sending feedback failed.'**
  String get sendingFeedbackFailed;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sending feedback...'**
  String get sendingFeedback;

  /// No description provided for @startAfterInstallationRoutine.
  ///
  /// In en, this message translates to:
  /// **'Start initial setup of computer'**
  String get startAfterInstallationRoutine;

  /// No description provided for @timeToSetupYourComputer.
  ///
  /// In en, this message translates to:
  /// **'Time to setup your computer'**
  String get timeToSetupYourComputer;

  /// No description provided for @timeToSetupYourComputerDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure your linux machine to your needs.'**
  String get timeToSetupYourComputerDescription;

  /// No description provided for @activateHotkey.
  ///
  /// In en, this message translates to:
  /// **'Activate hotkey'**
  String get activateHotkey;

  /// No description provided for @openLinuxAssistantFaster.
  ///
  /// In en, this message translates to:
  /// **'Open Linux Assistant faster.'**
  String get openLinuxAssistantFaster;

  ///
  ///
  /// In en, this message translates to:
  /// **'You could open Linux Assistant with the keys {modifier} + <Q>.\nThis is higly recommended to maximize your productivity under linux.'**
  String openLinuxAssistantFasterDescription(Object modifier);

  /// No description provided for @yesSetUpHotkey.
  ///
  /// In en, this message translates to:
  /// **'Yes, setup hotkey'**
  String get yesSetUpHotkey;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @theFollowingContentCanBeSearched.
  ///
  /// In en, this message translates to:
  /// **'You can search for following content:'**
  String get theFollowingContentCanBeSearched;

  /// No description provided for @applications.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get applications;

  /// No description provided for @applicationSearchDescription.
  ///
  /// In en, this message translates to:
  /// **'Search for all your favorite applications and start them in a fraction of a second.'**
  String get applicationSearchDescription;

  /// No description provided for @folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get folders;

  /// No description provided for @folderSearchDescription.
  ///
  /// In en, this message translates to:
  /// **'Linux Assistant scans all your important folders and offers them you also in your result list.'**
  String get folderSearchDescription;

  /// No description provided for @recentFiles.
  ///
  /// In en, this message translates to:
  /// **'Recent files'**
  String get recentFiles;

  /// No description provided for @recentFilesDescription.
  ///
  /// In en, this message translates to:
  /// **'As long your system stores recently used files, you can find these and also your starred files.'**
  String get recentFilesDescription;

  /// No description provided for @browserBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks of your webbrowser'**
  String get browserBookmarks;

  /// No description provided for @browserBookmarksDescription.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite sites if you marked them as bookmark in your webbrowser.'**
  String get browserBookmarksDescription;

  /// No description provided for @specialFunctions.
  ///
  /// In en, this message translates to:
  /// **'Special functions by Linux-Assistant'**
  String get specialFunctions;

  /// No description provided for @specialFunctionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Start the security check or the after installation service and also many other small routines which make your daily linux use easier. These are presented under the search bar in radomized order.'**
  String get specialFunctionsDescription;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @youCanOpenThisWindowBySearchingForIntroduction.
  ///
  /// In en, this message translates to:
  /// **'You can reopen this site by searching for \'Introduction to Linux-Assistant\'.'**
  String get youCanOpenThisWindowBySearchingForIntroduction;

  ///
  ///
  /// In en, this message translates to:
  /// **'You can always open Linux Assistant with the key combination {modifier} + <Q>. If this does not work yet, call \'keyboard shortcut\' in the search.'**
  String youCanOpenLinuxAssistantWithHotkey(Object modifier);

  /// No description provided for @introductionToLinuxAssistant.
  ///
  /// In en, this message translates to:
  /// **'Introduction to Linux-Assistant'**
  String get introductionToLinuxAssistant;

  /// No description provided for @introductionToLinuxAssistantDescription.
  ///
  /// In en, this message translates to:
  /// **'Presentation of of all possibilites and search entries of Linux-Assistant.'**
  String get introductionToLinuxAssistantDescription;

  /// No description provided for @changeBackground.
  ///
  /// In en, this message translates to:
  /// **'Change background'**
  String get changeBackground;

  /// No description provided for @analysingLinuxHealth.
  ///
  /// In en, this message translates to:
  /// **'Analysing linux health...'**
  String get analysingLinuxHealth;

  /// No description provided for @linuxHealth.
  ///
  /// In en, this message translates to:
  /// **'Linux health'**
  String get linuxHealth;

  /// No description provided for @linuxHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'Check the current status of your linux system.'**
  String get linuxHealthDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Linux system has not been rebooted for a long time. To avoid potential errors, regular reboots are recommended. The last reboot was {time} {unit} ago.'**
  String uptimeWarning(Object time, Object unit);

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Linux system has only been running for {time} {unit}. That\'s good!'**
  String uptimePass(Object time, Object unit);

  /// No description provided for @diskspaceWarning1.
  ///
  /// In en, this message translates to:
  /// **'Your partition \''**
  String get diskspaceWarning1;

  /// No description provided for @diskspaceWarning2.
  ///
  /// In en, this message translates to:
  /// **'\' is very full! Try to free up some memory. Remaining available memory: '**
  String get diskspaceWarning2;

  /// No description provided for @diskspacePass.
  ///
  /// In en, this message translates to:
  /// **'Your partitions are not overfilled. This results in better performance. Very good!'**
  String get diskspacePass;

  ///
  ///
  /// In en, this message translates to:
  /// **'Currently {processes} processes are running. Of these {zombies} zombies where found.'**
  String processesWithZombiesMessage(Object processes, Object zombies);

  ///
  ///
  /// In en, this message translates to:
  /// **'{removableDevices} removable storage devices/(partitions) were found. If you do not currently need them, it is recommended to remove them due to security reasons and the health of these devices.'**
  String removableDevicesWarning(Object removableDevices);

  /// No description provided for @removableDevicesPass.
  ///
  /// In en, this message translates to:
  /// **'No removable storage devices were detected.'**
  String get removableDevicesPass;

  /// No description provided for @swapsPass.
  ///
  /// In en, this message translates to:
  /// **'Your system uses swap space. You do not need to do anything in this regard.'**
  String get swapsPass;

  /// No description provided for @swapsWarning.
  ///
  /// In en, this message translates to:
  /// **'Your system doesn\'t have swap memory. If your memory is full, your system has no further possibility to swap it. Add either a swap file or a swap partition to your system.'**
  String get swapsWarning;

  /// No description provided for @topMemoryProcesses.
  ///
  /// In en, this message translates to:
  /// **'Currently most memory-intensive processes'**
  String get topMemoryProcesses;

  /// No description provided for @topCPUProcesses.
  ///
  /// In en, this message translates to:
  /// **'Currently most computationally intensive processes'**
  String get topCPUProcesses;

  /// No description provided for @cpuUsage.
  ///
  /// In en, this message translates to:
  /// **'CPU usage'**
  String get cpuUsage;

  /// No description provided for @memoryUsage.
  ///
  /// In en, this message translates to:
  /// **'RAM usage'**
  String get memoryUsage;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @runtime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get runtime;

  /// No description provided for @memoryAndStorage.
  ///
  /// In en, this message translates to:
  /// **'Memory and storage'**
  String get memoryAndStorage;

  /// No description provided for @applyUpdatesSinceRelease.
  ///
  /// In en, this message translates to:
  /// **'Update the system to the latest version'**
  String get applyUpdatesSinceRelease;

  ///
  ///
  /// In en, this message translates to:
  /// **'Since the release of the current {distro} version, updates may be available. Apply these updates.'**
  String applyUpdatesSinceReleaseDescription(Object distro);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @linuxAssistantKeyboardShortcut.
  ///
  /// In en, this message translates to:
  /// **'Linux Assistant keyboard shortcut'**
  String get linuxAssistantKeyboardShortcut;

  ///
  ///
  /// In en, this message translates to:
  /// **'Set up the keyboard combination {modifier} + <Q> to quickly open Linux Assistant from anywhere.'**
  String setUpLinuxAssistantKeyboardShortcut(Object modifier);

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @aNewVersionIsAvailable.
  ///
  /// In en, this message translates to:
  /// **'A new version is available!'**
  String get aNewVersionIsAvailable;

  /// No description provided for @doYouWantToUpdateNow.
  ///
  /// In en, this message translates to:
  /// **'New features are waiting for you. Do you want to update Linux-Assistant now? This usually takes only a few seconds.'**
  String get doYouWantToUpdateNow;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @linuxAssistantIsUpdating.
  ///
  /// In en, this message translates to:
  /// **'Linux-Assistant is updating itself. After that, restarting the application is recommended.'**
  String get linuxAssistantIsUpdating;

  /// No description provided for @fix.
  ///
  /// In en, this message translates to:
  /// **'Fix'**
  String get fix;

  /// No description provided for @hardInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'System information and benchmark tool'**
  String get hardInfoDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Install {app}'**
  String installX(Object app);

  ///
  ///
  /// In en, this message translates to:
  /// **'Installing {app}...\nYou have to open {app} after separatly.'**
  String installingXDescription(Object app);

  /// No description provided for @redshiftDescription.
  ///
  /// In en, this message translates to:
  /// **'Filters blue light to reduce eye strain.'**
  String get redshiftDescription;

  /// No description provided for @redshiftIsInstalledAlready.
  ///
  /// In en, this message translates to:
  /// **'Redshift is already installed.\nPlease open Redshift independently from your system menu.'**
  String get redshiftIsInstalledAlready;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settings;

  /// No description provided for @searchSettings.
  ///
  /// In en, this message translates to:
  /// **'Search settings'**
  String get searchSettings;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @includeApplications.
  ///
  /// In en, this message translates to:
  /// **'Include applications.'**
  String get includeApplications;

  /// No description provided for @includeBasicFolders.
  ///
  /// In en, this message translates to:
  /// **'Include basic folders.'**
  String get includeBasicFolders;

  /// No description provided for @includeRecentlyUsedFilesAndFolders.
  ///
  /// In en, this message translates to:
  /// **'Include recently used files and folders.'**
  String get includeRecentlyUsedFilesAndFolders;

  /// No description provided for @includeFavoriteFilesAndFolderBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Include favorite files and folder bookmarks.'**
  String get includeFavoriteFilesAndFolderBookmarks;

  /// No description provided for @includeBrowserBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Include browser bookmars.'**
  String get includeBrowserBookmarks;

  /// No description provided for @shutdown.
  ///
  /// In en, this message translates to:
  /// **'Shutdown'**
  String get shutdown;

  /// No description provided for @shutdownDescription.
  ///
  /// In en, this message translates to:
  /// **'Turn off your Linux machine now or set a timing for it.'**
  String get shutdownDescription;

  /// No description provided for @shutdownIn.
  ///
  /// In en, this message translates to:
  /// **'Shutdown in'**
  String get shutdownIn;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exitDescription.
  ///
  /// In en, this message translates to:
  /// **'Close Linux-Assistant.'**
  String get exitDescription;

  /// No description provided for @appearance_settings.
  ///
  /// In en, this message translates to:
  /// **'Appearance settings'**
  String get appearance_settings;

  /// No description provided for @darkThemeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Dark theme (restart required)'**
  String get darkThemeEnabled;

  /// No description provided for @mainColorSetting.
  ///
  /// In en, this message translates to:
  /// **'Main color (restart required)'**
  String get mainColorSetting;

  /// No description provided for @secondaryColorSetting.
  ///
  /// In en, this message translates to:
  /// **'Secondary color (restart required)'**
  String get secondaryColorSetting;

  /// No description provided for @colorfulBackground.
  ///
  /// In en, this message translates to:
  /// **'Colorful background'**
  String get colorfulBackground;

  /// No description provided for @theFollowingCommandsWillBeExecuted.
  ///
  /// In en, this message translates to:
  /// **'The following commands will be executed'**
  String get theFollowingCommandsWillBeExecuted;

  /// No description provided for @command.
  ///
  /// In en, this message translates to:
  /// **'Command'**
  String get command;

  /// No description provided for @showCommands.
  ///
  /// In en, this message translates to:
  /// **'Show commands'**
  String get showCommands;

  /// No description provided for @hideCommands.
  ///
  /// In en, this message translates to:
  /// **'Hide commands'**
  String get hideCommands;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @root.
  ///
  /// In en, this message translates to:
  /// **'Root'**
  String get root;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @selfLearningSearch.
  ///
  /// In en, this message translates to:
  /// **'Self-learning search'**
  String get selfLearningSearch;

  /// No description provided for @updateSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Update your Linux machine and all applications (updates).\nThis process may take a few minutes.'**
  String get updateSystemDescription;

  /// No description provided for @featureOverview.
  ///
  /// In en, this message translates to:
  /// **'Feature overview'**
  String get featureOverview;

  /// No description provided for @powerMode.
  ///
  /// In en, this message translates to:
  /// **'Power mode'**
  String get powerMode;

  /// No description provided for @powerModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between power saving and performance mode.'**
  String get powerModeDescription;

  /// No description provided for @powerSaver.
  ///
  /// In en, this message translates to:
  /// **'power saving mode'**
  String get powerSaver;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'performance mode'**
  String get performance;

  /// No description provided for @balanced.
  ///
  /// In en, this message translates to:
  /// **'balanced mode'**
  String get balanced;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @installPowerProfilesDeamonDescription.
  ///
  /// In en, this message translates to:
  /// **'To change the power mode you need power-profiles-deamon. Do you want to install this?'**
  String get installPowerProfilesDeamonDescription;

  /// No description provided for @folderRecursionDepth.
  ///
  /// In en, this message translates to:
  /// **'Folder recursion depth'**
  String get folderRecursionDepth;

  /// No description provided for @shutdownAfterwards.
  ///
  /// In en, this message translates to:
  /// **'Shutdown Linux afterwards'**
  String get shutdownAfterwards;

  /// No description provided for @versionOfLinuxAssistant.
  ///
  /// In en, this message translates to:
  /// **'Version of Linux Assistant'**
  String get versionOfLinuxAssistant;

  /// No description provided for @urls.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get urls;

  /// No description provided for @urlsDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter an URL and open it in your default browser.'**
  String get urlsDescription;

  /// No description provided for @packageWillBeInstalled.
  ///
  /// In en, this message translates to:
  /// **'Your package will be installed in a few moments...'**
  String get packageWillBeInstalled;

  /// No description provided for @thisApplicationWillBeRemoved.
  ///
  /// In en, this message translates to:
  /// **'This application will be removed.'**
  String get thisApplicationWillBeRemoved;

  ///
  ///
  /// In en, this message translates to:
  /// **'Uninstalling {app}...'**
  String uninstallingXDescription(Object app);

  ///
  ///
  /// In en, this message translates to:
  /// **'Uninstall {app}'**
  String uninstallApp(Object app);

  ///
  ///
  /// In en, this message translates to:
  /// **'Do you really want to uninstall {app}?\nThe system might not work properly afterwards.\nPlease uninstall only programs you installed yourself.'**
  String uninstallAppWarning(Object app);

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @flathubPermissionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Only two more steps are necessary to get started.\nFor Linux-Assistant to work, it needs additional settings that cannot be set by default due to flathub.org.\nWith the additional settings, Linux-Assistant can access your Linux and e.g. manage software.\nLinux-Assistant is nevertheless technically limited so that system administration can only happen with your permission.\n\nPlease enter the following command into a terminal and press the Enter key. No additional text appears, which is perfectly ok.'**
  String get flathubPermissionsDescription;

  /// No description provided for @pleaseRestartLinuxAssistant.
  ///
  /// In en, this message translates to:
  /// **'Afterwards, Linux-Assistant has to be restarted once. Please exit Linux-Assistant and start it again immediately. See you soon!'**
  String get pleaseRestartLinuxAssistant;

  /// No description provided for @cleanDiskspace.
  ///
  /// In en, this message translates to:
  /// **'Clean diskspace'**
  String get cleanDiskspace;

  /// No description provided for @cleanDiskspaceDescription.
  ///
  /// In en, this message translates to:
  /// **'Clean your diskspace by removing old packages and caches.'**
  String get cleanDiskspaceDescription;

  /// No description provided for @clean.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get clean;

  /// No description provided for @cleaningDiskspace.
  ///
  /// In en, this message translates to:
  /// **'Cleaning diskspace...'**
  String get cleaningDiskspace;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clean {app}'**
  String cleanX(Object app);

  /// No description provided for @removeSoftware.
  ///
  /// In en, this message translates to:
  /// **'Remove software'**
  String get removeSoftware;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @analyseDiskspace.
  ///
  /// In en, this message translates to:
  /// **'Analyse diskspace'**
  String get analyseDiskspace;

  /// No description provided for @allBiggestFolders.
  ///
  /// In en, this message translates to:
  /// **'All biggest folders'**
  String get allBiggestFolders;

  /// No description provided for @automaticCleanup.
  ///
  /// In en, this message translates to:
  /// **'Automatic cleanup'**
  String get automaticCleanup;

  /// No description provided for @automaticCleanupDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically clean up your storage by deleting temporary files and package caches. Trash cans will also be emptied.'**
  String get automaticCleanupDescription;

  /// No description provided for @diskUsage.
  ///
  /// In en, this message translates to:
  /// **'Disk usage'**
  String get diskUsage;

  /// No description provided for @settingUpFirewall.
  ///
  /// In en, this message translates to:
  /// **'Configure firewall...'**
  String get settingUpFirewall;

  /// No description provided for @fixPackageManager.
  ///
  /// In en, this message translates to:
  /// **'Repair package management'**
  String get fixPackageManager;

  /// No description provided for @fixPackageManagerDescription.
  ///
  /// In en, this message translates to:
  /// **'Updates or installations can no longer be carried out? Try the automatic repair of the package management.'**
  String get fixPackageManagerDescription;

  /// No description provided for @executeInTerminal.
  ///
  /// In en, this message translates to:
  /// **'Execute in terminal'**
  String get executeInTerminal;

  /// No description provided for @setupSnap.
  ///
  /// In en, this message translates to:
  /// **'Set up Snap'**
  String get setupSnap;

  /// No description provided for @setupSnapDescription.
  ///
  /// In en, this message translates to:
  /// **'Install Snap and the Snap Store to install many more applications.\nAfterwards a restart of the computer is recommended.'**
  String get setupSnapDescription;

  /// No description provided for @vivaldiDescription.
  ///
  /// In en, this message translates to:
  /// **'Proprietary browser with focus on privacy and many customization options.'**
  String get vivaldiDescription;

  /// No description provided for @makeAdministrator.
  ///
  /// In en, this message translates to:
  /// **'Make the current user an administrator'**
  String get makeAdministrator;

  /// No description provided for @makeAdministratorDescription.
  ///
  /// In en, this message translates to:
  /// **'Add the current user to the \'sudo\' group to obtain root rights. The password of the root user is required for this.\nAfterwards a restart of the computer is recommended.'**
  String get makeAdministratorDescription;

  /// No description provided for @yayInstalled.
  ///
  /// In en, this message translates to:
  /// **'Yay was found. Yay is an AUR helper that makes it easier for you to install AUR packages. The AUR is a community repository where many packages are maintained by the community and could be potentially harmful.'**
  String get yayInstalled;

  /// No description provided for @openSoftwareCenter.
  ///
  /// In en, this message translates to:
  /// **'Open Software Center'**
  String get openSoftwareCenter;

  /// No description provided for @openSoftwareCenterDescription.
  ///
  /// In en, this message translates to:
  /// **'Open the Software Center to install additional applications/apps.'**
  String get openSoftwareCenterDescription;

  /// No description provided for @disableCdromSource.
  ///
  /// In en, this message translates to:
  /// **'Disable CD-ROM source'**
  String get disableCdromSource;

  /// No description provided for @disableCdromSourceDescription.
  ///
  /// In en, this message translates to:
  /// **'A relic of the Debian installation. Disable the CDROM source to avoid error messages.'**
  String get disableCdromSourceDescription;

  /// No description provided for @grubConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Grub configuration'**
  String get grubConfiguration;

  /// No description provided for @grubConfigurationDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure the Grub bootloader. This step is recommended for advanced users only.'**
  String get grubConfigurationDescription;

  /// No description provided for @grubVisible.
  ///
  /// In en, this message translates to:
  /// **'Bootmenu visible'**
  String get grubVisible;

  /// No description provided for @enableBigFont.
  ///
  /// In en, this message translates to:
  /// **'Enable large font'**
  String get enableBigFont;

  /// No description provided for @grubCountdown.
  ///
  /// In en, this message translates to:
  /// **'Time until automatic start (in seconds)'**
  String get grubCountdown;

  /// No description provided for @startLastBootedEntry.
  ///
  /// In en, this message translates to:
  /// **'Start the last booted entry'**
  String get startLastBootedEntry;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @distribution_selection.
  ///
  /// In en, this message translates to:
  /// **'Distribution selection'**
  String get distribution_selection;

  /// No description provided for @copyCommands.
  ///
  /// In en, this message translates to:
  /// **'Copy commands'**
  String get copyCommands;

  /// No description provided for @errorThisDidntWork.
  ///
  /// In en, this message translates to:
  /// **'That didn\'t work.'**
  String get errorThisDidntWork;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @hideFolders.
  ///
  /// In en, this message translates to:
  /// **'Hide folders'**
  String get hideFolders;

  /// No description provided for @showFolders.
  ///
  /// In en, this message translates to:
  /// **'Show folders'**
  String get showFolders;

  /// No description provided for @hidePackageManagerActions.
  ///
  /// In en, this message translates to:
  /// **'Hide package manager actions'**
  String get hidePackageManagerActions;

  /// No description provided for @showPackageManagerActions.
  ///
  /// In en, this message translates to:
  /// **'Show package manager actions'**
  String get showPackageManagerActions;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'it', 'fi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
    case 'fi':
      return AppLocalizationsFi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
