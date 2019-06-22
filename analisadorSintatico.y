%{
	#include <stdio.h>
	extern int   yylex();
	extern char* yytext;
	extern int   yyleng;
	extern int nlines;
	//int yyerror() {fprintf(stderr, "Erro sintatico.\n");}
	void yyerror(const char* errormessage){
		printf("%s - at line %d\n", errormessage, nlines);
	}
%}
// Tokens geraiss
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

%%
programa: W_PROGRAM IDENT SIMB_PONTO_VIRG corpo SIMB_PONTO {printf("Final da análise sintática.\n");}
		| error SIMB_PONTO
		;
corpo: dc W_BEGIN comandos W_END {printf("Reduced corpo.\n");}
	 | error W_END
	 ;
dc: dc_c dc_v dc_p {printf("Reduced dc.\n");}
	| error SIMB_PONTO_VIRG
	;
dc_c: 
	 %empty  {printf("Reduced dc_c empty.\n");}
	| W_CONST IDENT OP_IGUAL numero SIMB_PONTO_VIRG dc_c  {printf("Reduced dc_c.\n");}
	;
dc_v:
	 %empty  {printf("Reduced dc_v empty.\n");}
	| W_VAR variaveis SIMB_DOIS_PONTOS tipo_var SIMB_PONTO_VIRG dc_v  {printf("dc_v.\n");}
	;
tipo_var: W_REAL {printf("Reduced tipo_var.\n");}
		| W_INTEGER {printf("Reduced tipo_var.\n");}
		;
variaveis: IDENT mais_var {printf("Reduced variaveis\n");}
		 ;
mais_var:
	 	 %empty {printf("Reduced mais_var empty.\n");}
	 	| SIMB_VIRG variaveis  {printf("Reduced mais_var.\n");}
		;
dc_p: 
	 %empty  {printf("Reduced dc_p empty.\n");}
	| W_PROCEDURE IDENT parametros SIMB_PONTO_VIRG corpo_p dc_p  {printf("Reduced dc_p.\n");}
	;
parametros: 
	 	   %empty  {printf("Reduced parametros empty.\n");}
	 	  | SIMB_ABRIR_PARENT lista_par SIMB_FECHAR_PARENT {printf("Reduced parametros.\n");}
		  ;
lista_par: variaveis SIMB_DOIS_PONTOS tipo_var mais_par {printf("Reduced lista_par.\n");}
		 ;
mais_par: 
	 	 %empty {printf("Reduced mais_par empty.\n");}
	 	| SIMB_PONTO_VIRG lista_par {printf("Reduced mais_par.\n");}
		;
corpo_p: dc_loc W_BEGIN comandos W_END SIMB_PONTO_VIRG {printf("Reduced corpo_p.\n");}
	   ;
dc_loc: dc_v {printf("Reduced dc_loc.\n");}
	  ;
lista_arg:
	 	  %empty {printf("Reduced lista_arg empty.\n");}
	 	 | SIMB_ABRIR_PARENT argumentos SIMB_FECHAR_PARENT {printf("Reduced lista_arg.\n");}
		 ;
argumentos: IDENT mais_ident {printf("Reduced argumentos.\n");}
		  ;
mais_ident: 
	 	   %empty {printf("Reduced mais_ident empty.\n");}
	 	  | SIMB_PONTO_VIRG argumentos {printf("Reduced mais_ident.\n");}
		  ;
pfalsa: 
	   %empty {printf("Reduced pfalsa vazia.\n");}
	  | W_ELSE cmd {printf("Reduced pfalsa.\n");}
	  ;
comandos: 
	 	 %empty {printf("Reduced comandos empty.\n");}
	 	| cmd SIMB_PONTO_VIRG comandos {printf("Reduced comandos.\n");}
		| error SIMB_PONTO_VIRG
		;
cmd: W_READ SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT {printf("Reduced cmd read.\n");}
   | W_WRITE SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT {printf("Reduced cmd write.\n");}
   | W_WHILE SIMB_ABRIR_PARENT condicao SIMB_FECHAR_PARENT W_DO cmd {printf("Reduced cmd while.\n");}
   | W_IF condicao W_THEN cmd pfalsa {printf("Reduced cmd if.\n");}
   | IDENT OP_ATRIBUICAO expressao {printf("Reduced cmd atrib.\n");}
   | IDENT lista_arg {printf("Reduced cmd ident.\n");}
   | W_BEGIN comandos W_END {printf("Reduced cmd begin.\n");}
   | error SIMB_FECHAR_PARENT
   | error W_END
   ;
condicao: expressao relacao expressao {printf("Reduced condicao.\n");}
		;
relacao: OP_IGUAL {printf("Reduced relacao.\n");}
	   | OP_DIF {printf("Reduced relacao.\n");}
	   | OP_MAIOR {printf("Reduced relacao.\n");}
	   | OP_MENOR {printf("Reduced relacao.\n");}
	   | OP_MAIOR_IGUAL {printf("Reduced relacao.\n");}
	   | OP_MENOR_IGUAL {printf("Reduced relacao.\n");}
	   ;
expressao: termo outros_termos {printf("Reduced expressao.\n");}
		 ;
op_un: 
	  %empty {printf("Reduced op_un empty.\n");}
	 | OP_SOMA {printf("Reduced op_un.\n");}
	 | OP_SUBT {printf("Reduced op_un.\n");}
	 ;
outros_termos: 
	 	   	  %empty {printf("Reduced outros_termos empty.\n");}
	 	  	 | op_ad termo outros_termos {printf("Reduced outros_termos.\n");}
			 ;
op_ad: OP_SOMA {printf("Reduced op_ad.\n");}
	 | OP_SUBT {printf("Reduced op_ad.\n");}
	 ;
termo: op_un fator mais_fatores {printf("Reduced termo.\n");}
	 ;
mais_fatores: 
	 		 %empty {printf("Reduced mais_fatores empty.\n");}
	 		| op_mul fator mais_fatores {printf("Reduced mais_fatores.\n");}
			;
op_mul: OP_MULT {printf("Reduced op_mul.\n");}
	  | OP_DIV {printf("Reduced op_mul.\n");}
	  ;
fator: IDENT {printf("Reduced fator.\n");}
	 | numero {printf("Reduced fator.\n");}
	 | SIMB_ABRIR_PARENT expressao SIMB_FECHAR_PARENT {printf("Reduced fator.\n");}
	 ;
numero: NUM_INT {printf("Reduced numero.\n");}
	  | NUM_REAL {printf("Reduced numero.\n");}
	  ;
%%

// Funções
int main(){
	yyparse();
	return 0;
}