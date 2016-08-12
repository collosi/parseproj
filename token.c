#include <stdlib.h>
#include "token.h"


token_t *token_new(char *image) {
	token_t *t = calloc(1, sizeof(token_t));
	t->image = __builtin_strdup(image);
	return t;
}
