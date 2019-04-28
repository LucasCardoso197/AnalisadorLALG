#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "lexer.h"
#include "hash_linear.h"

int main(){

	int result,i;
	char type[30], *element = NULL;
	HASH_TABLE *table = hash_create( );

	while((result = yylex()) != 0){
		if(result != identificador){
			strcpy(type, getTypeName(result));
		}
		else{
			if(yyleng > 30) printf("%s - erro - identificador muito grande",yytext);
			else{
				//Procura na tabela hash a palavra reservada
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