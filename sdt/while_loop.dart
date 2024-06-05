import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import 'statement_list.dart';
import '../shared/tokens.dart';

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
    int noOfOpenedBrace = 0;
    while (noOfOpenedBrace != 0 ||
        tokens[currentToken].type != TokenType.CLOSE_BRACE) {
      if (tokens[currentToken].type == TokenType.OPEN_BRACE) {
        noOfOpenedBrace += 1;
      }
      if (tokens[currentToken].type == TokenType.CLOSE_BRACE) {
        noOfOpenedBrace -= 1;
      }
      currentToken++;
    }
    moveAheadByCheck(TokenType.CLOSE_BRACE);
  }
}
