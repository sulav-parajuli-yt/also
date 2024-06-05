import 'additionals.dart';
import '../shared/tokens.dart';
import 'expression.dart';

void PrintStmt() {
  moveAheadByCheck(TokenType.PRINT); // Consume 'print'
  dynamic value = E(); // Parse expression to print
  // if (value is List) {
  //   // If value is an array, print each element
  //   for (dynamic element in value) {
  //     print(element);
  //   }
  // } else {
    // Regular print statement
    print(value);
  // }
  // moveAheadByCheck(TokenType.SEMICOLON); // Ensure statement ends with ';'
}
