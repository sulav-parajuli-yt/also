import 'tokens.dart';

var m = 2;
List tokenss = [
  Token("var", TokenType.VAR, m),
  Token("arr", TokenType.IDENTIFIER, m++),
  Token("[", TokenType.OPEN_BRACKET, m++),
  Token("1", TokenType.INTEGER_LITERAL, m++),
  Token("]", TokenType.CLOSE_BRACKET, m++),
  Token("=", TokenType.ASSIGN_OP, m++),
  Token("[", TokenType.OPEN_BRACKET, m++),
  Token("1", TokenType.INTEGER_LITERAL, m++),
  Token(",", TokenType.COMMA, m++),
  Token("2", TokenType.INTEGER_LITERAL, m++),
  Token(",", TokenType.COMMA, m++),
  Token("3", TokenType.INTEGER_LITERAL, m++),
  Token("]", TokenType.CLOSE_BRACKET, m++),
  Token(";", TokenType.SEMICOLON, m++),

  //  Token("print", TokenType.PRINT, m++),
  // Token("arr", TokenType.IDENTIFIER, m++),
  // Token("arr", TokenType.IDENTIFIER, m++),
  Token("arr", TokenType.IDENTIFIER, m++),
  Token("[", TokenType.OPEN_BRACKET, m++),
  Token("1", TokenType.INTEGER_LITERAL, m++),
  Token("]", TokenType.CLOSE_BRACKET, m++),
  Token("=", TokenType.ASSIGN_OP, m++),
  
  Token("4", TokenType.INTEGER_LITERAL, m++),
  Token(";", TokenType.SEMICOLON, m++),
  Token("print", TokenType.PRINT, m++),
  Token("arr", TokenType.IDENTIFIER, m++),
  Token("[", TokenType.OPEN_BRACKET, m++),
  Token("0", TokenType.INTEGER_LITERAL, m++),
  Token("]", TokenType.CLOSE_BRACKET, m++),
];
