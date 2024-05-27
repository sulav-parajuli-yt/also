
enum TokenType {
  INTEGER_LITERAL,
  STRING_LITERAL,
  FLOAT_LITERAL,
  
  SEMICOLON,
  OPEN_PAREN,
  CLOSE_PAREN,

  VAR,
  IDENTIFIER,
  ASSIGN_OP,


  // operators
  ADD_OP,
  MINUS_OP,
  MUL_OP,
  DIV_OP,
  EOF
}

class Token {
  String lexeme;
  TokenType type;

  Token(this.lexeme, this.type);

  @override
  String toString() {
    return this.lexeme;
  }
}
