
#include "token.h"
#include "ast.h"
#include "parser.h"
#include "lexer.h"


int main() {
  int status;
  yypstate *ps = yypstate_new ();
  yyscan_t scanner;
  yylex_init(&scanner);

  do {
    YYSTYPE yys = {0};
    YYLTYPE yyl = {0};
    int tok = yylex(&yys, &yyl, scanner);
    ast_t *astp;
    status = yypush_parse (ps, tok, &yys, &yyl, &astp, scanner);
  } while (status == YYPUSH_MORE);
  yypstate_delete (ps);
  return status;
}