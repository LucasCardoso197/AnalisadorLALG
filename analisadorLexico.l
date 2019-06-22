%{
    // Inclui código de tokens do analisador sintático
    #include "y.tab.h"
    #include "hash_linear.h"
    int yywrap(void){};
    int nlines = 1;

    // Inicialização tabela de palavras reservadas
	//HASH_TABLE *reservedWordsTable = hash_create( );

    // Funções auxiliares
    int testIdent(char *identName, int length);
    int getReservedWordValue(char *word);
%}

digit [0-9]
letter [a-z]
alpha [a-zA-z]
signal [-+]
blank [\t ]
invalidCharacter [@]

%%
"program" {printf("1 - %s\n", yytext); return W_PROGRAM;} //Palavras reservadas
"begin" {printf("2 - %s\n", yytext); return W_BEGIN;}
"end" {printf("3 - %s\n", yytext); return W_END;}
"const" {printf("4 - %s\n", yytext); return W_CONST;}
"real" {printf("5 - %s\n", yytext); return W_REAL;}
"integer" {printf("6 - %s\n", yytext); return W_INTEGER;}
"procedure" {printf("7 - %s\n", yytext); return W_PROCEDURE;}
"else" {printf("8 - %s\n", yytext); return W_ELSE;}
"read" {printf("9 - %s\n", yytext); return W_READ;}
"write" {printf("10 - %s\n", yytext); return W_WRITE;}
"while" {printf("11 - %s\n", yytext); return W_WHILE;}
"if" {printf("12 - %s\n", yytext); return W_IF;}
"do" {printf("13 - %s\n", yytext); return W_DO;}
"then" {printf("14 - %s\n", yytext); return W_THEN;}
"for" {printf("15 - %s\n", yytext); return W_FOR;}
"var" {printf("16 - %s\n", yytext); return W_VAR;}
({alpha}|_)({alpha}|_|{digit})* {printf("17 - %s\n", yytext); return IDENT;}
{digit}+ {printf("18 - %s\n", yytext); return NUM_INT;}
{digit}+\.{digit}+ {printf("19 - %s\n", yytext); return NUM_REAL;}
"+" {printf("21 - %s\n", yytext); return OP_SOMA;}
"-" {printf("22 - %s\n", yytext); return OP_SUBT;}
"*" {printf("23 - %s\n", yytext); return OP_MULT;}
"/" {printf("24 - %s\n", yytext); return OP_DIV;}
"=" {printf("25 - %s\n", yytext); return OP_IGUAL;}
"<>" {printf("26 - %s\n", yytext); return OP_DIF;}
">=" {printf("27 - %s\n", yytext); return OP_MAIOR_IGUAL;}
"<=" {printf("28 - %s\n", yytext); return OP_MENOR_IGUAL;}
"<" {printf("29 - %s\n", yytext); return OP_MENOR;}
">" {printf("30 - %s\n", yytext); return OP_MAIOR;}
":=" {printf("31 - %s\n", yytext); return OP_ATRIBUICAO;}
"." {printf("32 - %s\n", yytext); return SIMB_PONTO;}
"(" {printf("33 - %s\n", yytext); return SIMB_ABRIR_PARENT;}
")" {printf("34 - %s\n", yytext); return SIMB_FECHAR_PARENT;}
";" {printf("35 - %s\n", yytext); return SIMB_PONTO_VIRG;}
"," {printf("36 - %s\n", yytext); return SIMB_VIRG;}
":" {printf("37 - %s\n", yytext); return SIMB_DOIS_PONTOS;}
\{.*\} {} //ignora comentarios
{blank}+ {} //ignora caracteres de novalinha e espaços em branco
"\n" {nlines++;} //contador de linhas

{invalidCharacter} {fprintf(stdout, "%s - erro lexico - caractere invalido\n", yytext);}
{digit}+({alpha}|_)({alpha}|_|{digit})* {fprintf(stdout, "%s - erro lexico - identificador mal formado\n", yytext);}
{digit}+\.{digit}*{alpha}{digit}* {fprintf(stdout, "%s - erro lexico - numero real mal formado\n", yytext);}
. {fprintf(stdout, "%s - erro lexico", yytext);}
%%
