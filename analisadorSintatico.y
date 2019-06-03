%{
	#include <stdio.h>
	extern int   yylex();
	extern char* yytext;
	extern int   yyleng;
	int yyerror() {fprintf(stderr, "Erro sintatico.\n");}
%}
// Tokens gerais
%token IDENT NUM_INT NUM_REAL
// Tokens de operadores
%token OP_SOMA OP_SUBT OP_MULT OP_DIV OP_IGUAL OP_DIF OP_MAIOR_IGUAL
%token OP_MENOR_IGUAL OP_MENOR OP_MAIOR OP_ATRIBUICAO
// Tokens de simbolos especiais
%token SIMB_PONTO SIMB_ABRIR_PARENT SIMB_FECHAR_PARENT
%token SIMB_PONTO_VIRG SIMB_VIRG SIMB_DOIS_PONTOS
// Tokens de palavras reservadas
%token W_PROGRAM W_BEGIN W_END W_CONST W_REAL W_INTEGER W_PROCEDURE W_ELSE W_READ
%token W_WRITE W_WHILE W_IF W_DO W_THEN W_FOR W_VAR
// Token de erro
%token ERROR

%%
programa: W_PROGRAM IDENT SIMB_PONTO_VIRG corpo {printf("Programa válido.\n");}
		;
corpo: dc W_BEGIN comandos W_END
	 ;
dc: dc_c dc_v dc_p
  ;
dc_c: W_CONST IDENT OP_IGUAL numero SIMB_PONTO_VIRG dc_c
	| /* vazia */
	;
dc_v: W_VAR variaveis SIMB_DOIS_PONTOS tipo_var SIMB_PONTO_VIRG dc_v
	| /* vazia */
	;
tipo_var: W_REAL
		| W_INTEGER
		;
variaveis: IDENT mais_var
		 ;
mais_var: SIMB_VIRG variaveis
		| /* vazia */
		;
dc_p: W_PROCEDURE IDENT parametros SIMB_PONTO_VIRG corpo_p dc_p
	| /* vazia */
	;
parametros: SIMB_ABRIR_PARENT lista_par SIMB_FECHAR_PARENT
		  | /* vazia */
		  ;
lista_par: variaveis SIMB_DOIS_PONTOS tipo_var mais_par
		 ;
mais_par: SIMB_PONTO_VIRG lista_par
		| /* vazia */
		;
corpo_p: dc_loc W_BEGIN comandos W_END SIMB_PONTO_VIRG
	   ;
dc_loc: dc_v
	  ;
lista_arg: SIMB_ABRIR_PARENT argumentos SIMB_FECHAR_PARENT
		 | /* vazia */
		 ;
argumentos: IDENT mais_ident
		  ;
mais_ident: SIMB_PONTO_VIRG argumentos
		  | /* vaiza */
		  ;
pfalsa: W_ELSE cmd
	  | /* vazia */
	  ;
comandos: cmd SIMB_PONTO_VIRG comandos
		| /* vazia */
		;
cmd: W_READ SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT
   | W_WRITE SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT
   | W_WHILE SIMB_ABRIR_PARENT condicao SIMB_FECHAR_PARENT W_DO cmd
   | W_IF condicao W_THEN cmd pfalsa
   | IDENT OP_ATRIBUICAO expressao
   | IDENT lista_arg
   | W_BEGIN comandos W_END
   ;
condicao: expressao relacao expressao
		;
relacao: OP_IGUAL
	   | OP_DIF
	   | OP_MAIOR
	   | OP_MENOR
	   | OP_MAIOR_IGUAL
	   | OP_MENOR_IGUAL
	   ;
expressao: termo outros_termos
		 ;
op_un: OP_SOMA
	 | OP_SUBT
	 | /* vazia */
	 ;
outros_termos: op_ad termo outros_termos
			 | /* vazia */
			 ;
op_ad: OP_SOMA
	 | OP_SUBT
	 ;
termo: op_un fator mais_fatores
	 ;
mais_fatores: op_mul fator mais_fatores
			| /* vazia */
			;
op_mul: OP_MULT
	  | OP_DIV
	  ;
fator: IDENT
	 | numero
	 | SIMB_ABRIR_PARENT expressao SIMB_FECHAR_PARENT
	 ;
numero: NUM_INT
	  | NUM_REAL
	  ;
%%

// Funções
int main(){
	yyparse();
	return 0;
}