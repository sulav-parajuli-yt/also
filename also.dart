import 'lexer/lexer.dart';
import 'macro.dart';
import 'sdt/additionals.dart';
import 'sdt/parser.dart';
import 'shared/tokens.dart';


extension FormattedMessage on Exception {
  String get getMessage {
    if (toString().startsWith("Exception: ")) {
      return toString().substring(11);
    }else {
      return toString();
    }
  }
}

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Usage: also <file_path>');
    return;
  }

  String sourceCode = macro(arguments[0]);

  // Create a lexer instance
  Lexer lexer = Lexer(sourceCode.toString() + " ");

  // Tokenize the source code
  List<Token> token = lexer.scanTokens();
  tokens = token;
  try {
    compile();
  } on Exception catch (e) {
    print("ERROR: " + e.getMessage);
  }
}
