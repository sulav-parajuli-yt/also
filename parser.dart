// A Basic Expression only parser
import 'tokens.dart';

Map<String, Map<String, dynamic>> symbolTable = {"main": {}};
String currentScope = "main";

int currentToken = 0;

List<Token> tokens = [
  Token("var", TokenType.VAR),
  Token("first", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("10", TokenType.STRING_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("var", TokenType.VAR),
  Token("val", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("true", TokenType.BOOL_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("while", TokenType.WHILE),
  Token("(", TokenType.OPEN_PAREN),
  Token("val", TokenType.IDENTIFIER),
  Token(")", TokenType.CLOSE_PAREN),
  Token("{", TokenType.OPEN_BRACE),
  Token("first", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("1", TokenType.INTEGER_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("print", TokenType.PRINT),
  Token("first", TokenType.IDENTIFIER),
  Token("}", TokenType.CLOSE_BRACE),
];

/*
S -> StatementList
StatementList -> Stmt StmtList | ε
Stmt -> V | A | E | IfStmt | WhileStmt | PrintStmt
PrintStmt -> print E
V -> var id = E;
A -> id = E;
IfStmt -> if (E) { StatementList } ElseIfStmt
ElseIfStmt -> elseif (E) { StatementList } ElseIfStmt | ε
Else ->  else { StatementList } | ε
WhileStmt -> while (E) { StatementList }
E -> value R | (E) R | id R 
R -> + E R | - E R | * E R | and E R | or E R | ε
*/

void moveAheadByCheck(TokenType type) {
  if (tokens[currentToken].type == type) {
    currentToken++;
  } else {
    throw Exception("Expected ${type} but got ${tokens[currentToken].type}");
  }
}

void StatementList() {
  while (currentToken < tokens.length &&
      tokens[currentToken].type != TokenType.CLOSE_BRACE) {
    Stmt();
  }
}

void Stmt() {
  if (tokens[currentToken].type == TokenType.VAR) {
    V();
  } else if (tokens[currentToken].type == TokenType.IF) {
    IfStmt();
  } else if (tokens[currentToken].type == TokenType.WHILE) {
    WhileStmt();
  } else if (tokens[currentToken].type == TokenType.PRINT) {
    PrintStmt();
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER &&
      tokens[currentToken + 1].type == TokenType.ASSIGN_OP) {
    A();
  } else {
    dynamic result = E();
    printK("Expression result: $result");
  }
}

void PrintStmt() {
  moveAheadByCheck(TokenType.PRINT);
  var result = E();
  print(result);
}

void IfStmt() {
  // IfStmt -> if (E) { StatementList } ElseIfStmt
  moveAheadByCheck(TokenType.IF);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  var result = E();
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
    while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
      currentToken++;
    }
    moveAheadByCheck(TokenType.CLOSE_BRACE);
    ElseIfStmt();
  }
}

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
      while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
        currentToken++;
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

void V() {
  moveAheadByCheck(TokenType.VAR);
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  symbolTable["main"]![id] = value;
  printK("Declared variable $id with value $value");
}

void A() {
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  if (symbolTable["main"]!.containsKey(id)) {
    symbolTable["main"]![id] = value;
    printK("Assigned variable $id with value $value");
  } else {
    throw Exception("Variable $id not declared");
  }
}

dynamic E() {
  dynamic value;
  TokenType tt = tokens[currentToken].type;
  if (tt == TokenType.INTEGER_LITERAL ||
      tt == TokenType.FLOAT_LITERAL ||
      tt == TokenType.STRING_LITERAL ||
      tt == TokenType.BOOL_LITERAL) {
    // Handle integer literal
    switch (tt) {
      case TokenType.INTEGER_LITERAL:
        value = int.parse(tokens[currentToken].lexeme);
        break;
      case TokenType.FLOAT_LITERAL:
        value = double.parse(tokens[currentToken].lexeme);
        break;
      case TokenType.STRING_LITERAL:
        value = tokens[currentToken].lexeme;
        break;
      case TokenType.BOOL_LITERAL:
        value = bool.parse(tokens[currentToken].lexeme);
        break;
      default:
        value = tokens[currentToken].lexeme;
    }
    currentToken++;
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER) {
    // lookup
    value = symbolTable[currentScope]![tokens[currentToken].lexeme];
    currentToken++;
  } else if (tokens[currentToken].type == TokenType.OPEN_PAREN) {
    // Handle parenthesized expression
    currentToken++; // Skip '('
    value = E(); // Recursively parse the expression inside the parentheses
    moveAheadByCheck(TokenType.CLOSE_PAREN); // Ensure the closing ')'
  } else {
    throw Exception("Parsing Error: Unexpected token ${tokens[currentToken]}");
  }

  // Handle the rest of the expression
  return R(value);
}

dynamic R(dynamic inhValue) {
  // Empty check
  if (currentToken >= tokens.length) {
    return inhValue;
  }

  dynamic synValue = inhValue;

  // Handle operators
  if (tokens[currentToken].type == TokenType.ADD_OP) {
    currentToken++;
    dynamic value = E();
    synValue = inhValue + value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.MINUS_OP) {
    currentToken++;
    dynamic value = E();
    synValue = inhValue - value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.MUL_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue * value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.AND_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue && value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.OR_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue || value;
    return R(synValue);
  }

  return synValue; // Return the inherited value if no more operators
}

void parse() {
  currentToken = 0;
  StatementList();
}

void main() {
  parse();
}
