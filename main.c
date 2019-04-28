#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "hash_linear.h"


int main(){
	int result,i;
	char type[30];

	HASH_TABLE *table = hash_create(17);
	int c = 10;
	char *palavra_reservada[]={"begin","const","do","end","else","for","if","integer","procedure","program",
				"real","read","while","write"};
	char *cc = NULL;
	for (i = 0; i < 14; i++) {
		c=get_key(palavra_reservada[i]);
		hash_put(table, c, palavra_reservada[i]);
	}

	while((result = yylex()) != 0){
		if(result != identificador){
			strcpy(type, getTypeName(result));
			//printf("%s - %s\n", yytext, type);
		}
		else{
			if(yyleng > 30) printf(" - erro - identificador muito grande");
			else{
				//Procura na tabela hash 
				if(hash_get(table,get_key(yytext)) ){
					strcpy(type, hash_get(table,get_key(yytext)));
				}else
					strcpy(type, getTypeName(result));
			}	 
		}
		printf("%s - %s\n", yytext, type);
	}
	return 0;
}