import 'parser.dart';
import '../tokens.dart';

void moveAheadByCheck(TokenType type) {
  if (tokens[currentToken].type == type) {
    currentToken++;
  } else {
    throw Exception("Expected ${type} but got ${tokens[currentToken].type}");
  }
}

void printK(String v) {
  // print(v);
}

List<Token> tokens = [
  Token("var", TokenType.VAR),
  Token("first", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("1", TokenType.INTEGER_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("function", TokenType.FUNCTION), 
  Token("addOne", TokenType.IDENTIFIER), 
  Token("(", TokenType.OPEN_PAREN),
  Token("num", TokenType.IDENTIFIER), 
  Token(")", TokenType.CLOSE_PAREN),
  Token("{", TokenType.OPEN_BRACE),
  Token("return", TokenType.RETURN),
  Token("num", TokenType.IDENTIFIER), 
  Token("+", TokenType.ADD_OP),
  Token("1", TokenType.INTEGER_LITERAL),
  Token("}", TokenType.CLOSE_BRACE),
  Token("var", TokenType.VAR),
  Token("result", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("addOne", TokenType.IDENTIFIER), 
  Token("(", TokenType.OPEN_PAREN),
  Token("first", TokenType.IDENTIFIER), 
  Token(")", TokenType.CLOSE_PAREN),
  Token(";", TokenType.SEMICOLON),
  Token("print", TokenType.PRINT),
  Token("result", TokenType.IDENTIFIER),
];
