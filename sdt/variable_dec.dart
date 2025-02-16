import 'additionals.dart';
import 'array.dart';
import 'expression.dart';
import 'parser.dart';
import '../shared/tokens.dart';

void V() {
  bool constant = false;
  // may be either a variable or a constant
  if (tokens[currentToken].type == TokenType.VAR) {
    moveAheadByCheck(TokenType.VAR);
  } else {
    moveAheadByCheck(TokenType.CONSTANT);
    constant = true;
  }
  String id = tokens[currentToken].lexeme;
  if (constant) constantTable["main"]!.add(id);
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
