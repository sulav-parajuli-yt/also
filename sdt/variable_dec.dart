import 'additionals.dart';
import 'array.dart';
import 'expression.dart';
import 'parser.dart';
import '../tokens.dart';

void V() {
  moveAheadByCheck(TokenType.VAR);
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);

  List<int> dimensions = parseArrayDims();
  moveAheadByCheck(TokenType.ASSIGN_OP);

  // checking empty array
  if (tokens[currentToken].type == TokenType.EMPTY_ARRAY) {
    moveAheadByCheck(TokenType.EMPTY_ARRAY);
    // moveAheadByCheck(TokenType.SEMICOLON);
    if (dimensions.isNotEmpty) {
      symbolTable["main"]![id] = createArray(dimensions, null);
    } else {
      throw Exception("Got empty array but wrong!");
    }
  } else {
    dynamic value = E();
    // moveAheadByCheck(TokenType.SEMICOLON);

    if (dimensions.isNotEmpty) {
      symbolTable["main"]![id] = createArray(dimensions, value);
    } else {
      symbolTable["main"]![id] = value;
      printK("Declared variable $id with value $value");
    }
  }
}
