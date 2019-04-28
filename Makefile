all: lex.yy.c lexer.c lexer.h
	gcc -o a.out *.c -lm
lex.yy.c: analisadorLexico.l
	flex analisadorLexico.l
run:
	./a.out
test:
	./a.out < input.txt
test1:
	./a.out < input1.txt
test2:
	./a.out < input2.txt
test3:
	./a.out < input3.txt
clean:
	rm a.out lex.yy.c out.txt