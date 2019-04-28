all: lex.yy.c lexer.c lexer.h
	gcc -lm -o a.out *.c
lex.yy.c: analisadorLexico.l
	flex analisadorLexico.l
run:
	./a.out
test:
	./a.out < input.txt
clean:
	rm a.out lex.yy.c out.txt