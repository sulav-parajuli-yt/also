// A Basic Expression only parser
import 'tokens.dart';

Map<String, Map<String, dynamic>> symbolTable = {"main": {}};
String currentScope = "main";

int currentToken = 0;

List<Token> tokens = [
  Token("var", TokenType.VAR),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("10", TokenType.STRING_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("(", TokenType.OPEN_PAREN),
  Token("Sulav", TokenType.STRING_LITERAL),
  Token("+", TokenType.ADD_OP),
  Token(" Parajuli", TokenType.STRING_LITERAL),
  Token(")", TokenType.CLOSE_PAREN),
  Token(";", TokenType.SEMICOLON),
  Token("var", TokenType.VAR),
  Token("y", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("false", TokenType.BOOL_LITERAL),
  Token("or", TokenType.OR_OP),
  Token("false", TokenType.BOOL_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("if", TokenType.IF),
  Token("(", TokenType.OPEN_PAREN),
  Token("y", TokenType.IDENTIFIER),
  Token(")", TokenType.CLOSE_PAREN),
  Token("{", TokenType.OPEN_BRACE),
  Token("var", TokenType.VAR),
  Token("m", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("10", TokenType.STRING_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("}", TokenType.CLOSE_BRACE),
];

/*
S -> StatementList
StatementList -> Stmt StmtList | ε
Stmt -> V | A | E | IfStmt
V -> var id = E;
A -> id = E;
IfStmt -> if (E) { StatementList }
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
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER &&
      tokens[currentToken + 1].type == TokenType.ASSIGN_OP) {
    A();
  } else {
    dynamic result = E();
    print("Expression result: $result");
  }
}

void IfStmt() {
  // IfStmt -> if (E) { StatementList }
  moveAheadByCheck(TokenType.IF);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  var result = E();
  moveAheadByCheck(TokenType.CLOSE_PAREN);
  moveAheadByCheck(TokenType.OPEN_BRACE);
  // how to parse statement list
  if (result) {
    StatementList();
  } else {
    // If the condition is false, skip the statements inside the if block
    while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
      currentToken++;
    }
  }
  moveAheadByCheck(TokenType.CLOSE_BRACE);
}

void V() {
  moveAheadByCheck(TokenType.VAR);
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  symbolTable["main"]![id] = value;
  print("Declared variable $id with value $value");
}

void A() {
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  dynamic value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  if (symbolTable["main"]!.containsKey(id)) {
    symbolTable["main"]![id] = value;
    print("Assigned variable $id with value $value");
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
