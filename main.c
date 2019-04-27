#include <stdio.h>
#include <string.h>
#include "lexer.h"

int main(){
	int result;
	char type[30];

	while((result = yylex()) != 0){
		if(result != identificador)
			strcpy(type, getTypeName(result));
		else{
			if(yyleng > 30)
				printf("%s - erro - identificador muito grande");
			else {
				// Busca na hash
				// Se não encontrar fazer getTypeName(IDENTIFICADOR)
				// Se encontrar faz strcpy(type, yytext)
				if(0)
					strcpy(type, yytext);
				else
					strcpy(type, getTypeName(identificador));
			}
		}
		printf("%s - %s\n", yytext, type);
	}
	return 0;
}