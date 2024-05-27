import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';
import 'statement_list.dart';
import '../tokens.dart';

class FunctionDefinition {
  final List<String> parameters;
  final List<Token> functionBodyTokens;

  FunctionDefinition(this.parameters, this.functionBodyTokens);

  @override
  String toString() {
    return functionBodyTokens.toString();
  }
}

void FuncDef() {
  moveAheadByCheck(TokenType.FUNCTION);
  Token idToken = tokens[currentToken];
  String functionName = idToken.lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  // Parse parameters
  List<String> parameters = [];
  while (tokens[currentToken].type != TokenType.CLOSE_PAREN) {
    parameters.add(tokens[currentToken].lexeme);
    moveAheadByCheck(TokenType.IDENTIFIER);
    if (tokens[currentToken].type == TokenType.COMMA) {
      moveAheadByCheck(TokenType.COMMA);
    }
  }
  moveAheadByCheck(TokenType.CLOSE_PAREN);
  moveAheadByCheck(TokenType.OPEN_BRACE);
  // Parse function body
  List<Token> functionBodyTokens = [];
  while (tokens[currentToken].type != TokenType.CLOSE_BRACE) {
    functionBodyTokens.add(tokens[currentToken]);
    currentToken++;
  }
  moveAheadByCheck(TokenType.CLOSE_BRACE);
  // Store function definition in symbol table
  symbolTable[currentScope]![functionName] =
      FunctionDefinition(parameters, functionBodyTokens);
}

dynamic FuncCall() {
  Token idToken = tokens[currentToken];
  String functionName = idToken.lexeme;
  moveAheadByCheck(TokenType.IDENTIFIER);
  moveAheadByCheck(TokenType.OPEN_PAREN);
  // Parse arguments
  List<dynamic> arguments = [];
  while (tokens[currentToken].type != TokenType.CLOSE_PAREN) {
    arguments.add(E());
    if (tokens[currentToken].type == TokenType.COMMA) {
      moveAheadByCheck(TokenType.COMMA);
    }
  }
  moveAheadByCheck(TokenType.CLOSE_PAREN);
  // Execute function
  return executeFunction(functionName, arguments);
}

dynamic executeFunction(String functionName, List<dynamic> arguments) {
  // Retrieve function definition from symbol table
  FunctionDefinition? funcDef = symbolTable[currentScope]![functionName];
  if (funcDef == null) {
    throw Exception("Function $functionName not defined");
  }
  // Create a new symbol table for the function's scope
  Map<String, dynamic> functionScope = {};
  for (int i = 0; i < funcDef.parameters.length; i++) {
    functionScope[funcDef.parameters[i]] = arguments[i];
  }
  // Execute function body with the new scope
  Map<String, dynamic> previousScope = symbolTable[currentScope]!;

  symbolTable[currentScope] = functionScope;

  // currentScope = functionName; // Update current scope to function's scope
  executeStatements(funcDef.functionBodyTokens);
  // currentScope = "main"; // Restore current scope
  symbolTable[currentScope] = previousScope; // Restore previous symbol table
  return functionReturnStack.removeAt(0);
}

void executeStatements(List<Token> tokens2) {
  int savedTokenIndex = currentToken;
  currentToken = 0;
  List<Token> tokensTemp = tokens;
  tokens = tokens2;
  StatementList();
  currentToken = savedTokenIndex;
  tokens = tokensTemp;
}