import 'package:flutter/material.dart';

typedef BoolCallback = bool Function();

class ActionEntry {
  late String name;
  late String description;
  late String action;
  late String iconURI;
  late double priority;
  late List<String> keywords;
  late Widget? iconWidget; // Currently only used by recommendation_cards
  late double tmpPriority;
  final BoolCallback? disableEntryIf;

  /// If true, this entry will not be shown in the search bar at the start screen randomly.
  final bool excludeFromSearchProposal;

  ActionEntry(
      {required this.name,
      required this.description,
      required this.action,
      this.iconURI = "",
      this.priority = 0,
      this.keywords = const [],
      this.iconWidget,
      this.tmpPriority = 0,
      this.disableEntryIf,
      this.excludeFromSearchProposal = false});

  @override
  String toString() {
    return "ActionEntry: (name: $name; description: $description; action: $action, iconURI: $iconURI, priority: $priority, tmpPriority: $tmpPriority, iconWidget: $iconWidget, excludeFromSearchProposal: $excludeFromSearchProposal)";
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "action": action,
      "iconURI": iconURI,
      "priority": priority,
      "tmpPriority": priority,
      "iconWidget": iconWidget.toString(),
      "excludeFromSearchProposal": excludeFromSearchProposal.toString(),
    };
  }
}
