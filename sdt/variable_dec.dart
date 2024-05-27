import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import '../tokens.dart';

void V() {
  moveAheadByCheck(TokenType.VAR);
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  symbolTable["main"]![id] = value;
  printK("Declared variable $id with value $value");
}