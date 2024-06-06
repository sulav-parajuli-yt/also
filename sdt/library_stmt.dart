import 'additionals.dart';
import '../shared/tokens.dart';
import 'expression.dart';

void PrintStmt() {
  moveAheadByCheck(TokenType.PRINT);
  dynamic value = E();
  print(value);
}
