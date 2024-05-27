import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import '../tokens.dart';

void A() {
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  if (symbolTable["main"]!.containsKey(id)) {
    symbolTable["main"]![id] = value;
    printK("Assigned variable $id with value $value");
  } else {
    throw Exception("Variable $id not declared");
  }
}