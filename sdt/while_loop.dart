import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import 'statement_list.dart';
import '../tokens.dart';

void WhileStmt() {
  // WhileStmt -> while (E) { StatementList }
  var pos = currentToken;
  moveAheadByCheck(TokenType.WHILE);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  var result = E();
  moveAheadByCheck(TokenType.CLOSE_PAREN);
  moveAheadByCheck(TokenType.OPEN_BRACE);
  if (result) {
    StatementList();
    moveAheadByCheck(TokenType.CLOSE_BRACE);
    currentToken = pos;
  } else {
    while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
      currentToken++;
    }
    moveAheadByCheck(TokenType.CLOSE_BRACE);
  }
}
