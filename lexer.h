#ifndef _LEXER_H_
#define _LEXER_H_

#include <stdio.h>

extern int   yylex();
extern char* yytext;
extern int   yyleng;

enum TOKEN_TYPE {BLANK, IDENTIFICADOR, NUMERO_INTEIRO, NUMERO_REAL, 
         OP_SOMA, OP_SUBT, OP_MULT, OP_DIV, OP_IGUAL, OP_DIF, OP_MAIGUAL,
         OP_MEIGUAL, OP_MENOR, OP_MAIOR, OP_ATRIB, AB_PARENTESES, FE_PARENTESES,
         PVIRGULA, VIRGULA, DOIS_PONTOS};
const char *getTypeName(enum TOKEN_TYPE tipo);

#endif