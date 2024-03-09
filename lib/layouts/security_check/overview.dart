import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/widgets/success_message.dart';
import 'package:linux_assistant/widgets/warning_message.dart';

class SecurityCheckOverview extends StatelessWidget {
  const SecurityCheckOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> checkerOutputString;

    if (Linux.currentenvironment.distribution == DISTROS.OPENSUSE) {
      checkerOutputString = Linux.runPythonScript("check_security_opensuse.py",
          root: true,
          arguments: ["--home=${Platform.environment['HOME']}"],
          getErrorMessages: true);
    } else if (Linux.currentenvironment.distribution == DISTROS.FEDORA) {
      checkerOutputString = Linux.runPythonScript("check_security_fedora.py",
          root: true,
          arguments: ["--home=${Platform.environment['HOME']}"],
          getErrorMessages: true);
    } else if (Linux.currentenvironment.distribution == DISTROS.ARCH) {
      checkerOutputString = Linux.runPythonScript("check_security_arch.py",
          root: true,
          arguments: ["--home=${Platform.environment['HOME']}"],
          getErrorMessages: true);
    } else {
      checkerOutputString = Linux.runPythonScript("check_security.py",
          root: true,
          arguments: ["--home=${Platform.environment['HOME']}"],
          getErrorMessages: true);
    }

    return FutureBuilder<String>(
      future: checkerOutputString,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!);
          List<String> lines = snapshot.data!.split("\n");
          if (!snapshot.data!.contains("#!script ran successfully.")) {
            return Scaffold(
                body: MintYPage(
              title: AppLocalizations.of(context)!.securityCheck,
              contentElements: [
                Text(
                  AppLocalizations.of(context)!
                      .securityCheckFailedBecauseNoRoot,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                )
              ],
              bottom: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MintYButtonNavigate(
                    route: const MainSearchLoader(),
                    text: Text(AppLocalizations.of(context)!.cancel,
                        style: MintY.heading4),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  MintYButtonNavigate(
                    route: const SecurityCheckOverview(),
                    text: Text(AppLocalizations.of(context)!.retry,
                        style: MintY.heading4White),
                    color: MintY.currentColor,
                  ),
                ],
              ),
            ));
          }

          // At first set everything to "safe":
          List<String> additionalSources = [];
          bool yayInstalled = false;
          int availableUpdatePackages = 0;
          bool homeFolderSecure = true;
          bool firewallNotInstalled = false;
          bool firewallRunning = true;
          bool sshRunning = false;
          bool xrdpRunning = false;
          bool fail2banRunning = true;
          // Then if errors are recongized, then set the specific vars to "unsafe":
          for (String line in lines) {
            if (line.startsWith("additionalsource:")) {
              additionalSources
                  .add(line.replaceFirst("additionalsource: ", ""));
            }
            if (line.startsWith("yayinstalled")) {
              yayInstalled = true;
            }
            if (line.startsWith("upgradeablepackage:")) {
              availableUpdatePackages++;
            }
            if (line.startsWith("homefoldernotsecure:")) {
              homeFolderSecure = false;
            }
            if (line.startsWith("firewallinactive")) {
              firewallRunning = false;
            }
            if (line.startsWith("nofirewall")) {
              firewallNotInstalled = true;
            }
            if (line.startsWith("xrdprunning")) {
              xrdpRunning = true;
            }
            if (line.startsWith("sshrunning")) {
              sshRunning = true;
            }
            if (line.startsWith("fail2bannotrunning")) {
              fail2banRunning = false;
            }
          }

          return Scaffold(
              body: MintYPage(
            title: AppLocalizations.of(context)!.securityCheck,
            contentElements: [
              AdditionSoftwareSources(
                  additionalSources: additionalSources,
                  yayInstalled: yayInstalled),
              const SizedBox(height: 16),
              UpdateCheck(availableUpdatePackages: availableUpdatePackages),
              const SizedBox(height: 16),
              HomeFolderSecurityCheck(homeFolderSecure: homeFolderSecure),
              const SizedBox(height: 16),
              NetworkSecurityCheck(
                  firewallNotInstalled: firewallNotInstalled,
                  firewallRunning: firewallRunning,
                  sshRunning: sshRunning,
                  xrdpRunning: xrdpRunning,
                  fail2banRunning: fail2banRunning),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  route: const MainSearchLoader(),
                  text: Text(AppLocalizations.of(context)!.backToSearch,
                      style: MintY.heading4),
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                MintYButtonNavigate(
                  route: const SecurityCheckOverview(),
                  text: Text(AppLocalizations.of(context)!.reload,
                      style: MintY.heading4White),
                  color: MintY.currentColor,
                ),
              ],
            ),
          ));
        } else {
          return MintYLoadingPage(
              text: AppLocalizations.of(context)!.analysingSystemSecurity);
        }
      },
    );
  }
}

class UpdateCheck extends StatelessWidget {
  const UpdateCheck({
    Key? key,
    required this.availableUpdatePackages,
  }) : super(key: key);

  final int availableUpdatePackages;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context)!.updates,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: availableUpdatePackages == 0
              ? SuccessMessage(
                  text: AppLocalizations.of(context)!.systemIsUpToDate,
                )
              : WarningMessage(
                  text:
                      "$availableUpdatePackages ${AppLocalizations.of(context)!.xPackagesShouldBeUpdated}",
                  fixAction: () {
                    Linux.updateAllPackages();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RunCommandQueue(
                            title: AppLocalizations.of(context)!.update,
                            route: const SecurityCheckOverview())));
                  },
                ))
    ]);
  }
}

class HomeFolderSecurityCheck extends StatelessWidget {
  const HomeFolderSecurityCheck({
    Key? key,
    required this.homeFolderSecure,
  }) : super(key: key);

  final bool homeFolderSecure;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context)!.homeFolder,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: homeFolderSecure
              ? SuccessMessage(
                  text: AppLocalizations.of(context)!.homeFolderRightsOkay,
                )
              : WarningMessage(
                  text: AppLocalizations.of(context)!.homeFolderRightsNotOkay,
                  fixAction: () async {
                    await Linux.fixHomeFolderPermissions();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SecurityCheckOverview(),
                    ));
                  },
                ))
    ]);
  }
}

class NetworkSecurityCheck extends StatelessWidget {
  const NetworkSecurityCheck({
    Key? key,
    required this.firewallNotInstalled,
    required this.firewallRunning,
    required this.sshRunning,
    required this.xrdpRunning,
    required this.fail2banRunning,
  }) : super(key: key);

  final bool firewallNotInstalled;
  final bool firewallRunning;
  final bool sshRunning;
  final bool xrdpRunning;
  final bool fail2banRunning;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context)!.networkSecurity,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              firewallNotInstalled
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!.noFirewallRecognized,
                      fixAction: () {
                        Linux.installAndConfigureFirewall(
                            context, const SecurityCheckOverview());
                      },
                    )
                  : firewallRunning
                      ? SuccessMessage(
                          text: AppLocalizations.of(context)!.firewallIsRunning)
                      : WarningMessage(
                          text:
                              AppLocalizations.of(context)!.firewallIsInactive,
                          fixAction: () {
                            Linux.installAndConfigureFirewall(
                                context, const SecurityCheckOverview());
                          },
                        ),
              const SizedBox(height: 8),
              sshRunning
                  ? WarningMessage(
                      text:
                          AppLocalizations.of(context)!.sshFoundOnYourComputer)
                  : Container(),
              const SizedBox(height: 8),
              (sshRunning && !fail2banRunning)
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!.noFail2BanFound)
                  : Container(),
              const SizedBox(height: 8),
              xrdpRunning
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!
                          .xrdpRunningOnYourComputer)
                  : Container(),
            ],
          ))
    ]);
  }
}

class AdditionSoftwareSources extends StatelessWidget {
  const AdditionSoftwareSources({
    Key? key,
    required this.additionalSources,
    required this.yayInstalled,
  }) : super(key: key);

  final List<String> additionalSources;
  final bool yayInstalled;

  @override
  Widget build(BuildContext context) {
    List<Widget> additionalSourceTexts = [];
    for (var element in additionalSources) {
      additionalSourceTexts.add(Text(element));
    }

    // If yay is installed, then we show a warning message instead of the success message.
    Widget ourChild = SuccessMessage(
        text: AppLocalizations.of(context)!.noAdditionalSoftwareSourcesFound);

    if (yayInstalled) {
      ourChild = WarningMessage(
        text: AppLocalizations.of(context)!.yayInstalled,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.additionalSoftwareSources,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: additionalSources.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WarningMessage(
                        text: AppLocalizations.of(context)!
                            .additionalSoftwareSourcesDetected,
                        fixAction: () {
                          Linux.openAdditionalSoftwareSourcesSettings();
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.grey),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: additionalSourceTexts,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                // If no software source found we wether show a correct success message or a warning message if yay is installed.
                : ourChild)
      ],
    );
  }
}
