%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { INTEGER, FLOAT } DataType;
typedef struct {
    char *text;
    DataType data_type;
} Expression;

void yyerror(const char *s);
extern FILE *yyin;
%}

%token SIGNED_INTEGER DOUBLE_FLOAT LOGICAL_AND LOGICAL_OR
%token EQUAL NOT_EQUAL LESS_EQUAL GREATER_EQUAL LESS_THAN GREATER_THAN
%token IF ELSE WHILE FOR SWITCH CASE DEFAULT

%type <Expression*> expression
%type <Expression*> if_statement while_statement for_statement switch_statement case_list case

%%

program: statement_list
       | /* empty */
       ;

statement_list: statement_list statement
              | statement
              ;

statement: expression ';' { printf("%s;\n", $1->text); free($1); }
         | if_statement
         | while_statement
         | for_statement
         | switch_statement
         ;

if_statement: IF '(' expression ')' statement %prec LOWER_THAN_ELSE
                                        { printf("if (%s) %s\n", $3->text, $5->text); free($3); free($5); }
            | IF '(' expression ')' statement ELSE statement
                                        { printf("if (%s) %s else %s\n", $3->text, $5->text, $7->text); free($3); free($5); free($7); }
            ;

while_statement: WHILE '(' expression ')' statement
                                        { printf("while (%s) %s\n", $3->text, $5->text); free($3); free($5); }
               ;

for_statement: FOR '(' expression ';' expression ';' expression ')' statement
                                        { printf("for (%s; %s; %s) %s\n", $3->text, $5->text, $7->text, $9->text); free($3); free($5); free($7); free($9); }
              ;

switch_statement: SWITCH '(' expression ')' '{' case_list '}'
                                        { printf("switch (%s) {\n%s}\n", $3->text, $6->text); free($3); free($6); }
                 ;

case_list: case_list case
         | case
         ;

case: CASE SIGNED_INTEGER ':' statement
    | DEFAULT ':' statement
    ;

expression: SIGNED_INTEGER { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = strdup($1); $$->data_type = INTEGER; }
         | DOUBLE_FLOAT    { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = strdup($1); $$->data_type = FLOAT; }
         | expression '+' expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s + %s)", $1->text, $3->text); free($1); free($3); }
         | expression '-' expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s - %s)", $1->text, $3->text); free($1); free($3); }
         | expression '*' expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s * %s)", $1->text, $3->text); free($1); free($3); }
         | expression '/' expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s / %s)", $1->text, $3->text); free($1); free($3); }
         | expression '^' expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s ^ %s)", $1->text, $3->text); free($1); free($3); }
         | expression LOGICAL_AND expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 6); sprintf($$->text, "(%s && %s)", $1->text, $3->text); free($1); free($3); }
         | expression LOGICAL_OR expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 5); sprintf($$->text, "(%s || %s)", $1->text, $3->text); free($1); free($3); }
         | expression EQUAL expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s == %s)", $1->text, $3->text); free($1); free($3); }
         | expression NOT_EQUAL expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 5); sprintf($$->text, "(%s != %s)", $1->text, $3->text); free($1); free($3); }
         | expression LESS_EQUAL expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s <= %s)", $1->text, $3->text); free($1); free($3); }
         | expression GREATER_EQUAL expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s >= %s)", $1->text, $3->text); free($1); free($3); }
         | expression LESS_THAN expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s < %s)", $1->text, $3->text); free($1); free($3); }
         | expression GREATER_THAN expression { $$ = (Expression*)malloc(sizeof(Expression)); $$->text = malloc(strlen($1->text) + strlen($3->text) + 4); sprintf($$->text, "(%s > %s)", $1->text, $3->text); free($1); free($3); }
         ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(EXIT_FAILURE);
}
