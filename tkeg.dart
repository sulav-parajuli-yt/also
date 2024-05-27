import 'tokens.dart';

List<Token> tokens = [
  Token("var", TokenType.VAR),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("10", TokenType.STRING_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("(", TokenType.OPEN_PAREN),
  Token("5", TokenType.INTEGER_LITERAL),
  Token("*", TokenType.MUL_OP),
  Token("5", TokenType.INTEGER_LITERAL),
  Token("+", TokenType.ADD_OP),
  Token("x", TokenType.IDENTIFIER),
  Token(")", TokenType.CLOSE_PAREN),
  Token("+", TokenType.MUL_OP),
  Token("8", TokenType.INTEGER_LITERAL),
  Token(";", TokenType.SEMICOLON),
];