// A Basic Expression only parser, Really?
import 'statement_list.dart';

Map<String, Map<String, dynamic>> symbolTable = {"main": {}};
Map<String, List<String>> constantTable = {"main": []};
String currentScope = "main";
List<dynamic> functionReturnStack = [];

int currentToken = 0;
// to keep track of returns; if one return encountered ignore rest of statements
int returnCount = 0;

void compile() {
  currentToken = 0;
  StatementList();
}
