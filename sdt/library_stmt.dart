import 'additionals.dart';
import '../shared/tokens.dart';
import 'expression.dart';

void LibraryFuncStmt() {
  moveAheadByCheck(TokenType.PRINT);
  dynamic value = E();
  print(value);
}
