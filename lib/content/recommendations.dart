import 'package:flutter/material.dart';
import 'package:linux_helper/models/action_entry.dart';

final recommendations = [
  ActionEntry(
    name: "Security Check",
    description: "Keep the security of your computer in track.",
    action: "security_check",
    iconWidget: const Icon(
      Icons.safety_check,
      size: 48,
    ),
  ),
  ActionEntry(
    name: "Warpinator",
    description:
        "Send files quickly over the local network.\nTo android, iOS and Windows.",
    action: "send_files_via_warpinator",
    iconWidget: const Icon(
      Icons.send,
      size: 48,
    ),
  ),
  ActionEntry(
    name: "After Installation",
    description: "Set up your linux machine to your needs. ",
    action: "after_installation",
    iconWidget: const Icon(
      Icons.start,
      size: 48,
    ),
  ),
];
