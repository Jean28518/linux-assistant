import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecurityCheckOverview extends StatelessWidget {
  const SecurityCheckOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Linux.executableFolder = Linux.getExecutableFolder();
    print(Linux.currentEnviroment);
    Future<String> checkerOutputString =
        Linux.runCommandWithCustomArgumentsAndGetStdOut(
            "pkexec",
            [
              "/usr/bin/python3",
              "${Linux.executableFolder}additional/python/check_security.py",
              "--home=${Platform.environment['HOME']}",
            ],
            getErrorMessages: true);
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
                  style: MintY.heading2,
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
                    color: Colors.blue,
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
              additionalSources.add(
                  line.replaceFirst("additionalsource: ", "").split(" ")[0]);
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
                  color: Colors.blue,
                ),
              ],
            ),
          ));
        } else {
          return LoadingIndicator(
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
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: availableUpdatePackages == 0
              ? SecuritySuccessMessage(
                  text: AppLocalizations.of(context)!.systemIsUpToDate,
                )
              : SecurityWarningMessage(
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
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: homeFolderSecure
              ? SecuritySuccessMessage(
                  text: AppLocalizations.of(context)!.homeFolderRightsOkay,
                )
              : SecurityWarningMessage(
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
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              firewallNotInstalled
                  ? SecurityWarningMessage(
                      text: AppLocalizations.of(context)!.noFirewallRecognized,
                    )
                  : firewallRunning
                      ? SecuritySuccessMessage(
                          text: AppLocalizations.of(context)!.firewallIsRunning)
                      : SecurityWarningMessage(
                          text:
                              AppLocalizations.of(context)!.firewallIsInactive),
              SizedBox(height: 8),
              sshRunning
                  ? SecurityWarningMessage(
                      text:
                          AppLocalizations.of(context)!.sshFoundOnYourComputer)
                  : Container(),
              SizedBox(height: 8),
              (sshRunning && !fail2banRunning)
                  ? SecurityWarningMessage(
                      text: AppLocalizations.of(context)!.noFail2BanFound)
                  : Container(),
              SizedBox(height: 8),
              xrdpRunning
                  ? SecurityWarningMessage(
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
          style: MintY.heading2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: additionalSources.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecurityWarningMessage(
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
              : SecuritySuccessMessage(
                  text: AppLocalizations.of(context)!
                      .noAdditionalSoftwareSourcesFound),
        )
      ],
    );
  }
}

class SecuritySuccessMessage extends StatelessWidget {
  late String text;
  SecuritySuccessMessage({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check,
          size: 32,
          color: Colors.green,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(children: [
          Text(
            text,
            style: MintY.paragraph,
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
          )
        ]),
      ],
    );
  }
}

class SecurityWarningMessage extends StatelessWidget {
  late String text;
  SecurityWarningMessage({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.warning,
          size: 32,
          color: Colors.orange,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: MintY.paragraph,
        ),
      ],
    );
  }
}
