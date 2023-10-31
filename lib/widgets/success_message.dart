import 'package:flutter/material.dart';

class SuccessMessage extends StatelessWidget {
  late String text;
  SuccessMessage({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            size: 32,
            color: Colors.green,
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
