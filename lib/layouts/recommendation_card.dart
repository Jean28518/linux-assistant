import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 500,
        height: 150,
        padding: EdgeInsets.all(10),
        child: Row(children: [
          Icon(Icons.star),
          Container(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Überschrift",
                style: TextStyle(fontSize: 24),
              ),
              Text("Beschreibung Bla Bla")
            ],
          )
        ]),
      ),
    );
  }
}
