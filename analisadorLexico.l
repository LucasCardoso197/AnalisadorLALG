%{
    // Inclui código de tokens do analisador sintático
    #include "y.tab.h"
    int yywrap(void){};
    int nlines = 1;

    // Inicialização tabela de palavras reservadas
	//HASH_TABLE *reservedWordsTable = hash_create( );

    // Funções auxiliares
%}

digit [0-9]
letter [a-z]
alpha [a-zA-z]
signal [-+]
blank [\t ]
invalidCharacter [@]

%%
"program" {return W_PROGRAM;} //Palavras reservadas
"begin" {return W_BEGIN;}
"end" {return W_END;}
"const" {return W_CONST;}
"real" {return W_REAL;}
"integer" {return W_INTEGER;}
"procedure" {return W_PROCEDURE;}
"else" {return W_ELSE;}
"read" {return W_READ;}
"write" {return W_WRITE;}
"while" {return W_WHILE;}
"if" {return W_IF;}
"do" {return W_DO;}
"then" {return W_THEN;}
"for" {return W_FOR;}
"var" {return W_VAR;}
({alpha}|_)({alpha}|_|{digit})* {return IDENT;}
{digit}+ {return NUM_INT;}
{digit}+\.{digit}+ {return NUM_REAL;}
"+" {return OP_SOMA;}
"-" {return OP_SUBT;}
"*" {return OP_MULT;}
"/" {return OP_DIV;}
"=" {return OP_IGUAL;}
"<>" {return OP_DIF;}
">=" {return OP_MAIOR_IGUAL;}
"<=" {return OP_MENOR_IGUAL;}
"<" {return OP_MENOR;}
">" {return OP_MAIOR;}
":=" {return OP_ATRIBUICAO;}
"." {return SIMB_PONTO;}
"(" {return SIMB_ABRIR_PARENT;}
")" {return SIMB_FECHAR_PARENT;}
";" {return SIMB_PONTO_VIRG;}
"," {return SIMB_VIRG;}
":" {return SIMB_DOIS_PONTOS;}
\{.*\} {} //ignora comentarios
{blank}+ {} //ignora caracteres de novalinha e espaços em branco
"\n" {nlines++;} //contador de linhas

{invalidCharacter} {fprintf(stdout, "Line %d: %s - erro lexico - caractere invalido\n", nlines, yytext);}
{digit}+({alpha}|_)({alpha}|_|{digit})* {fprintf(stdout, "Line %d: %s - erro lexico - identificador mal formado\n", nlines, yytext);}
{digit}+\.{digit}*{alpha}{digit}* {fprintf(stdout, "Line %d: %s - erro lexico - numero real mal formado\n", nlines, yytext);}
. {fprintf(stdout, "Line %d: %s - erro lexico", nlines, yytext);}
%%
