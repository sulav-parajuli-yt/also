import 'additionals.dart';
import 'fn_defn.dart';
import 'parser.dart';
import 'statement.dart';
import '../shared/tokens.dart';

void StatementList() {
  while (currentToken < tokens.length &&
      tokens[currentToken].type != TokenType.CLOSE_BRACE) {
    printK("Statement: ${tokens[currentToken]}");
    if (returnCount >= 1) {
      currentToken = tokens.length;
      return;
    } else {
      Stmt();
    }
  }
}
