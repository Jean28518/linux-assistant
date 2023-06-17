import 'dart:io';
import 'package:tuple/tuple.dart';

abstract class CommandHelper {
  static Future<Tuple2<bool, String>> run(String cmd,
      {Map<String, String>? env, bool asRoot = false}) async {
    return await runWithArguments(cmd, [], env: env, asRoot: asRoot);
  }

  static Future<Tuple2<bool, String>> runWithArguments(
      String cmd, List<String> args,
      {Map<String, String>? env, bool asRoot = false}) async {
    if (asRoot) {
      if (args.isEmpty) {
        args.add(cmd);
      } else {
        args.insert(0, cmd);
      }

      cmd = "pkexec";
    }

    try {
      var procResult = await Process.run(cmd, args, environment: env);
      return procResult.exitCode == 0
          ? Tuple2(true, procResult.stdout.toString().trim())
          : Tuple2(false, procResult.stderr.toString().trim());
    } on ProcessException catch (e) {
      return Tuple2(false, e.message);
    }
  }
}
