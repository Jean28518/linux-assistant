import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_helper/layouts/loading_indicator.dart';
import 'package:linux_helper/layouts/mintY.dart';
import 'package:linux_helper/services/linux.dart';
import 'package:linux_helper/services/main_search_loader.dart';

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
              title: "Security Check",
              contentElements: [
                Text(
                  "That didn't work. You need root rights to run the security check.",
                  style: MintY.heading2,
                  textAlign: TextAlign.center,
                )
              ],
              bottom: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MintYButtonNavigate(
                    route: const MainSearchLoader(),
                    text: Text("Cancel", style: MintY.heading2),
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  MintYButtonNavigate(
                    route: const SecurityCheckOverview(),
                    text: Text("Retry", style: MintY.heading2White),
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
            title: "Security Check",
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
                  text: Text("Back to search", style: MintY.heading2),
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                MintYButtonNavigate(
                  route: const SecurityCheckOverview(),
                  text: Text("Reload", style: MintY.heading2White),
                  color: Colors.blue,
                ),
              ],
            ),
          ));
        } else {
          return LoadingIndicator(text: "Analysing system security...");
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
      const Text(
        "Updates",
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: availableUpdatePackages == 0
              ? SecuritySuccessMessage(
                  text: "Great! Your system is up to date.",
                )
              : SecurityWarningMessage(
                  text:
                      "${availableUpdatePackages} Packages could be updated."))
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
      const Text(
        "Home Folder",
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: homeFolderSecure
              ? SecuritySuccessMessage(
                  text:
                      "Your home folder rights are okay. Others can't see your files.",
                )
              : SecurityWarningMessage(
                  text:
                      "Your home folder is not secure. Other users could see your files."))
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
      const Text(
        "Network Security",
        style: MintY.heading2,
      ),
      Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              firewallNotInstalled
                  ? SecurityWarningMessage(
                      text:
                          "No firewall recognized on your system.\nA firewall is recommended for computers with access from the internet.",
                    )
                  : firewallRunning
                      ? SecuritySuccessMessage(
                          text: "Your firewall is up and running. Great job!")
                      : SecurityWarningMessage(
                          text:
                              "Your firewall is inactive.\nA firewall is recommended for computers with access from the internet."),
              SizedBox(height: 8),
              sshRunning
                  ? SecurityWarningMessage(
                      text:
                          "SSH server found on your computer. Your computer could be accessible from the outside.\nUninstall ssh-server if you don't need it.")
                  : Container(),
              SizedBox(height: 8),
              (sshRunning && !fail2banRunning)
                  ? SecurityWarningMessage(
                      text:
                          "No fail2ban instance found on your computer.\nWith it your computer is more imune to ssh brute force attacks.")
                  : Container(),
              SizedBox(height: 8),
              xrdpRunning
                  ? SecurityWarningMessage(
                      text:
                          "Xrdp is running at your computer. It's recommended to uninstall if you don't really need it.")
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
          "Additional Software Sources",
          style: MintY.heading2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: additionalSources.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecurityWarningMessage(
                        text:
                            "Some additional software sources where found. These are potentially unsafe.\nIf you don't need security updates from these it is recommended to deactivate them."),
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
                  text: "Good! No additional software sources found."),
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
