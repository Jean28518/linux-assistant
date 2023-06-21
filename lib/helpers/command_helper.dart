import 'dart:io';

class CommandResult {
  final String error;
  final String output;
  final bool success;

  const CommandResult(this.success, this.output, this.error);
}

abstract class CommandHelper {
  static Future<CommandResult> run(String cmd,
      {Map<String, String>? env, bool asRoot = false}) async {
    return await runWithArguments(cmd, [], env: env, asRoot: asRoot);
  }

  static Future<CommandResult> runWithArguments(String cmd, List<String> args,
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
      String out = procResult.stdout.toString().trim();
      String err = procResult.stderr.toString().trim();
      return CommandResult(procResult.exitCode == 0, out, err);
    } on ProcessException catch (e) {
      return CommandResult(false, "", e.message);
    }
  }
}
