#ifndef _AST_H__
#define _AST_H__

/**
 * @brief The operation type
 */
enum ast_shape
{
  AST_UNKNOWN = 0,
  AST_INT_LITERAL,
  AST_BINOP
};

typedef struct _ast_t {
  enum ast_shape shape;
  char *image;
  int line;
  int col;

  union {
    struct {
    	char op;
      struct _ast_t *lhs;
      struct _ast_t *rhs;
    } binop;
    struct {
      char *image;
    } literal;
  };
} ast_t; 


void ast_set_location(ast_t *a, int line, int col);

/**
 * @brief It creates an identifier
 * @param value The number value
 * @return The expression or NULL in case of no memory
 */
ast_t *ast_new_int_literal(char *image);

/**
 * @brief It creates an operation
 * @param type The operation type
 * @param left The left operand
 * @param right The right operand
 * @return The expression or NULL in case of no memory
 */
ast_t *ast_new_binop(char op, ast_t *left, ast_t *right);

/**
 * @brief Deletes a expression
 * @param b The expression
 */
void ast_free(ast_t * b);

#endif 
