%{
 
/*
 * Parser.y file
 * To generate the parser run: "bison Parser.y"
 */
 
#include <stdio.h>
#include "ast.h"
#include "token.h"
#include "parser.h"

int yyerror(YYLTYPE *loc, ast_t **ast, yyscan_t scanner, const char *msg) {
    printf("%d:%d:%d syntax error\n", loc->first_line, loc->first_column, loc->last_column);
    // Add error handling routine as needed
}
 
%}

%code requires {

#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
typedef void* yyscan_t;
#endif

}

%define api.pure full
%define api.push-pull push

%output  "parser.c"
%defines "parser.h"
 

%lex-param   { yyscan_t scanner }
%parse-param { ast_t **ast }
%parse-param { yyscan_t scanner }

%union {
    token_t *token;
    ast_t *ast;
}
 
%left '+' TOKEN_PLUS
%left '*' TOKEN_MULTIPLY
 
%token TOKEN_LPAREN
%token TOKEN_RPAREN
%token TOKEN_PLUS
%token TOKEN_MULTIPLY
%token <token> TOKEN_NUMBER

%type <ast> expr
 
%%
 
input
    : expr { *ast = $1; }
    ;
 
expr
    : expr[L] TOKEN_PLUS expr[R] { $$ = ast_new_binop( '+', $L, $R ); }
    | expr[L] TOKEN_MULTIPLY expr[R] { $$ = ast_new_binop( '*', $L, $R ); }
    | TOKEN_LPAREN expr[E] TOKEN_RPAREN { $$ = $E; }
    | TOKEN_NUMBER { $$ = ast_new_int_literal($1->image); ast_set_location($$, @1.first_line, @1.first_column); }
    ;
 
%%
