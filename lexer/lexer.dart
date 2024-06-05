import '../shared/tokens.dart';

class Lexer {
  final String _source;
  int _start = 0;
  int _current = 0;
  List<Token> _tokens = [];

  Lexer(this._source);

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      _start = _current;
      _scanToken();
    }

    // _tokens.add(Token('', TokenType.EOF));
    return _tokens;
  }

  void _scanToken() {
    var c = _advance();
    switch (c) {
      case '(':
        _addToken(TokenType.OPEN_PAREN);
        break;
      case ')':
        _addToken(TokenType.CLOSE_PAREN);
        break;
      case '!':
        c += _advance();
        _addToken(TokenType.NOT_EQUAL_OP);
        break;
      case '{':
        _addToken(TokenType.OPEN_BRACE);
        break;
      case '}':
        _addToken(TokenType.CLOSE_BRACE);
        break;
      case ',':
        _addToken(TokenType.COMMA);
        break;
      case '+':
        _addToken(TokenType.ADD_OP);
        break;
      case '-':
        _addToken(TokenType.MINUS_OP);
        break;
      case '*':
        _addToken(TokenType.MUL_OP);
        break;
      case '<':
        _addToken(_match('=') ? TokenType.SMLTHN_EQ_OP : TokenType.SMLTHN_OP);
        break;
      case '>':
        _addToken(_match('=') ? TokenType.GRTHN_EQ_OP : TokenType.GRTHN_OP);
        break;
      case '/':
        if (_match('/')) {
          _skipSingleLineComment();
        } else {
          _addToken(TokenType.DIV_OP);
        }
        break;
      case '=':
        _addToken(
            _match('=') ? TokenType.DOUBLE_EQUAL_OP : TokenType.ASSIGN_OP);
        break;
      case '#':
        _addToken(TokenType.EMPTY_ARRAY);
        break;
      case '[':
        _addToken(TokenType.OPEN_BRACKET);
        break;
      case ']':
        _addToken(TokenType.CLOSE_BRACKET);
        break;
      default:
        if (_isAlpha(c)) {
          _identifier();
        } else if (_isDigit(c)) {
          _number();
        } else if (c == '"') {
          _string();
        } else if (c == ' ' || c == '\r' || c == '\t' || c == '\n') {
          // Ignore whitespace.
        } else {
          throw Exception('Unexpected character: $c');
        }
    }
  }

  bool _isAlpha(String c) {
    return (c.compareTo('a') >= 0 && c.compareTo('z') <= 0) ||
        (c.compareTo('A') >= 0 && c.compareTo('Z') <= 0) ||
        c == '_';
  }

  bool _isAlphaNumeric(String c) {
    return _isAlpha(c) || _isDigit(c);
  }

  bool _isDigit(String c) {
    return c.compareTo('0') >= 0 && c.compareTo('9') <= 0;
  }

  String _advance() {
    return _source[_current++];
  }

  bool _match(String expected) {
    if (_isAtEnd()) return false;
    if (_source[_current] != expected) return false;

    _current++;
    return true;
  }

  bool _isAtEnd() {
    return _current >= _source.length;
  }

  String _peek() {
    if (_isAtEnd()) return '\0';
    return _source[_current];
  }

  String _peekNext() {
    if (_current + 1 >= _source.length) return '\0';
    return _source[_current + 1];
  }

  void _addToken(TokenType type, {String? text}) {
    if (text == null) {
      text = _source.substring(_start, _current);
    }
    _tokens.add(Token(text, type, _tokens.length + 1));
  }

  void _identifier() {
    while (_isAlphaNumeric(_peek())) _advance();

    var text = _source.substring(_start, _current);
    var type = _keywords[text] ?? TokenType.IDENTIFIER;
    _addToken(type);
  }

void _number() {
  while (_isDigit(_peek())) _advance();

  bool isFloat = false;

  if (_peek() == '.' && _isDigit(_peekNext())) {
    isFloat = true;
    _advance(); // Consume the '.'

    while (_isDigit(_peek())) _advance();
  }

  var text = _source.substring(_start, _current);
  if (isFloat) {
    _addToken(TokenType.FLOAT_LITERAL);
  } else {
    _addToken(TokenType.INTEGER_LITERAL);
  }
}


  void _string() {
    while (_peek() != '"' && !_isAtEnd()) {
      if (_peek() == '\n') {
        // Dart doesn't support multiline strings like this.
        throw Exception('Unterminated string.');
      }
      _advance();
    }

    if (_isAtEnd()) {
      throw Exception('Unterminated string.');
    }

    // Consume the closing ".
    _advance();

    // Trim the surrounding quotes.
    var value = _source.substring(_start + 1, _current - 1);
    _addToken(TokenType.STRING_LITERAL, text: value);
  }

  void _skipSingleLineComment() {
    while (_peek() != '\n' && !_isAtEnd()) {
      _advance();
    }
  }

  static final Map<String, TokenType> _keywords = {
    'var': TokenType.VAR,
    'if': TokenType.IF,
    'else': TokenType.ELSE,
    'elseif': TokenType.ELSEIF,
    'while': TokenType.WHILE,
    'print': TokenType.PRINT,
    'true': TokenType.BOOL_LITERAL,
    'false': TokenType.BOOL_LITERAL,
    'return': TokenType.RETURN,
    'function': TokenType.FUNCTION,
  };
}
