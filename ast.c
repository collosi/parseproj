#include "stdlib.h"
#include "ast.h"



void ast_set_location(ast_t *a, int line, int col) {
	a->line = line;
	a->col = col;
}
ast_t *ast_new_int_literal(char *image){
	ast_t *a = calloc(1, sizeof(ast_t));
	a->shape = AST_INT_LITERAL;
	a->image = image;
	return a;	
}

ast_t *ast_new_binop(char op, ast_t *left, ast_t *right) {
	ast_t *a = calloc(1, sizeof(ast_t));
	a->shape = AST_BINOP;
	a->binop.op = op;
	a->binop.lhs = left;
	a->binop.rhs = right;
	return a;	

}

void ast_free(ast_t * b){
	free(b);
}
