import 'package:linux_assistant/models/action_entry.dart';

class FeedbackService {
  static void send_feedback(
      String message,
      List<ActionEntry> entries,
      String searchTerm,
      bool includeBasicSystemInformation,
      bool includeSearchTermnAndSearchResults) {
    entries.forEach((element) {
      print("$element\n");
    });
  }
}
