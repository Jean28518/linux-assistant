import 'dart:convert';

import 'package:linux_assistant/models/action_entry.dart';
import 'package:http/http.dart' as http;
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
      for (var element in entries) {
        entriesJson.add(element.toJson());
      }
    }

    Map<String, dynamic> environment;
    if (!includeBasicSystemInformation) {
      environment = <String, dynamic>{};
    } else {
      environment = Linux.currentenvironment.toJson();
    }

    http.Response response = await http
        .post(
          Uri.parse('https://feedback.server-jean.de/submit/'),
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
        .timeout(const Duration(seconds: 10));

    return (response.statusCode == 200);
  }
}
