%{
#include "y.tab.h"
%}

%%

[ \t\n]          /* skip whitespace */

"if"             { return IF; }
"else"           { return ELSE; }
"while"          { return WHILE; }
"for"            { return FOR; }
"switch"         { return SWITCH; }
"case"           { return CASE; }
"default"        { return DEFAULT; }
"&&"             { return LOGICAL_AND; }
"||"             { return LOGICAL_OR; }
"<="             { return LESS_EQUAL; }
">="             { return GREATER_EQUAL; }
"=="             { return EQUAL; }
"!="             { return NOT_EQUAL; }
"<"              { return LESS_THAN; }
">"              { return GREATER_THAN; }
"^"              { return '^'; }
"/"              { return '/'; }
"*"              { return '*'; }
"-"              { return '-'; }
"+"              { return '+'; }
"("              { return '('; }
")"              { return ')'; }
";"              { return ';'; }

[0-9]+           { yylval.str = strdup(yytext); return SIGNED_INTEGER; }
[a-n][0-9][0-9]  { yylval.str = strdup(yytext); return SIGNED_INTEGER; }
[o-z][0-9][0-9]  { yylval.str = strdup(yytext); return DOUBLE_FLOAT; }

.                { yyerror("Invalid character"); }

%%

void yyerror(const char *s) {
    fprintf(stderr, "Lexer error: %s\n", s);
}

int yywrap() {
    return 1;
}
