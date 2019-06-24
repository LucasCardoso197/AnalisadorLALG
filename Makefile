all: lex.yy.c y.tab.c
	gcc -o a.out y.tab.c
lex.yy.c: analisadorLexico.l y.tab.c
	flex analisadorLexico.l
y.tab.c: analisadorSintatico.y
	yacc analisadorSintatico.y -d
run:
	./a.out
test1:
	./a.out < ./_input/input1.txt > ./_output/output1.txt
test2:
	./a.out < ./_input/input2.txt > ./_output/output2.txt
test3:
	./a.out < ./_input/input3.txt > ./_output/output3.txt
test4:
	./a.out < ./_input/input4.txt > ./_output/output4.txt
test5:
	./a.out < ./_input/input5.txt > ./_output/output5.txt
clean:
	rm a.out lex.yy.c y.tab.c y.tab.h y.output out.txt