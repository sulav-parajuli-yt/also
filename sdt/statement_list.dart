import 'additionals.dart';
import 'parser.dart';
import 'statement.dart';
import '../tokens.dart';

void StatementList() {
  while (currentToken < tokens.length &&
      tokens[currentToken].type != TokenType.CLOSE_BRACE) {
    printK("Statement: ${tokens[currentToken]}");
    Stmt();
  }
}
