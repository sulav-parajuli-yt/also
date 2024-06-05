import 'dart:convert';
import 'dart:io';

String macro(String filename) {
  File file = File(filename);

  if (!file.existsSync()) {
    print('File not found: $filename');
    return '';
  }

  String sourceCode = file.readAsStringSync(encoding: utf8);
  return _processIncludes(sourceCode, file.parent.path);
}

String _processIncludes(String sourceCode, String directory) {
  final includePattern = RegExp(r'\$include\s+"([^"]+)"');
  StringBuffer processedCode = StringBuffer();

  int lastMatchEnd = 0;
  for (var match in includePattern.allMatches(sourceCode)) {
    // Append the code before the include statement
    processedCode.write(sourceCode.substring(lastMatchEnd, match.start));

    // Get the included file path
    String includedFilePath = match.group(1)!;

    // Construct the full path to the included file
    String fullIncludedFilePath = '$directory/$includedFilePath';

    // Recursively process the included file
    processedCode.write(macro(fullIncludedFilePath));

    // Update the position of the last match end
    lastMatchEnd = match.end;
  }

  // Append any remaining code after the last include statement
  processedCode.write(sourceCode.substring(lastMatchEnd));

  return processedCode.toString();
}

