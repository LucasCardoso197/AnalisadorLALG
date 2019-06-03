#include "lexer.h"

const char *getTypeName(enum TOKEN_TYPE tipo){
    switch(tipo){
        case identificador:  return "identificador";
        case numero_inteiro:  return "numero_inteiro";
        case numero_real:  return "numero_real";
        case op_soma:  return "op_soma";
        case op_subt:  return "op_subt";
        case op_mult:  return "op_mult";
        case op_div:  return "op_div";
        case op_igual:  return "op_igual";
        case op_diferente:  return "op_diferente";
        case op_maior_igual:  return "op_maior_igual";
        case op_menor_igual:  return "op_menor_igual";
        case op_menor:  return "op_menor";
        case op_maior:  return "op_maior";
        case op_atribuicao:  return "op_atribuicao";
        case simb_ponto: return "simb_ponto";
        case simb_abrir_parenteses:  return "simb_abrir_parenteses";
        case simb_fechar_parenteses:  return "simb_fechar_parenteses";
        case simb_ponto_virgula:  return "simb_ponto_virgula";
        case simb_virgula:  return "simb_virgula";
        case simb_dois_pontos:  return "simb_dois_pontos";
    }
}