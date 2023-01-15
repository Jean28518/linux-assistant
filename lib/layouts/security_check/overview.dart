import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/mintY.dart';
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
          if (lines[0].contains("must run as root!") ||
              lines[0].contains("Request dismissed")) {
            return Scaffold(
                body: MintYPage(
              title: AppLocalizations.of(context)!.securityCheck,
              contentElements: [
                Text(
                  AppLocalizations.of(context)!
                      .securityCheckFailedBecauseNoRoot,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                )
              ],
              bottom: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MintYButtonNavigate(
                    route: const MainSearchLoader(),
                    text: Text(AppLocalizations.of(context)!.cancel,
                        style: MintY.heading2),
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  MintYButtonNavigate(
                    route: const SecurityCheckOverview(),
                    text: Text(AppLocalizations.of(context)!.retry,
                        style: MintY.heading2White),
                    color: MintY.currentColor,
                  ),
                ],
              ),
            ));
          }

          // At first set everything to "safe":
          List<String> additionalSources = [];
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
              AdditionSoftwareSources(additionalSources: additionalSources),
              SizedBox(height: 16),
              UpdateCheck(availableUpdatePackages: availableUpdatePackages),
              SizedBox(height: 16),
              HomeFolderSecurityCheck(homeFolderSecure: homeFolderSecure),
              SizedBox(height: 16),
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
                      style: MintY.heading3),
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                MintYButtonNavigate(
                  route: const SecurityCheckOverview(),
                  text: Text(AppLocalizations.of(context)!.reload,
                      style: MintY.heading3White),
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
        style: Theme.of(context).textTheme.headline2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: availableUpdatePackages == 0
              ? SuccessMessage(
                  text: AppLocalizations.of(context)!.systemIsUpToDate,
                )
              : WarningMessage(
                  text:
                      "${availableUpdatePackages} ${AppLocalizations.of(context)!.xPackagesShouldBeUpdated}"))
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
        style: Theme.of(context).textTheme.headline2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: homeFolderSecure
              ? SuccessMessage(
                  text: AppLocalizations.of(context)!.homeFolderRightsOkay,
                )
              : WarningMessage(
                  text: AppLocalizations.of(context)!.homeFolderRightsNotOkay))
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
        style: Theme.of(context).textTheme.headline2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              firewallNotInstalled
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!.noFirewallRecognized,
                    )
                  : firewallRunning
                      ? SuccessMessage(
                          text: AppLocalizations.of(context)!.firewallIsRunning)
                      : WarningMessage(
                          text:
                              AppLocalizations.of(context)!.firewallIsInactive),
              SizedBox(height: 8),
              sshRunning
                  ? WarningMessage(
                      text:
                          AppLocalizations.of(context)!.sshFoundOnYourComputer)
                  : Container(),
              SizedBox(height: 8),
              (sshRunning && !fail2banRunning)
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!.noFail2BanFound)
                  : Container(),
              SizedBox(height: 8),
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
  }) : super(key: key);

  final List<String> additionalSources;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.additionalSoftwareSources,
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: additionalSources.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WarningMessage(
                        text: AppLocalizations.of(context)!
                            .additionalSoftwareSourcesDetected),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey),
                      padding: EdgeInsets.all(8),
                      height: additionalSources.length.toDouble() * 16.0 + 16.0,
                      child: ListView.builder(
                        primary: false,
                        itemCount: additionalSources.length,
                        itemBuilder: (context, index) {
                          return Text(additionalSources[index]);
                        },
                      ),
                    ),
                  ],
                )
              : SuccessMessage(
                  text: AppLocalizations.of(context)!
                      .noAdditionalSoftwareSourcesFound),
        )
      ],
    );
  }
}
