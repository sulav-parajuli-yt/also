import 'parser.dart';
import '../tokens.dart';

void moveAheadByCheck(TokenType type) {
  if (tokens[currentToken].type == type) {
    currentToken++;
  } else {
    throw Exception("Expected ${type} but got ${tokens[currentToken].type} on line ${tokens[currentToken].lineNo}");
  }
}

void printK(dynamic v) {
  // print(v);
}

List<Token> tokens = [];
