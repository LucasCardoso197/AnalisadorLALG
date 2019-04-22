#include "lexer.h"

const char *getTypeName(enum TOKEN_TYPE tipo){
    switch(tipo){
        case IDENTIFICADOR:  return "IDENTIFICADOR";
        case NUMERO_INTEIRO:  return "NUMERO_INTEIRO";
        case NUMERO_REAL:  return "NUMERO_REAL";
        case OP_SOMA:  return "OP_SOMA";
        case OP_SUBT:  return "OP_SUBT";
        case OP_MULT:  return "OP_MULT";
        case OP_DIV:  return "OP_DIV";
        case OP_IGUAL:  return "OP_IGUAL";
        case OP_DIF:  return "OP_DIF";
        case OP_MAIGUAL:  return "OP_MAIGUAL";
        case OP_MEIGUAL:  return "OP_MEIGUAL";
        case OP_MENOR:  return "OP_MENOR";
        case OP_MAIOR:  return "OP_MAIOR";
        case OP_ATRIB:  return "OP_ATRIB";
        case AB_PARENTESES:  return "AB_PARENTESES";
        case FE_PARENTESES:  return "FE_PARENTESES";
        case PVIRGULA:  return "PVIRGULA";
        case VIRGULA:  return "VIRGULA";
        case DOIS_PONTOS:  return "DOIS_PONTOS";
    }
}