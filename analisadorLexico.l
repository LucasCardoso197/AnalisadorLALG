%{
    // Inclui código de tokens do analisador sintático
    #include "y.tab.h"
    #include "hash_linear.h"
    int yywrap(void){};

    // Inicialização tabela de palavras reservadas
	HASH_TABLE *reservedWordsTable = hash_create( );

    // Funções auxiliares
    int testIdent(char *identName, int length);
    int getReservedWordValue(char *word);
%}

digit [0-9]
letter [a-z]
alpha [a-zA-z]
signal [-+]
blank [\n\t ]
invalidCharacter [@]

%%
({alpha}|_)({alpha}|_|{digit})* {int aux = testIdent(yytext, yyleng); if(aux != ERROR) return aux;}
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
\{.*\} {} // ignora comentarios
{blank}+ {} //ignora caracteres de novalinha e espaços em branco

{invalidCharacter} {fprintf(stdout, "%s - erro - caractere invalido\n", yytext);}
{digit}+({alpha}|_)({alpha}|_|{digit})* {fprintf(stdout, "%s - error - identificador mal formado\n", yytext);}
{digit}+\.{digit}*{alpha}{digit}* {fprintf(stdout, "%s - erro - numero real mal formado\n", yytext);}
. {fprintf(stdout, "%s - erro", yytext);}
%%

int getReservedWordValue(char *word){
    if(strcmp(word, "begin") == 0) return W_BEGIN;
    if(strcmp(word, "const") == 0) return W_CONST;
    if(strcmp(word, "do") == 0) return W_DO;
    if(strcmp(word, "end") == 0) return W_END;
    if(strcmp(word, "for") == 0) return W_FOR;
    if(strcmp(word, "if") == 0) return W_IF;
    if(strcmp(word, "integer") == 0) return W_INTEGER;
    if(strcmp(word, "procedure") == 0) return W_PROCEDURE;
    if(strcmp(word, "program") == 0) return W_PROGRAM;
    if(strcmp(word, "real") == 0) return W_REAL;
    if(strcmp(word, "read") == 0) return W_READ;
    if(strcmp(word, "while") == 0) return W_WHILE;
    if(strcmp(word, "write") == 0) return W_WRITE;
    if(strcmp(word, "then") == 0) return W_THEN;
    if(strcmp(word, "var") == 0) return W_VAR;
    return ERROR;
}

int testIdent(char *identName, int length){
    if(length > 30){
        fprintf(stdout, "%s - erro - identificador muito grande\n", yytext);
    } 
    else{
        //Procura na tabxela hash a palavra reservada
        if(hash_get(reservedWordsTable,get_key(identName)) ){
            return getReservedWordValue(hash_get(reservedWordsTable,get_key(identName)));
        } else
            return IDENT;
    }
}