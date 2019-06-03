/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENT = 258,
    NUM_INT = 259,
    NUM_REAL = 260,
    OP_SOMA = 261,
    OP_SUBT = 262,
    OP_MULT = 263,
    OP_DIV = 264,
    OP_IGUAL = 265,
    OP_DIF = 266,
    OP_MAIOR_IGUAL = 267,
    OP_MENOR_IGUAL = 268,
    OP_MENOR = 269,
    OP_MAIOR = 270,
    OP_ATRIBUICAO = 271,
    SIMB_PONTO = 272,
    SIMB_ABRIR_PARENT = 273,
    SIMB_FECHAR_PARENT = 274,
    SIMB_PONTO_VIRG = 275,
    SIMB_VIRG = 276,
    SIMB_DOIS_PONTOS = 277,
    W_PROGRAM = 278,
    W_BEGIN = 279,
    W_END = 280,
    W_CONST = 281,
    W_REAL = 282,
    W_INTEGER = 283,
    W_PROCEDURE = 284,
    W_ELSE = 285,
    W_READ = 286,
    W_WRITE = 287,
    W_WHILE = 288,
    W_IF = 289,
    W_DO = 290,
    W_THEN = 291,
    W_FOR = 292,
    W_VAR = 293,
    ERROR = 294
  };
#endif
/* Tokens.  */
#define IDENT 258
#define NUM_INT 259
#define NUM_REAL 260
#define OP_SOMA 261
#define OP_SUBT 262
#define OP_MULT 263
#define OP_DIV 264
#define OP_IGUAL 265
#define OP_DIF 266
#define OP_MAIOR_IGUAL 267
#define OP_MENOR_IGUAL 268
#define OP_MENOR 269
#define OP_MAIOR 270
#define OP_ATRIBUICAO 271
#define SIMB_PONTO 272
#define SIMB_ABRIR_PARENT 273
#define SIMB_FECHAR_PARENT 274
#define SIMB_PONTO_VIRG 275
#define SIMB_VIRG 276
#define SIMB_DOIS_PONTOS 277
#define W_PROGRAM 278
#define W_BEGIN 279
#define W_END 280
#define W_CONST 281
#define W_REAL 282
#define W_INTEGER 283
#define W_PROCEDURE 284
#define W_ELSE 285
#define W_READ 286
#define W_WRITE 287
#define W_WHILE 288
#define W_IF 289
#define W_DO 290
#define W_THEN 291
#define W_FOR 292
#define W_VAR 293
#define ERROR 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
