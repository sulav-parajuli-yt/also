# ALSO
ALSO is a language that supports following:
1. Functions [X]
2. Variables [X]
3. If..elseif...else ladder [X]
4. while loop [X]
5. Arrays [X]
6. Built In Statements [ print ] [X]
7. Comments [Implement on lexer] [X]
8. File IO

## Current Language Grammar
```
S -> StatementList
StatementList -> Stmt StmtList | ε
Stmt -> V | A | E | IfStmt | WhileStmt | PrintStmt | ReturnStmt | FuncDef 
PrintStmt -> print E
ReturnStmt -> return E
V -> var id = E | var id ArrayDims = E
A -> id = E | id ArrayAccess = E
IfStmt -> if (E) { StatementList } ElseIfStmt
ElseIfStmt -> elseif (E) { StatementList } ElseIfStmt | ε
Else ->  else { StatementList } | ε
WhileStmt -> while (E) { StatementList }
E -> value R | (E) R | id R | FuncCall | ArrayLiteral 
R -> + E R | - E R | * E R | and E R | or E R | == E R | != E R ε
FuncDef -> function id (Params) { StatementList }
Params -> id ParamsTail | ε
ParamsTail -> , id ParamsTail | ε
FuncCall -> id (Args)
Args -> E ArgsTail | ε
ArgsTail -> , E ArgsTail | ε
ArrayDims -> [value] ArrayDims | ε
ArrayAccess -> [E] ArrayAccess | ε
ArrayLiteral -> [ArrayElements]
ArrayElements -> E ArrayElementsTail | ε
ArrayElementsTail -> , E ArrayElementsTail | ε
```