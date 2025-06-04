import 'package:linux_assistant/models/action_entry.dart';
import 'package:mutex/mutex.dart';

// This should be static and capable of parallel execution
class ActionEntryListService {
  static List<ActionEntry> entries = [];

  static Mutex mutex = Mutex();

  static Future<void> addEntry(ActionEntry entry) async {
    await mutex.acquire();
    entries.add(entry);
    mutex.release();
  }

  static Future<void> addEntries(List<ActionEntry> newEntries) async {
    await mutex.acquire();
    entries.addAll(newEntries);
    mutex.release();
  }

  static Future<void> clearEntries() async {
    await mutex.acquire();
    entries.clear();
    mutex.release();
  }

  static Future<List<ActionEntry>> getEntries() async {
    await mutex.acquire();
    List<ActionEntry> copy = List.from(entries);
    mutex.release();
    return copy;
  }

  static Future<void> removeEntry(ActionEntry entry) async {
    await mutex.acquire();
    entries.remove(entry);
    mutex.release();
  }
}
