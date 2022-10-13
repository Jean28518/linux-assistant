import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rand = Random().nextInt(recommendations.length);
    ActionEntry entry = recommendations[rand];
    return Card(
      child: InkWell(
        onTap: () {
          ActionHandler.handleActionEntry(entry, () {}, context);
        },
        child: Container(
          width: 400,
          height: 100,
          padding: EdgeInsets.all(10),
          child: Row(children: [
            entry.iconWidget,
            Container(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(fontSize: 24),
                ),
                Text(entry.description)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
