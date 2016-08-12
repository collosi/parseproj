%{
 
/*
 * Lexer.l file
 * To generate the lexical analyzer run: "flex lexer.l"
 */
 
#include <stdio.h>

#include "token.h"
#include "ast.h"
#include "parser.h"

 

#define YY_USER_ACTION do { \
	  yylloc->first_line = yylloc->last_line = yylineno; \
      yylloc->first_column = yycolumn; \
      yylloc->last_column = yycolumn + yyleng - 1; \
      yycolumn += yyleng; \
      yylval->token = token_new(yytext); \
    } while (0);

%}

%option outfile="lexer.c" header-file="lexer.h"
%option warn nodefault
 
%option reentrant noyywrap never-interactive nounistd
%option bison-bridge bison-locations yylineno
 
LPAREN      "("
RPAREN      ")"
PLUS        "+"
MULTIPLY    "*"
 
NUMBER      [0-9]+
WS          [ \r\n\t]*
 
%%
 
{WS}            { /* Skip blanks. */ }
{NUMBER}        { yylval->token = token_new(yytext); return TOKEN_NUMBER; }
 
{MULTIPLY}      { return TOKEN_MULTIPLY; }
{PLUS}          { return TOKEN_PLUS; }
{LPAREN}        { return TOKEN_LPAREN; }
{RPAREN}        { return TOKEN_RPAREN; }
 
%%
 
static int yyerror(const char *msg) {
    fprintf(stderr,"Error:%s\n",msg); return 0;
}