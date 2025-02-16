enum TokenType {
  // libs keyword
  PRINT, INTEGER_LITERAL, STRING_LITERAL,
  FLOAT_LITERAL, BOOL_LITERAL, OPEN_PAREN,
  CLOSE_PAREN, OPEN_BRACE, CLOSE_BRACE,
  EMPTY_ARRAY, VAR, IDENTIFIER, ASSIGN_OP,
  IF, WHILE, ELSE, ELSEIF, OPEN_BRACKET, CLOSE_BRACKET,

  // operators
  ADD_OP, MINUS_OP, MUL_OP, DIV_OP,
  AND_OP, OR_OP, DOUBLE_EQUAL_OP, NOT_EQUAL_OP,
  GRTHN_OP, GRTHN_EQ_OP, SMLTHN_OP, SMLTHN_EQ_OP,
  MOD_OP, COMMA, RETURN, FUNCTION, CONSTANT,
}

class Token {
  String lexeme;
  TokenType type;
  int lineNo;

  Token(this.lexeme, this.type, this.lineNo);

  @override
  String toString() {
    return "( " + this.lexeme + " - " + this.type.name + " )" + "at line ${this.lineNo}";
  }
}
