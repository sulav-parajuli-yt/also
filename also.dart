import 'dart:convert';
import 'dart:io';

import 'lexer/lexer.dart';
import 'sdt/additionals.dart';
import 'sdt/parser.dart';
import 'tokens.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Usage: dart <script.dart> <file_path>');
    return;
  }

  // Read the file contents
  File file = File(arguments[0]);

  if (!file.existsSync()) {
    print('File not found: ${arguments[0]}');
    return;
  }

  String sourceCode = file.readAsStringSync(encoding: utf8);

  // Create a lexer instance
  Lexer lexer = Lexer(sourceCode.toString() + " ");

  // Tokenize the source code
  List<Token> token = lexer.scanTokens();
  tokens = token;
  compile();
}
