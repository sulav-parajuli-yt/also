enum TokenType {
  // libs keyword
  PRINT,

  INTEGER_LITERAL,
  STRING_LITERAL,
  FLOAT_LITERAL,
  BOOL_LITERAL,

  SEMICOLON,
  OPEN_PAREN,
  CLOSE_PAREN,
  OPEN_BRACE,
  CLOSE_BRACE,

  EMPTY_ARRAY,

  VAR,
  IDENTIFIER,
  ASSIGN_OP,
  IF,
  WHILE,
  ELSE,
  ELSEIF,
  OPEN_BRACKET,
  CLOSE_BRACKET,

  // operators
  ADD_OP,
  MINUS_OP,
  MUL_OP,
  DIV_OP,
  AND_OP,
  OR_OP,
  DOUBLE_EQUAL_OP,
  NOT_EQUAL_OP,

  COMMA,
  RETURN,

  FUNCTION,
}

class Token {
  String lexeme;
  TokenType type;
  int lineNo;

  Token(this.lexeme, this.type, this.lineNo);

  @override
  String toString() {
    return "( " + this.lexeme + " - " + this.type.name + " )";
  }
}
