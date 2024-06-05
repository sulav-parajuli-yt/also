import 'additionals.dart';
import 'array.dart';
import 'fn_defn.dart';
import 'parser.dart';
import '../shared/tokens.dart';

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
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER &&
      currentToken + 1 < tokens.length &&
      tokens[currentToken + 1].type == TokenType.OPEN_PAREN) {
    // fn call
    return FuncCall();
  } else if (tokens[currentToken].type == TokenType.IDENTIFIER) {
    String id = tokens[currentToken].lexeme;
    currentToken++;
    if (tokens.length > currentToken &&
        tokens[currentToken].type == TokenType.OPEN_BRACKET) {
      // Array access
      currentToken++; // Move past '['
      List<int> indices = [];
      indices.add(E()); // Parse index
      moveAheadByCheck(TokenType.CLOSE_BRACKET); // Ensure closing ']'
      if (tokens.length > currentToken &&
          tokens[currentToken].type == TokenType.ASSIGN_OP) {
        // Array update
        currentToken++; // Move past '='
        dynamic newValue = E(); // Parse new value
        // Update array element
        updateArrayElement(id, indices, newValue);
        return newValue;
      } else {
        // Array element access
        dynamic arrayValue = symbolTable[currentScope]![id];
        return getArrayElement(arrayValue, indices);
      }
    } else {
      // Regular variable lookup
      value = symbolTable[currentScope]![id];
    }
  } else if (tokens[currentToken].type == TokenType.OPEN_PAREN) {
    // Handle parenthesized expression
    currentToken++; // Skip '('
    value = E(); // Recursively parse the expression inside the parentheses
    moveAheadByCheck(TokenType.CLOSE_PAREN); // Ensure the closing ')'
  } else if (tokens[currentToken].type == TokenType.OPEN_BRACKET) {
    // Array literal
    return parseArrayLiteral();
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
  } else if (tokens[currentToken].type == TokenType.DOUBLE_EQUAL_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue == value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.NOT_EQUAL_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue != value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.GRTHN_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue > value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.GRTHN_EQ_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue >= value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.SMLTHN_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue < value;
    return R(synValue);
  } else if (tokens[currentToken].type == TokenType.SMLTHN_EQ_OP) {
    currentToken++;
    dynamic value = E();
    // if(value is int || value is double)
    synValue = inhValue <= value;
    return R(synValue);
  }

  return synValue; // Return the inherited value if no more operators
}
