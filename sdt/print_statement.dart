import 'additionals.dart';
import '../tokens.dart';
import 'expression.dart';


void PrintStmt() {
  moveAheadByCheck(TokenType.PRINT);
  var result = E();
  print(result);
}
