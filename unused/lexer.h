#ifndef _LEXER_H_
#define _LEXER_H_

#include <stdio.h>

extern int   yylex();
extern char* yytext;
extern int   yyleng;

enum TOKEN_TYPE {blank, identificador, numero_inteiro, numero_real, 
         op_soma, op_subt, op_mult, op_div, op_igual, op_diferente, op_maior_igual,
         op_menor_igual, op_menor, op_maior, op_atribuicao, simb_ponto, simb_abrir_parenteses, simb_fechar_parenteses,
         simb_ponto_virgula, simb_virgula, simb_dois_pontos};
const char *getTypeName(enum TOKEN_TYPE tipo);

#endif