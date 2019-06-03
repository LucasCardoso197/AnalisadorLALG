all: lex.yy.c y.tab.c
	gcc -o a.out *.c -lm
lex.yy.c: analisadorLexico.l y.tab.c
	flex analisadorLexico.l
y.tab.c: analisadorSintatico.y
	yacc analisadorSintatico.y -d
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
	rm a.out lex.yy.c y.tab.c y.tab.h out.txt