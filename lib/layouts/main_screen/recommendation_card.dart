import 'dart:math';
import 'package:flutter/material.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rand = Random().nextInt(getRecommendations(context).length);
    ActionEntry entry = getRecommendations(context)[rand];
    return Card(
      child: InkWell(
        onTap: () {
          ActionHandler.handleActionEntry(entry, () {}, context);
        },
        child: SizedBox(
          width: 450,
          height: 120,
          child: Row(children: [
            SizedBox(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  entry.iconWidget!,
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  width: 290,
                  child: Text(
                    entry.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
