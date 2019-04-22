%{
    int yywrap(void){};
%}
%{
    enum TOKEN_TYPE {BLANK, IDENTIFICADOR, NUMERO_INTEIRO, NUMERO_REAL, 
         OP_SOMA, OP_SUBT, OP_MULT, OP_DIV, OP_IGUAL, OP_DIF, OP_MAIGUAL,
         OP_MEIGUAL, OP_MENOR, OP_MAIOR, OP_ATRIB, AB_PARENTESES, FE_PARENTESES,
         PVIRGULA, VIRGULA, DOIS_PONTOS};
%}

digit [0-9]
letter [a-z]
alpha [a-zA-z]
signal [-+]
blank [\n\t ]

%%
({alpha}|_)({alpha}|_|{digit})* {return IDENTIFICADOR;}
{digit}+ {return NUMERO_INTEIRO;}
{digit}+\.{digit}+ {return NUMERO_REAL;}
"+" {return OP_SOMA;}
"-" {return OP_SUBT;}
"*" {return OP_MULT;}
"/" {return OP_DIV;}
"=" {return OP_IGUAL;}
"<>" {return OP_DIF;}
">=" {return OP_MAIGUAL;}
"<=" {return OP_MEIGUAL;}
"<" {return OP_MENOR;}
">" {return OP_MAIOR;}
":=" {return OP_ATRIB;}
"(" {return AB_PARENTESES;}
")" {return FE_PARENTESES;}
";" {return PVIRGULA;}
"," {return VIRGULA;}
":" {return DOIS_PONTOS;}
{blank}+ {} //ignora caracteres de novalinha e espaços em branco
%%