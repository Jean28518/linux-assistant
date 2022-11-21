import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';

class ActionEntryCard extends StatefulWidget {
  ActionEntryCard(
      {required this.actionEntry,
      required this.callback,
      this.selected = false});

  final ActionEntry actionEntry;
  final VoidCallback callback;
  final selected;

  @override
  State<ActionEntryCard> createState() => _ActionEntryCardState();
}

class _ActionEntryCardState extends State<ActionEntryCard> {
  Timer? iconLoading;
  late Widget icon;
  bool systemIconLoaded = false;
  String _lastAction = "";

  @override
  Widget build(BuildContext context) {
    // assert(debugCheckHasMaterial(context));
    if (!systemIconLoaded) {
      icon = getIcon();
    } else {
      systemIconLoaded = false;
    }
    return Card(
      child: InkWell(
        child: ListTile(
          key: UniqueKey(),
          tileColor: widget.selected
              ? Theme.of(context).focusColor
              : Color.fromARGB(0, 0, 0, 0),
          hoverColor: Colors.grey,
          title: Text(widget.actionEntry.name),
          subtitle: Text(widget.actionEntry.description),
          // For debugging search index:
          // subtitle: Text(
          //     "${actionEntry.description} | ${actionEntry.priority} | ${actionEntry.tmpPriority}"),
          leading: icon,
        ),
        onTap: () {
          ActionHandler.handleActionEntry(
              widget.actionEntry, widget.callback, context);
        },
      ),
    );
  }

  Widget getIcon() {
    if (widget.actionEntry.iconWidget != null) {
      return widget.actionEntry.iconWidget!;
    }

    // If icon is in the cache, then return it instantly:
    IconLoader iconLoader = IconLoader();
    if (widget.actionEntry.action.startsWith("openapp:") &&
        iconLoader.isIconLoaded(widget.actionEntry.iconURI, iconSize: 48)) {
      return iconLoader.getIconFromCache(widget.actionEntry.iconURI,
          iconSize: 48);
    }

    // Only cancel and start loading new if the action changed.
    if (_lastAction != widget.actionEntry.action) {
      iconLoading?.cancel();
      // We do this icon loading delay here because at the beginning when the user types many search results
      // appear for which the user isn't looking.
      // So we only keep loading the icons, which live more than 200 milliseconds.
      iconLoading =
          Timer(const Duration(milliseconds: 200), () => _loadSystemIcon());
    }
    _lastAction = widget.actionEntry.action;

    if (widget.actionEntry.action.startsWith("openfolder:")) {
      return const Icon(
        Icons.folder,
        size: 48,
      );
    }
    if (widget.actionEntry.action.startsWith("openapp:")) {
      return const Icon(
        Icons.settings,
        size: 48,
      );
    }
    if (widget.actionEntry.action.startsWith("websearch:")) {
      return const Icon(
        Icons.search,
        size: 48,
      );
    }
    if (widget.actionEntry.action.startsWith("openwebsite:")) {
      return const Icon(
        Icons.web,
        size: 48,
      );
    }
    if (widget.actionEntry.action.startsWith("openfile:")) {
      return const Icon(
        Icons.description,
        size: 48,
      );
    }
    return (const Icon(
      Icons.star,
      size: 48,
    ));
  }

  void dispose() {
    iconLoading?.cancel();
    super.dispose();
  }

  void _loadSystemIcon() {
    if (widget.actionEntry.action.startsWith("openapp:")) {
      icon = SystemIcon(
        iconString: widget.actionEntry.iconURI,
        iconSize: 48,
        spinner: false,
      );
      systemIconLoaded = true;
      setState(() {});
    }
  }
}
