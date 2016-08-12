#ifndef _TOKEN_H
#define _TOKEN_H


typedef struct {
	char *image;
} token_t;

token_t *token_new(char *image);

#endif