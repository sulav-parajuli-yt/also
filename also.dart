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
  // print(token);
  // print("\n\n");
  tokens = [
    Token("function", TokenType.FUNCTION),
    Token("fact", TokenType.IDENTIFIER),
    Token("(", TokenType.OPEN_PAREN),
    Token("n", TokenType.IDENTIFIER),
    Token(")", TokenType.CLOSE_PAREN),
    Token("{", TokenType.OPEN_BRACE),
    Token("if", TokenType.IF),
    Token("(", TokenType.OPEN_PAREN),
    Token("true", TokenType.BOOL_LITERAL),
    Token(")", TokenType.CLOSE_PAREN),
    Token("{", TokenType.OPEN_BRACE),
    Token("print", TokenType.PRINT),
    Token("1", TokenType.INTEGER_LITERAL),
    Token("}", TokenType.CLOSE_BRACE),
    Token("print", TokenType.PRINT),
    Token("sulav", TokenType.STRING_LITERAL),
    Token("print", TokenType.PRINT),
    Token("sulav", TokenType.STRING_LITERAL),
    Token("print", TokenType.PRINT),
    Token("sulav", TokenType.STRING_LITERAL),
    Token("return", TokenType.RETURN),
    Token("2", TokenType.INTEGER_LITERAL),
    Token("}", TokenType.CLOSE_BRACE),
    Token("var", TokenType.VAR),
    Token("m", TokenType.IDENTIFIER),
    Token("=", TokenType.ASSIGN_OP),
    Token("fact", TokenType.IDENTIFIER),
    Token("(", TokenType.OPEN_PAREN),
    Token("5", TokenType.INTEGER_LITERAL),
    Token(")", TokenType.CLOSE_PAREN),
    Token(";", TokenType.SEMICOLON),
    Token("print", TokenType.PRINT),
    Token("m", TokenType.IDENTIFIER),
  ];

  // print(tokens);

  compile();
}
