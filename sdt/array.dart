import '../shared/tokens.dart';
import 'additionals.dart';
import 'expression.dart';
import 'parser.dart';

dynamic createArray(List<int> dimensions, dynamic value) {
  if (dimensions.isEmpty) return value;
  int size = dimensions[0];
  List<dynamic> array;
  // print(size);
  if (value == null) {
    array = List.filled(size, 0);
  } else {
    array = List.filled(size, value);
    if (value.length > 1) {
      for (int i = 0; i < size; i++) {
        array[i] = createArray(dimensions.sublist(1), value[i]);
      }
    }
  }
  return array;
}

void setArrayValue(dynamic array, List<int> indices, dynamic value) {
  for (int i = 0; i < indices.length - 1; i++) {
    array = array[indices[i]];
  }
  array[indices.last] = value;
}

dynamic parseArrayLiteral() {
  moveAheadByCheck(TokenType.OPEN_BRACKET);
  List<dynamic> elements = [];
  if (tokens[currentToken].type != TokenType.CLOSE_BRACKET) {
    elements.add(E());
    while (tokens[currentToken].type == TokenType.COMMA) {
      currentToken++;
      elements.add(E());
    }
  }
  moveAheadByCheck(TokenType.CLOSE_BRACKET);
  return elements;
}

List<int> parseArrayDims() {
  List<int> dimensions = [];
  while (tokens[currentToken].type == TokenType.OPEN_BRACKET) {
    moveAheadByCheck(TokenType.OPEN_BRACKET);
    int size = int.parse(tokens[currentToken].lexeme);
    moveAheadByCheck(TokenType.INTEGER_LITERAL);
    moveAheadByCheck(TokenType.CLOSE_BRACKET);
    dimensions.add(size);
  }
  return dimensions;
}

// Function to update an element in an array
void updateArrayElement(String id, List<int> indices, dynamic newValue) {
  // Retrieve the array from the symbol table
  dynamic array = symbolTable[currentScope]![id];

  // Traverse the array using indices to reach the desired element
  for (int i = 0; i < indices.length - 1; i++) {
    array = array[indices[i]];
  }

  // Update the value of the element at the specified indices
  array[indices.last] = newValue;
}

// Function to get an element from an array
dynamic getArrayElement(dynamic array, List<int> indices) {
  // Traverse the array using indices to reach the desired element
  for (int index in indices) {
    array = array[index];
  }
  return array;
}
