#include <stdio.h>
#include "lexer.h"

int main(){
    int result;

    while((result = yylex()) != 0){
        printf("(\"%s\", %s)\n", yytext, getTypeName(result));
    }
    return 0;
}