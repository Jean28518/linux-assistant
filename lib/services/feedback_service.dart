import 'dart:convert';

import 'package:linux_assistant/models/action_entry.dart';
import 'package:http/http.dart' as http;
import 'package:linux_assistant/models/enviroment.dart';
import 'package:linux_assistant/services/linux.dart';

class FeedbackService {
  static Future<bool> send_feedback(
      String message,
      List<ActionEntry> entries,
      String searchTerm,
      bool includeBasicSystemInformation,
      bool includeSearchTermnAndSearchResults) async {
    List<Map<String, dynamic>> entriesJson = [];

    if (!includeSearchTermnAndSearchResults) {
      searchTerm = "!Not included!";
    } else {
      entries.forEach((element) {
        entriesJson.add(element.toJson());
      });
    }

    Map<String, dynamic> environment;
    if (!includeBasicSystemInformation) {
      environment = Map<String, dynamic>();
    } else {
      environment = Linux.currentEnviroment.toJson();
    }

    http.Response response = await http
        .post(
          Uri.parse('http://localhost:8000/submit/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'message': message,
            'entries': entriesJson,
            'searchTerm': searchTerm,
            'environment': environment,
          }),
        )
        .timeout(Duration(seconds: 10));

    return (response.statusCode == 200);
  }
}
