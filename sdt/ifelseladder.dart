import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import 'statement_list.dart';
import '../tokens.dart';

void IfStmt() {
  // IfStmt -> if (E) { StatementList } ElseIfStmt
  moveAheadByCheck(TokenType.IF);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  var result = E();
  // print(result);
  moveAheadByCheck(TokenType.CLOSE_PAREN);
  moveAheadByCheck(TokenType.OPEN_BRACE);
  if (result) {
    StatementList();
    moveAheadByCheck(TokenType.CLOSE_BRACE);
    // If the if statement block executes, skip over any else-if or else blocks
    while (currentToken < tokens.length &&
        (tokens[currentToken].type == TokenType.ELSEIF ||
            tokens[currentToken].type == TokenType.ELSE)) {
      skipBlock();
    }
  } else {
    int countOfOpenBraces = 0;
    while (tokens[currentToken].type != TokenType.CLOSE_BRACE ||
        countOfOpenBraces != 0) {
      if (tokens[currentToken].type == TokenType.OPEN_BRACE) {
        countOfOpenBraces += 1;
        currentToken++;
      } else if (tokens[currentToken].type == TokenType.CLOSE_BRACE &&
          countOfOpenBraces != 0) {
        countOfOpenBraces -= 1;
        currentToken++;
      } else {
        currentToken++;
      }
    }
    moveAheadByCheck(TokenType.CLOSE_BRACE);
    // print(tokens[currentToken]);
    ElseIfStmt();
  }
}

void ElseIfStmt() {
  // ElseIfStmt -> elseif (E) { StatementList } ElseIfStmt | ElseStmt | ε
  if (currentToken < tokens.length &&
      tokens[currentToken].type == TokenType.ELSEIF) {
    moveAheadByCheck(TokenType.ELSEIF);
    moveAheadByCheck(TokenType.OPEN_PAREN);
    var result = E();
    moveAheadByCheck(TokenType.CLOSE_PAREN);
    moveAheadByCheck(TokenType.OPEN_BRACE);
    if (result) {
      StatementList();
      moveAheadByCheck(TokenType.CLOSE_BRACE);
      // If the elseif statement block executes, skip over any remaining elseif or else blocks
      while (currentToken < tokens.length &&
          (tokens[currentToken].type == TokenType.ELSEIF ||
              tokens[currentToken].type == TokenType.ELSE)) {
        skipBlock();
      }
    } else {
      int countOfOpenBraces = 0;
      while (tokens[currentToken].type != TokenType.CLOSE_BRACE ||
          countOfOpenBraces != 0) {
        if (tokens[currentToken].type == TokenType.OPEN_BRACE) {
          countOfOpenBraces += 1;
          currentToken++;
        } else if (tokens[currentToken].type == TokenType.CLOSE_BRACE &&
            countOfOpenBraces != 0) {
          countOfOpenBraces -= 1;
          currentToken++;
        } else {
          currentToken++;
        }
      }

      moveAheadByCheck(TokenType.CLOSE_BRACE);
      ElseIfStmt();
    }
  } else {
    ElseStmt();
  }
}

void ElseStmt() {
  // ElseStmt -> else { StatementList } | ε
  if (currentToken < tokens.length &&
      tokens[currentToken].type == TokenType.ELSE) {
    moveAheadByCheck(TokenType.ELSE);
    moveAheadByCheck(TokenType.OPEN_BRACE);
    StatementList();
    moveAheadByCheck(TokenType.CLOSE_BRACE);
  }
}

void skipBlock() {
  // Helper function to skip over blocks of code
  if (tokens[currentToken].type == TokenType.ELSEIF ||
      tokens[currentToken].type == TokenType.ELSE) {
    currentToken++;
    if (tokens[currentToken].type == TokenType.OPEN_PAREN) {
      // Skip over the condition part for elseif
      currentToken++;
      while (tokens[currentToken].type != TokenType.CLOSE_PAREN) {
        currentToken++;
      }
      currentToken++; // Skip the closing parenthesis
    }
    moveAheadByCheck(TokenType.OPEN_BRACE);
    while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
      currentToken++;
    }
    currentToken++; // Skip the closing brace
  }
}
