import 'additionals.dart';
import '../tokens.dart';
import 'expression.dart';
import 'parser.dart';

void PrintStmt() {
  printK("Statement: ${tokens[currentToken]}");

  moveAheadByCheck(TokenType.PRINT);
  var result = E();
  print(result);
}
