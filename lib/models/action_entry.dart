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

  /// Handler Function which takes a string.
  /// This function is called when the action String is empty by the action_handler.
  /// VoidCallback is usally used to get back to start screen and to minimize the window.
  late Function(VoidCallback, BuildContext)? handlerFunction;

  ActionEntry({
    required this.name,
    required this.description,
    this.action = "",
    this.handlerFunction,
    this.iconURI = "",
    this.priority = 0,
    this.keywords = const [],
    this.iconWidget,
    this.tmpPriority = 0,
    this.disableEntryIf,
    this.excludeFromSearchProposal = false,
  });

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
