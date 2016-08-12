
CFLAGS:=-Wall -Werror -std=c11 -O0 -g

parse: parser.o lexer.o main.c ast.c ast.h token.c token.h 
	gcc $(CFLAGS) -o $@ $(filter %.c %.o, $^)

parser.o: parser.c
	gcc -c -Wno-return-type $(CFLAGS) -o $@ $^

parser.c: parser.y
	bison parser.y

parser.h: parser.c

lexer.o: lexer.c
	gcc -c -Wno-unused-function $(CFLAGS) -gdwarf-4 -g3 -o $@ $(filter %.c, $^)

lexer.c: lexer.l
	flex -L lexer.l

lexer.h: lexer.c

.PHONY: clean fmt fetch test
clean:
	rm -f parse parser.c parser.h lexer.c lexer.h *.o

fmt:
	clang-format -i -style="{BasedOnStyle: Google, SortIncludes: false}" main.c token.h

fetch:
	cd testsrc; ./fetch

