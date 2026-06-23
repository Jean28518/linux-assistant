// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get helloWorld => 'Hei maailma!';

  @override
  String get enterASearchTerm => 'Anna hakutermi...';

  @override
  String get securityCheckDescription =>
      'Pidä tietokoneesi suojaus ajan tasalla.';

  @override
  String get warpinatorDescription =>
      'Lähetä tiedostoja nopeasti paikallisverkon kautta. Linuxiin, Androidiin, iOS:iin ja Windowsiin.';

  @override
  String get securityCheck => 'Turvatarkistus';

  @override
  String get afterInstallation => 'Ensimmäiset vaiheet asennuksen jälkeen';

  @override
  String get afterInstallationDescription =>
      'Asenna linux-koneesi tarpeidesi mukaan.';

  @override
  String get openX => 'Avaa';

  @override
  String get searchInWebFor => 'Hae verkosta';

  @override
  String get lookForOnlineResults => 'Etsi online-tuloksia...';

  @override
  String get sendFeedback => 'Lähetä palautetta';

  @override
  String get clear => 'Tyhjennä';

  @override
  String get loading => 'Ladataan...';

  @override
  String get preparingSearch => 'Valmistellaan hakua...';

  @override
  String get analysingSystemSecurity =>
      'Analysoidaan järjestelmän turvallisuutta...';

  @override
  String get additionalSoftwareSources => 'Lisäohjelmistolähteet';

  @override
  String get securityCheckFailedBecauseNoRoot =>
      'Se ei toiminut. Tarvitset pääkäyttäjän oikeudet suorittaaksesi suojaustarkistuksen.';

  @override
  String get cancel => 'Peruuta';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get backToSearch => 'Takaisin hakuun';

  @override
  String get reload => 'Lataa uudelleen';

  @override
  String get analyzingSystemScurity =>
      'Analysoidaan järjestelmän turvallisuutta...';

  @override
  String get updates => 'Updates';

  @override
  String get systemIsUpToDate => 'Hienoa! Järjestelmäsi on ajan tasalla.';

  @override
  String get xPackagesShouldBeUpdated => 'Paketit tulee päivittää.';

  @override
  String get homeFolder => 'Kotikansio';

  @override
  String get homeFolderRightsOkay =>
      'Kotikansiosi oikeudet ovat kunnossa. Muut käyttäjät eivät näe tiedostojasi.';

  @override
  String get homeFolderRightsNotOkay =>
      'Kotikansiosi ei ole suojattu. Muut käyttäjät voivat nähdä tiedostosi.';

  @override
  String get networkSecurity => 'Verkon suojaus';

  @override
  String get noFirewallRecognized =>
      'Järjestelmässäsi ei tunnisteta palomuuria.\\nPalomuuria suositellaan tietokoneille, joissa on Internet-yhteys.';

  @override
  String get firewallIsRunning => 'Palomuurisi on toiminnassa. Hienoa työtä!';

  @override
  String get password => 'Salasana';

  @override
  String get firewallIsInactive =>
      'Palomuurisi ei ole aktiivinen. Palomuuria suositellaan tietokoneille, joissa on Internet-yhteys.';

  @override
  String get sshFoundOnYourComputer =>
      'Tietokoneeltasi löytyi SSH-palvelin. Tietokoneesi voi olla käytettävissä ulkopuolelta. Poista ssh-server, jos et tarvitse sitä.';

  @override
  String get noFail2BanFound =>
      'Tietokoneeltasi ei löytynyt fail2ban-instanssia. Sen avulla tietokoneesi on immuuni ssh brute force -hyökkäyksille.';

  @override
  String get xrdpRunningOnYourComputer =>
      'Xrdp on käynnissä tietokoneellasi. On suositeltavaa poistaa asennus, jos et todella tarvitse sitä.';

  @override
  String get additionalSoftwareSourcesDetected =>
      'Joitakin lisäohjelmistolähteitä löytyi. Nämä ovat mahdollisesti vaarallisia.\\nJos et tarvitse tietoturvapäivityksiä näistä, on suositeltavaa poistaa ne käytöstä.';

  @override
  String get noAdditionalSoftwareSourcesFound =>
      'Hyvä! Muita ohjelmistolähteitä ei löytynyt.';

  @override
  String get changePasswordDescription => 'Vaihda nykyisen käyttäjän salasana';

  @override
  String get userProfile => 'Käyttäjäprofiili';

  @override
  String get changeUserProfile => 'Muuta käyttäjätietoja';

  @override
  String get systemInformation => 'Järjestelmätiedot';

  @override
  String get distribution => 'Distribution';

  @override
  String get version => 'Version';

  @override
  String get desktop => 'Työpöytä';

  @override
  String get language => 'Kieli';

  @override
  String get next => 'Next';

  @override
  String get selectYourDistribution => 'Valitse jakelu';

  @override
  String get selectYourDesktop => 'Valitse työpöytäsi';

  @override
  String get isTheRecognizedSystemCorrect =>
      'Onko tunnistettu järjestelmäsi oikea?';

  @override
  String get noIWantToChange => 'Ei, haluan muuttaa';

  @override
  String get yes => 'Kyllä';

  @override
  String get recognizingSystem => 'Tunnistaa järjestelmä...';

  @override
  String get yourLinuxAssistant => 'Sinun. Linux. Assistant.';

  @override
  String get linuxAssistantLongDescription =>
      'Linux Assistant on jakeluriippumaton ja suunniteltu auttamaan ja opastamaan sinua päivittäisessä käytössäsi. Syötä vain muutama avainsana hakukenttään ja löydä mitä haluat! Linux Assistant sisältää hyödyllisiä pikakuvakkeita tiedostoihin, kansioihin ja sovelluksiin sekä myös on myös linkkejä asetuksiin ja esimerkiksi mukana tuleva PC-turvatarkistus.';

  @override
  String get welcomeToYourLinuxMachine => 'Tervetuloa uuteen linux-koneesi!';

  @override
  String get afterInstallationGreetingDescription =>
      'Seuraavien minuuttien aikana määrität Linux-koneesi tarpeidesi mukaan.';

  @override
  String get letsStart => 'Aloitetaan!';

  @override
  String get includeBasicSystemInformation =>
      'Sisällytä järjestelmän perustiedot';

  @override
  String get setUpXWithRecommendedSettings => 'Asennus';

  @override
  String get setUpXWithRecommendedSettingsPart2 =>
      'suositelluilla asetuksilla?';

  @override
  String get manualConfiguration => 'Manuaalinen konfigurointi';

  @override
  String get afterInstallationManualConfigurationDescription =>
      'Poistu tästä rutiinista ja hallitse kaikkia tietokoneesi muutoksia.';

  @override
  String get automaticConfiguration => 'Automaattinen määritys';

  @override
  String get applyConfiguration => 'Käytä ohjelmiston kokoonpanoa';

  @override
  String get thisProcessCouldTakeManyMinutesDependingSoftwareChoosed =>
      'This process could take many minutes depending on what software configuration you selected...';

  @override
  String get selectSpecificActionsOnTheNextSite =>
      'Valitse tietyt automaattiset toiminnot seuraavalla sivulla.';

  @override
  String get installMultimediaCodecs => 'Asenna multimediakoodekit';

  @override
  String get installMultimediaCodecsDescription =>
      'Asenna lisää omia multimediakoodeja videoiden ja musiikin toistamista varten.';

  @override
  String get automaticSnapshots => 'Automatic Snapshots';

  @override
  String get automaticSnapshotsDescription =>
      'Määritä automaattiset tilannekuvat ajansiirrolla. Timeshift määritetään kahteen kuukausittaiseen automaattiseen tilannekuvaan on';

  @override
  String get automaticNvidiaDriverInstallation =>
      'Automaattinen Nividia-Driver-asennus';

  @override
  String get automaticNvidiaDriverInstallationDesciption =>
      'Kaikki suositellut ohjaimet asennetaan.';

  @override
  String get automaticUpdateManagerConfiguration =>
      'Automatic Update Manager Configuration';

  @override
  String get feedbackPlaceholder =>
      'Puuttuuko sinulta hakutulos? Mitä haet? Onko sinulla parannusehdotuksia?...';

  @override
  String get automaticUpdateManagerConfigurationDescription =>
      'Automaattiset päivitykset ja (jos mukana) ylläpito määritetään.';

  @override
  String get welcomeToYourNewSystem => 'Tervetuloa uuteen järjestelmääsi!';

  @override
  String get automaticConfigurationIsRunningDescription =>
      'Järjestelmäsi määrittää ja käyttää ohjelmistokokoonpanoasi. Tämä prosessi voi kestää useita minuutteja riippuen valitsemistasi toiminnoista ja ohjelmistoista...';

  @override
  String get browserSelection => 'Selainvalinta';

  @override
  String get firefoxDescription =>
      'Mozillan avoimen lähdekoodin selain keskittyen yksityisyyteen.';

  @override
  String get chromiumDescription =>
      'Avoimen lähdekoodin selain. Ilmainen Google Chromen perusta.';

  @override
  String get braveDescription =>
      'Avoimen lähdekoodin selain keskittyen yksityisyyteen.';

  @override
  String get chromeDescription => 'Googlen oma selain.';

  @override
  String get thunderbirdDescription =>
      'Avoimen lähdekoodin sähköpostiohjelma Mozillalta.';

  @override
  String get jitsiDescription => 'Avoimen lähdekoodin videoneuvottelutyökalu.';

  @override
  String get elementDescription =>
      'Avoimen lähdekoodin viestintätyökalu, joka perustuu matriisiprotokollaan.';

  @override
  String get signalDescription =>
      'Avoimen lähdekoodin messenger. Toimii vain älypuhelinsovelluksen kanssa.';

  @override
  String get discordDescription => 'Yhteisön oma chat-ohjelmisto';

  @override
  String get zoomDescription => 'Omallinen konferenssiohjelmisto.';

  @override
  String get teamsDescription => 'Omallinen tiimiviestintäohjelmisto.';

  @override
  String get communicationSoftware => 'viestintäohjelmisto';

  @override
  String get flatpakIsNotInstalled =>
      'Flatpakia ei ole asennettu järjestelmääsi.';

  @override
  String get flatpakDescription =>
      'Helppo pääsyyn moniin suosittuihin sovelluksiin Flatpak on erittäin suositeltavaa. Flatpak on uusi apuohjelma paketinhallintaan Linuxille. Se tarjoaa hiekkalaatikkoympäristön, jossa sovellukset voivat toimia erillään muusta järjestelmästä. Sitomalla Flathub (suurin arkisto flatpakeille) saat käyttöösi yli 1800 erilaista Linux-sovellusta. Haittapuolena Flatpaks vaatii enemmän levytilaa.';

  @override
  String get skip => 'Ohita';

  @override
  String get settingUpFlatpak => 'Asenna Flatpak';

  @override
  String get officeSelection => 'Office Selection';

  @override
  String get libreOfficeDescription =>
      'Avoimen lähdekoodin Office Suite Document Foundationilta. Erinomainen avoimeen asiakirjamuotoon (.odt, .ods, .odp).';

  @override
  String get onlyOfficeDescription =>
      'Avoimen lähdekoodin Office Suite. Sopii Microsoftin asiakirjamuodolle (.docx, .xls, .ppt).';

  @override
  String get wpsOfficeDescription =>
      'Oma Office Suite. Sopii Microsoftin asiakirjamuodolle (.docx, .xls, .ppt).';

  @override
  String get includeSearchTermAndResults =>
      'Sisällytä hakutermi ja hakutulokset';

  @override
  String get submit => 'Lähetä';

  @override
  String get thankYouForTheFeedback => 'Kiitos palautteestasi!';

  @override
  String get feedbackSentSuccessfully =>
      'Palautteesi lähetettiin kehittäjille onnistuneesti.';

  @override
  String get close => 'Sulje';

  @override
  String get sendingFeedbackFailed => 'Palautteen lähettäminen epäonnistui.';

  @override
  String get sendingFeedback => 'Lähetetään palautetta...';

  @override
  String get startAfterInstallationRoutine => 'Aloita tietokoneen alkuasetus';

  @override
  String get timeToSetupYourComputer => 'Tietokoneen asennuksen aika';

  @override
  String get timeToSetupYourComputerDescription =>
      'Määritä linux-koneesi tarpeidesi mukaan.';

  @override
  String get activateHotkey => 'Aktivoi pikanäppäin';

  @override
  String get openLinuxAssistantFaster => 'Avaa Linux Assistant nopeammin.';

  @override
  String openLinuxAssistantFasterDescription(Object modifier) {
    return 'Voit avata Linux Assistantin näppäimillä $modifier + <Q>.\nTämä on erittäin suositeltavaa tuottavuuden maksimoimiseksi linuxissa.';
  }

  @override
  String get yesSetUpHotkey => 'Kyllä, asetusten pikanäppäin';

  @override
  String get introduction => 'Introduction';

  @override
  String get theFollowingContentCanBeSearched =>
      'Voit etsiä seuraavaa sisältöä:';

  @override
  String get applications => 'Applications';

  @override
  String get applicationSearchDescription =>
      'Etsi kaikki suosikkisovelluksesi ja käynnistä ne sekunnin murto-osassa.';

  @override
  String get folders => 'Kansiot';

  @override
  String get folderSearchDescription =>
      'Linux Assistant tarkistaa kaikki tärkeät kansiosi ja tarjoaa ne myös tulosluettelossasi.';

  @override
  String get recentFiles => 'Viimeaikaiset tiedostot';

  @override
  String get recentFilesDescription =>
      'Niin kauan kuin järjestelmäsi tallentaa äskettäin käytetyt tiedostot, voit löytää nämä ja myös tähdellä merkityt tiedostosi.';

  @override
  String get browserBookmarks => 'Selainselaimesi kirjanmerkit';

  @override
  String get browserBookmarksDescription =>
      'Löydä suosikkisivustosi, jos merkitsit ne kirjanmerkkeiksi verkkoselaimessasi.';

  @override
  String get specialFunctions => 'Linux-Assistantin erikoistoiminnot';

  @override
  String get specialFunctionsDescription =>
      'Aloita turvatarkastus tai asennuksen jälkeinen palvelu ja myös monet muut pienet rutiinit, jotka helpottavat päivittäistä linux-käyttöäsi. Nämä on esitetty hakupalkin alla radomisoidussa järjestyksessä.';

  @override
  String get hint => 'Vihje';

  @override
  String get youCanOpenThisWindowBySearchingForIntroduction =>
      'Voit avata tämän sivuston uudelleen hakemalla ';

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
    return 'Löydettiin $removableDevices irrotettavaa tallennuslaitetta/(osiota). Jos et tällä hetkellä tarvitse niitä, on suositeltavaa poistaa ne turvallisuussyistä ja näiden laitteiden terveydestä.';
  }

  @override
  String get removableDevicesPass =>
      'Siirrettäviä tallennuslaitteita ei havaittu.';

  @override
  String get swapsPass =>
      'Järjestelmäsi käyttää swap-tilaa. Sinun ei tarvitse tehdä mitään tälle asialle.';

  @override
  String get swapsWarning =>
      'Järjestelmässäsi ei ole sivutusmuistia. Jos muisti on täynnä, järjestelmälläsi ei ole enää mahdollisuutta vaihtaa sitä. Lisää järjestelmääsi joko swap-tiedosto tai swap-osio.';

  @override
  String get topMemoryProcesses =>
      'Tällä hetkellä eniten muistia vaativat prosessit';

  @override
  String get topCPUProcesses =>
      'Currently most computationally intensive processes';

  @override
  String get cpuUsage => 'CPU:n käyttö';

  @override
  String get memoryUsage => 'RAM-muistin käyttö';

  @override
  String get process => 'Process';

  @override
  String get runtime => 'Suoritusaika';

  @override
  String get memoryAndStorage => 'Muisti ja tallennus';

  @override
  String get applyUpdatesSinceRelease =>
      'Päivitä järjestelmä uusimpaan versioon';

  @override
  String applyUpdatesSinceReleaseDescription(Object distro) {
    return 'Nykyisen $distro-version julkaisusta lähtien päivityksiä voi olla saatavana. Ota nämä päivitykset käyttöön.';
  }

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hours';

  @override
  String get days => 'days';

  @override
  String get linuxAssistantKeyboardShortcut => 'Linux Assistantin pikanäppäin';

  @override
  String setUpLinuxAssistantKeyboardShortcut(Object modifier) {
    return 'Avaa Linux Assistant nopeasti mistä tahansa määrittämällä näppäimistön yhdistelmä $modifier + <Q>.';
  }

  @override
  String get update => 'Päivitä';

  @override
  String get aNewVersionIsAvailable => 'Uusi versio on saatavilla!';

  @override
  String get doYouWantToUpdateNow =>
      'Uudet ominaisuudet odottavat sinua. Haluatko päivittää Linux-Assistantin nyt? Tämä kestää yleensä vain muutaman sekunnin.';

  @override
  String get later => 'Myöhemmin';

  @override
  String get updateNow => 'Päivitä nyt';

  @override
  String get linuxAssistantIsUpdating =>
      'Linux-Assistant päivittää itseään. Sen jälkeen on suositeltavaa käynnistää sovellus uudelleen.';

  @override
  String get fix => 'Korjaa';

  @override
  String get hardInfoDescription => 'Järjestelmätiedot ja vertailutyökalu';

  @override
  String installX(Object app) {
    return 'Asenna $app';
  }

  @override
  String installingXDescription(Object app) {
    return 'Asennetaan $app...\nSinun on avattava $app sen jälkeen erikseen.';
  }

  @override
  String get redshiftDescription =>
      'Suodattaa sinistä valoa vähentääkseen silmien rasitusta.';

  @override
  String get redshiftIsInstalledAlready =>
      'Redshift on jo asennettu.\nAvaa Redshift itsenäisesti järjestelmävalikosta.';

  @override
  String get settings => 'Setting';

  @override
  String get searchSettings => 'Hakuasetukset';

  @override
  String get on => 'Päällä';

  @override
  String get off => 'Pois';

  @override
  String get includeApplications => 'Sisällytä sovellukset.';

  @override
  String get includeBasicFolders => 'Sisällytä peruskansiot.';

  @override
  String get includeRecentlyUsedFilesAndFolders =>
      'Sisällytä äskettäin käytetyt tiedostot ja kansiot.';

  @override
  String get includeFavoriteFilesAndFolderBookmarks =>
      'Sisällytä suosikkitiedostot ja kansion kirjanmerkit.';

  @override
  String get includeBrowserBookmarks => 'Sisällytä selaimen kirjanmerkit.';

  @override
  String get shutdown => 'Sammutus';

  @override
  String get shutdownDescription =>
      'Sammuta Linux-koneesi nyt tai aseta sille ajoitus.';

  @override
  String get shutdownIn => 'Sammutus sisään';

  @override
  String get exit => 'Poistu';

  @override
  String get exitDescription => 'Sulje Linux-Assistant.';

  @override
  String get appearance_settings => 'Ulkoasuasetukset';

  @override
  String get darkThemeEnabled => 'Tumma teema (uudelleenkäynnistys vaaditaan)';

  @override
  String get mainColorSetting => 'Pääväri (uudelleenkäynnistys vaaditaan)';

  @override
  String get secondaryColorSetting =>
      'Toissijainen väri (uudelleenkäynnistys vaaditaan)';

  @override
  String get colorfulBackground => 'Värillinen tausta';

  @override
  String get theFollowingCommandsWillBeExecuted =>
      'Seuraavat komennot suoritetaan';

  @override
  String get command => 'Komento';

  @override
  String get showCommands => 'Näytä komennot';

  @override
  String get hideCommands => 'Piilota komennot';

  @override
  String get description => 'Kuvaus';

  @override
  String get root => 'Juuri';

  @override
  String get no => 'No';

  @override
  String get selfLearningSearch => 'Itseoppiva haku';

  @override
  String get updateSystemDescription =>
      'Päivitä Linux-koneesi ja kaikki sovellukset (päivitykset).\nTämä prosessi voi kestää muutaman minuutin.';

  @override
  String get featureOverview => 'Ominaisuuden yleiskatsaus';

  @override
  String get powerMode => 'Virtatila';

  @override
  String get powerModeDescription =>
      'Vaihda virransäästö- ja suorituskykytilan välillä.';

  @override
  String get powerSaver => 'virransäästötila';

  @override
  String get performance => 'suorituskykytila';

  @override
  String get balanced => 'balansoitu tila';

  @override
  String get activate => 'Activate';

  @override
  String get active => 'Active';

  @override
  String get installPowerProfilesDeamonDescription =>
      'Virtatilan vaihtamiseen tarvitaan power-profiles-deamon. Haluatko asentaa tämän?';

  @override
  String get folderRecursionDepth => 'Kansion rekursion syvyys';

  @override
  String get shutdownAfterwards => 'Sammuta Linux jälkeenpäin';

  @override
  String get versionOfLinuxAssistant => 'Linux Assistantin versio';

  @override
  String get urls => 'URL-osoite';

  @override
  String get urlsDescription =>
      'Anna URL-osoite ja avaa se oletusselaimessasi.';

  @override
  String get packageWillBeInstalled =>
      'Pakettisi asennetaan hetken kuluttua...';

  @override
  String get thisApplicationWillBeRemoved => 'Tämä sovellus poistetaan.';

  @override
  String uninstallingXDescription(Object app) {
    return 'Poistetaan $app...';
  }

  @override
  String uninstallApp(Object app) {
    return 'Poista $app';
  }

  @override
  String uninstallAppWarning(Object app) {
    return 'Haluatko todella poistaa sovelluksen $app?\nJärjestelmä ei ehkä toimi kunnolla jälkeenpäin.\nPoista vain itse asentamasi ohjelmat.';
  }

  @override
  String get welcome => 'Tervetuloa!';

  @override
  String get flathubPermissionsDescription =>
      'Aloitamiseen tarvitaan vain kaksi lisävaihetta.\nJotta Linux-Assistant toimisi, se tarvitsee lisäasetuksia, joita ei voi määrittää oletusarvoisesti flathub.org-osoitteen vuoksi.\nLisäasetusten avulla Linux-Assistant voi käyttää Linuxi ja esim. hallita ohjelmistoja.\nLinux-Assistant on kuitenkin teknisesti rajoitettu, joten järjestelmän hallinta voi tapahtua vain luvallasi.\n\nSyötä seuraava komento päätteeseen ja paina Enter-näppäintä täysin ok.';

  @override
  String get pleaseRestartLinuxAssistant =>
      'Sen jälkeen Linux-Assistant on käynnistettävä uudelleen kerran. Poistu Linux-Assistantista ja käynnistä se välittömästi uudelleen. Nähdään pian!';

  @override
  String get cleanDiskspace => 'Tyhjennä levytila';

  @override
  String get cleanDiskspaceDescription =>
      'Puhdista levytila ​​poistamalla vanhat paketit ja välimuistit.';

  @override
  String get clean => 'Clean';

  @override
  String get cleaningDiskspace => 'Siivotaan levytilaa...';

  @override
  String get free => 'Free';

  @override
  String cleanX(Object app) {
    return 'Puhdista $app';
  }

  @override
  String get removeSoftware => 'Poista ohjelmisto';

  @override
  String get remove => 'Poista';

  @override
  String get back => 'Takaisin';

  @override
  String get analyseDiskspace => 'Analysoi levytila';

  @override
  String get allBiggestFolders => 'Kaikki suurimmat kansiot';

  @override
  String get automaticCleanup => 'Automaattinen puhdistus';

  @override
  String get automaticCleanupDescription =>
      'Tyhjennä tallennustila automaattisesti poistamalla väliaikaiset tiedostot ja pakettivälimuistit. Myös roskakorit tyhjennetään.';

  @override
  String get diskUsage => 'Levyn käyttö';

  @override
  String get settingUpFirewall => 'Määritä palomuuri...';

  @override
  String get fixPackageManager => 'Korjaa paketin hallinta';

  @override
  String get fixPackageManagerDescription =>
      'Eikö päivityksiä tai asennuksia voi enää suorittaa? Kokeile paketinhallinnan automaattista korjausta.';

  @override
  String get executeInTerminal => 'Suorita terminaalissa';

  @override
  String get setupSnap => 'Asenna Snap';

  @override
  String get setupSnapDescription =>
      'Asenna Snap ja Snap Store asentaaksesi monia muita sovelluksia.\nSen jälkeen suositellaan tietokoneen uudelleenkäynnistystä.';

  @override
  String get vivaldiDescription =>
      'Oma selain, joka keskittyy yksityisyyteen ja moniin mukautusvaihtoehtoihin.';

  @override
  String get makeAdministrator =>
      'Tee nykyisestä käyttäjästä järjestelmänvalvoja';

  @override
  String get makeAdministratorDescription =>
      'Lisää nykyinen käyttäjä \'sudo\'-ryhmään saadaksesi pääkäyttäjän oikeudet. Pääkäyttäjän salasana vaaditaan tätä varten.\nSen jälkeen suositellaan tietokoneen uudelleenkäynnistämistä.';

  @override
  String get yayInstalled =>
      'Yay löydettiin. Yay on AUR-apuohjelma, joka helpottaa AUR-pakettien asentamista. AUR on yhteisön arkisto, jossa yhteisö ylläpitää monia paketteja, jotka voivat olla haitallisia.';

  @override
  String get openSoftwareCenter => 'Avaa ohjelmistokeskus';

  @override
  String get openSoftwareCenterDescription =>
      'Avaa Ohjelmistokeskus asentaaksesi lisäsovelluksia/sovelluksia.';

  @override
  String get disableCdromSource => 'Poista CD-ROM-lähde käytöstä';

  @override
  String get disableCdromSourceDescription =>
      'Debian-asennuksen jäänne. Poista CDROM-lähde käytöstä virheilmoituksien välttämiseksi.';

  @override
  String get grubConfiguration => 'Grub-kokoonpano';

  @override
  String get grubConfigurationDescription =>
      'Määritä Grub-käynnistyslatain. Tätä vaihetta suositellaan vain kokeneille käyttäjille.';

  @override
  String get grubVisible => 'Käynnistysvalikko näkyvissä';

  @override
  String get enableBigFont => 'Ota suuri fontti käyttöön';

  @override
  String get grubCountdown =>
      'Automaattiseen käynnistykseen kuluva aika (sekunteina)';

  @override
  String get startLastBootedEntry => 'Aloita viimeisin käynnistetty merkintä';

  @override
  String get save => 'Tallenna';

  @override
  String get distribution_selection => 'Jakelun valinta';

  @override
  String get copyCommands => 'Kopioi komennot';

  @override
  String get errorThisDidntWork => 'Se ei toiminut.';

  @override
  String get complete => 'Täydellinen';

  @override
  String get hideFolders => 'Piilota kansiot';

  @override
  String get showFolders => 'Näytä kansiot';

  @override
  String get hidePackageManagerActions => 'Piilota paketinhallinnan toiminnot';

  @override
  String get showPackageManagerActions => 'Näytä paketinhallinnan toiminnot';
}
