import 'additionals.dart';
import 'array.dart';
import 'expression.dart';
import 'parser.dart';
import '../tokens.dart';

void A() {
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);

  List<int> indices = parseArrayAccess();
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  // moveAheadByCheck(TokenType.SEMICOLON);

  if (symbolTable["main"]!.containsKey(id)) {
    if (indices.isNotEmpty) {
      setArrayValue(symbolTable["main"]![id], indices, value);
      printK("Assigned array $id at indices $indices with value $value");
    } else {
      symbolTable["main"]![id] = value;
      printK("Assigned variable $id with value $value");
    }
  } else {
    throw Exception("Variable $id not declared");
  }
}

List<int> parseArrayAccess() {
  List<int> indices = [];
  while (tokens[currentToken].type == TokenType.OPEN_BRACKET) {
    moveAheadByCheck(TokenType.OPEN_BRACKET);
    indices.add(E());
    moveAheadByCheck(TokenType.CLOSE_BRACKET);
  }
  return indices;
}
