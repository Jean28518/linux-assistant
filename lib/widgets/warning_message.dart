import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WarningMessage extends StatelessWidget {
  late String text;
  WarningMessage({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          const Icon(
            Icons.warning,
            size: 32,
            color: Colors.orange,
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
