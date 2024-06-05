import 'additionals.dart';
import 'expression.dart';
import 'fn_defn.dart';
import 'parser.dart';
import '../tokens.dart';


void ReturnStmt() {
  moveAheadByCheck(TokenType.RETURN);
  var result = E();
  functionReturnStack.insert(0, result);
  returnCount += 1;
  // print(result);
}
