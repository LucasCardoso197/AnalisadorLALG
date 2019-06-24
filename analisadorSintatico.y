%{
	#include <stdio.h>
	#include <string.h>
	#include "lex.yy.c"

	void yyerror(const char* errormessage);
	void tokenNameToStr(char *dest, char *src);
%}
// Tokens geraiss
%token IDENT NUM_INT NUM_REAL
// Tokens de operadores
%token OP_IGUAL OP_DIF OP_MAIOR_IGUAL
%token OP_MENOR_IGUAL OP_MENOR OP_MAIOR OP_ATRIBUICAO
%left OP_SOMA OP_SUBT
%left OP_MULT OP_DIV
// Tokens de simbolos especiais
%token SIMB_PONTO SIMB_ABRIR_PARENT SIMB_FECHAR_PARENT
%token SIMB_PONTO_VIRG SIMB_VIRG SIMB_DOIS_PONTOS
// Tokens de palavras reservadas
%token W_PROGRAM W_BEGIN W_END W_CONST W_REAL W_INTEGER W_PROCEDURE W_READ
%token W_WRITE W_WHILE W_DO W_THEN W_FOR W_VAR
// Gerenciando associatividade de if e else
%nonassoc W_IF
%nonassoc W_ELSE

%error-verbose

%%
programa: W_PROGRAM IDENT SIMB_PONTO_VIRG corpo SIMB_PONTO
		| error W_BEGIN less corpo SIMB_PONTO
		| W_PROGRAM error corpo SIMB_PONTO
		;
corpo: dc W_BEGIN comandos W_END
	 | error W_END
	 | dc W_BEGIN comandos SIMB_PONTO less {yyerror("syntax error, unexpected SIMB_PONTO, expecting W_END");}
	 ;
dc: dc_c dc_v dc_p
	;
dc_c: 
	 %empty
	| W_CONST IDENT OP_IGUAL numero SIMB_PONTO_VIRG dc_c
	| error sinc_c ok dc_c
	;
sinc_c:
		SIMB_PONTO_VIRG
	|	W_CONST less
	|	W_VAR less
	|	W_PROCEDURE less
	|	W_BEGIN less
	;
dc_v:
	 %empty
	| W_VAR variaveis SIMB_DOIS_PONTOS tipo_var SIMB_PONTO_VIRG dc_v
	| error sinc_v ok dc_v
	;
sinc_v:
		SIMB_PONTO_VIRG
	|	W_VAR less
	|	W_PROCEDURE less
	|	W_BEGIN less
	;
tipo_var: W_REAL
		| W_INTEGER
		;
variaveis: IDENT mais_var
		 ;
mais_var:
	 	 %empty
	 	| SIMB_VIRG variaveis
		;
		;
dc_p: 
	 %empty
	| W_PROCEDURE IDENT parametros SIMB_PONTO_VIRG corpo_p dc_p
	| W_PROCEDURE IDENT parametros error corpo_p ok dc_p
	| error sinc_p ok dc_v
	;
sinc_p:
		SIMB_PONTO_VIRG
	|	W_PROCEDURE less
	|	W_BEGIN less
	;
parametros: 
	 	   %empty
	 	  | SIMB_ABRIR_PARENT lista_par SIMB_FECHAR_PARENT
		  | error SIMB_FECHAR_PARENT
		  ;
lista_par: variaveis SIMB_DOIS_PONTOS tipo_var mais_par
		 | error SIMB_FECHAR_PARENT less
		 ;
mais_par: 
	 	 %empty
	 	| SIMB_PONTO_VIRG lista_par
		| error
		;
corpo_p: dc_loc W_BEGIN comandos W_END SIMB_PONTO_VIRG
	   ;
dc_loc: dc_v
	  ;
lista_arg:
	 	  %empty
	 	 | SIMB_ABRIR_PARENT argumentos SIMB_FECHAR_PARENT
		 | error SIMB_FECHAR_PARENT
		 | error
		 ;
argumentos: IDENT mais_ident
		  ;
mais_ident: 
	 	   %empty
	 	  | SIMB_PONTO_VIRG argumentos
		  ;
pfalsa: 
	   %empty
	  | W_ELSE cmd
	  ;
comandos: 
	 	 %empty
	 	| cmd SIMB_PONTO_VIRG comandos
		;
cmd: W_READ SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT
   | W_WRITE SIMB_ABRIR_PARENT variaveis SIMB_FECHAR_PARENT
   | W_WHILE SIMB_ABRIR_PARENT condicao SIMB_FECHAR_PARENT W_DO cmd
   | W_IF condicao W_THEN cmd pfalsa
   | IDENT OP_ATRIBUICAO expressao
   | IDENT lista_arg
   | W_BEGIN comandos W_END
   | error SIMB_FECHAR_PARENT { yyerrok;}
   | error W_END { yyerrok;}
   | error SIMB_PONTO_VIRG less {yyerrok;}
   ;
condicao: expressao relacao expressao
		| error
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
op_un: 
	  %empty
	 | OP_SOMA
	 | OP_SUBT
	 ;
outros_termos: 
	 	   	  %empty
	 	  	 | op_ad termo outros_termos
			 ;
op_ad: 
	  %empty
	 | OP_SOMA
	 | OP_SUBT
	 ;
termo: op_un fator mais_fatores
	 ;
mais_fatores: 
	 		 %empty
	 		| op_mul fator mais_fatores
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
ok: 
	%empty { yyerrok; /* este nao terminal apenas informa que o analisador deve sair do modo de recup. de erros */ } 
	;

/* este nao terminal apenas informa que o analisador deve sair do modo de recup. de erros */
less:
	%empty { yyless(0);}
	;
%%
void yyerror(const char* errormessage){
	char *aux, foundTokenName[50], foundToken[50], expectedTokenName[50], expectedToken[50];
	int pos;
	sscanf(errormessage, "syntax error, unexpected %[^,], expecting %s%n", foundTokenName, expectedTokenName, &pos);
	tokenNameToStr(foundToken, foundTokenName);
	tokenNameToStr(expectedToken, expectedTokenName);
	printf("Line %d: ", nlines);
	printf("syntax error, unexpected %s, expecting %s", foundToken, expectedToken);
	aux = (char *)errormessage+pos;
	while(aux < errormessage+strlen(errormessage)) {
		aux++;
		sscanf(aux, "or %s%n", expectedTokenName, &pos);
		tokenNameToStr(expectedToken, expectedTokenName);
		printf(" or %s", expectedToken);
		aux += pos;
	}
	printf("\n");
}

void tokenNameToStr(char *dest, char *src){
	if(strcmp(src, "IDENT") == 0) strcpy(dest, "identifier");
	else if(strcmp(src, "NUM_INT") == 0) strcpy(dest, "integer number");
	else if(strcmp(src, "NUM_REAL") == 0) strcpy(dest, "real number");
	else if(strcmp(src, "OP_IGUAL") == 0) strcpy(dest, "'='");
	else if(strcmp(src, "OP_DIF") == 0) strcpy(dest, "'<>'");
	else if(strcmp(src, "OP_MAIOR_IGUAL") == 0) strcpy(dest, "'>='");
	else if(strcmp(src, "OP_MENOR_IGUAL") == 0) strcpy(dest, "'<='");
	else if(strcmp(src, "OP_MENOR") == 0) strcpy(dest, "'<'");
	else if(strcmp(src, "OP_MAIOR") == 0) strcpy(dest, "'>'");
	else if(strcmp(src, "OP_ATRIBUICAO") == 0) strcpy(dest, "':='");
	else if(strcmp(src, "OP_SOMA") == 0) strcpy(dest, "'+'");
	else if(strcmp(src, "OP_SUBT") == 0) strcpy(dest, "'-'");
	else if(strcmp(src, "OP_MULT") == 0) strcpy(dest, "'*'");
	else if(strcmp(src, "OP_DIV") == 0) strcpy(dest, "'/'");
	else if(strcmp(src, "SIMB_PONTO") == 0) strcpy(dest, "'.'");
	else if(strcmp(src, "SIMB_ABRIR_PARENT") == 0) strcpy(dest, "'('");
	else if(strcmp(src, "SIMB_FECHAR_PARENT") == 0) strcpy(dest, "')'");
	else if(strcmp(src, "SIMB_PONTO_VIRG") == 0) strcpy(dest, "';'");
	else if(strcmp(src, "SIMB_VIRG") == 0) strcpy(dest, "','");
	else if(strcmp(src, "SIMB_DOIS_PONTOS") == 0) strcpy(dest, "':'");
	else if(strcmp(src, "W_PROGRAM") == 0) strcpy(dest, "'program'");
	else if(strcmp(src, "W_BEGIN") == 0) strcpy(dest, "'begin'");
	else if(strcmp(src, "W_END") == 0) strcpy(dest, "'end'");
	else if(strcmp(src, "W_CONST") == 0) strcpy(dest, "'const'");
	else if(strcmp(src, "W_REAL") == 0) strcpy(dest, "'real'");
	else if(strcmp(src, "W_INTEGER") == 0) strcpy(dest, "'integer'");
	else if(strcmp(src, "W_PROCEDURE") == 0) strcpy(dest, "'procedure'");
	else if(strcmp(src, "W_READ") == 0) strcpy(dest, "'read'");
	else if(strcmp(src, "W_WRITE") == 0) strcpy(dest, "'write'");
	else if(strcmp(src, "W_WHILE") == 0) strcpy(dest, "'while'");
	else if(strcmp(src, "W_DO") == 0) strcpy(dest, "'do'");
	else if(strcmp(src, "W_THEN") == 0) strcpy(dest, "'then'");
	else if(strcmp(src, "W_FOR") == 0) strcpy(dest, "'for'");
	else if(strcmp(src, "W_VAR") == 0) strcpy(dest, "'var'");
	else if(strcmp(src, "W_IF") == 0) strcpy(dest, "'if'");
	else if(strcmp(src, "W_ELSE") == 0) strcpy(dest, "'else'");
	else {
		printf("%s\n", src);
		strcpy(dest, src);
	}
}

int main(){
	yyparse();
	return 0;
}