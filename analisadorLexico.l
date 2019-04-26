%{
    int yywrap(void){};
%}
%{
    enum TOKEN_TYPE {blank, identificador, numero_inteiro, numero_real, 
                     op_soma, op_subt, op_mult, op_div, op_igual, op_diferente, op_maior_igual,
                     op_menor_igual, op_menor, op_maior, op_atribuicao, simb_ponto, simb_abrir_parenteses, simb_fechar_parenteses,
                     simb_ponto_virgula, simb_virgula, simb_dois_pontos};
%}

digit [0-9]
letter [a-z]
alpha [a-zA-z]
signal [-+]
blank [\n\t ]
invalidCharacter [@]

%%
({alpha}|_)({alpha}|_|{digit})* {return identificador;}
{digit}+ {return numero_inteiro;}
{digit}+\.{digit}+ {return numero_real;}
"+" {return op_soma;}
"-" {return op_subt;}
"*" {return op_mult;}
"/" {return op_div;}
"=" {return op_igual;}
"<>" {return op_diferente;}
">=" {return op_maior_igual;}
"<=" {return op_menor_igual;}
"<" {return op_menor;}
">" {return op_maior;}
":=" {return op_atribuicao;}
"." {return simb_ponto;}
"(" {return simb_abrir_parenteses;}
")" {return simb_fechar_parenteses;}
";" {return simb_ponto_virgula;}
"," {return simb_virgula;}
":" {return simb_dois_pontos;}
\{.*\} {} // ignora comentarios
{blank}+ {} //ignora caracteres de novalinha e espaços em branco

[^ \n]*{invalidCharacter}+[^ \n]* {fprintf(stderr, "Caractere invalido em: %s\n", yytext);}
{digit}+({alpha}|_)({alpha}|_|{digit})* {fprintf(stderr, "Indentificador mal formado em: %s\n", yytext);}
%%