// A Basic Expression only parser
import 'tokens.dart';

Map<String, Map<String, dynamic>> symbolTable = {"main": {}};

int currentToken = 0;

List<Token> tokens = [
  Token("var", TokenType.VAR),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("10", TokenType.INTEGER_LITERAL),
  Token(";", TokenType.SEMICOLON),
  Token("x", TokenType.IDENTIFIER),
  Token("=", TokenType.ASSIGN_OP),
  Token("(", TokenType.OPEN_PAREN),
  Token("5", TokenType.INTEGER_LITERAL),
  Token("*", TokenType.MUL_OP),
  Token("5", TokenType.INTEGER_LITERAL),
  Token("+", TokenType.ADD_OP),
  Token("2", TokenType.INTEGER_LITERAL),
  Token(")", TokenType.CLOSE_PAREN),
  Token("+", TokenType.MUL_OP),
  Token("8", TokenType.INTEGER_LITERAL),
  Token(";", TokenType.SEMICOLON),
];

/*
S -> StatementList
StatementList -> Stmt StmtList | ε
Stmt -> V | A | E 
V -> var id = E;
A -> id = E;
E -> value R | (E) R | id R
R -> + E R | - E R | * E R | ε
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
      tokens[currentToken].type != TokenType.CLOSE_PAREN) {
    Stmt();
  }
}

void Stmt() {
  if (tokens[currentToken].type == TokenType.VAR) {
    V();
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER &&
      tokens[currentToken + 1].type == TokenType.ASSIGN_OP) {
    A();
  } else {
    int result = E();
    print("Expression result: $result");
  }
}

void V() {
  moveAheadByCheck(TokenType.VAR);
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  int value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  symbolTable["main"]![id] = value;
  print("Declared variable $id with value $value");
}

void A() {
  String id = tokens[currentToken].lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.ASSIGN_OP);
  int value = E();
  moveAheadByCheck(TokenType.SEMICOLON);
  if (symbolTable["main"]!.containsKey(id)) {
    symbolTable["main"]![id] = value;
    print("Assigned variable $id with value $value");
  } else {
    throw Exception("Variable $id not declared");
  }
}

int E() {
  int value;
  if (tokens[currentToken].type == TokenType.INTEGER_LITERAL) {
    // Handle integer literal
    value = int.parse(tokens[currentToken].lexeme);
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

int R(int inhValue) {
  // Empty check
  if (currentToken >= tokens.length) {
    return inhValue;
  }

  int synValue = inhValue;

  // Handle operators
  if (tokens[currentToken].type == TokenType.ADD_OP) {
    currentToken++;
    int value = E();
    synValue = inhValue + value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.MINUS_OP) {
    currentToken++;
    int value = E();
    synValue = inhValue - value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.MUL_OP) {
    currentToken++;
    int value = E();
    synValue = inhValue * value;
    return R(synValue);
  }

  return synValue; // Return the inherited value if no more operators
}

void parse() {
  StatementList();
}

void main() {
  parse();
}
