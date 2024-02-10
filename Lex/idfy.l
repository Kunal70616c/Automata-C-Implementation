%{
#include <stdio.h>
%}

%%

"if"|"else"|"while"|"for"        { printf("Keyword: %s\n", yytext); }
"print"                          { printf("Print Statement: %s\n", yytext); }
[0-9]                            { printf("Single Digit: %c\n", yytext[0]); }
[0-9]+                           { printf("Number: %s\n", yytext); }
[a-zA-Z]+                        { printf("Word: %s\n", yytext); }
"("                              { printf("Left Parenthesis\n"); }
")"                              { printf("Right Parenthesis\n"); }
"{"                              { printf("Left Curly Brace\n"); }
"}"                              { printf("Right Curly Brace\n"); }
"=="                             { printf("Double Equal To\n"); }
"="                              { printf("Equal To\n"); }
"<"                              { printf("Less Than\n"); }
">"                              { printf("Greater Than\n"); }
"<="                             { printf("Less Than or Equal To\n"); }
">="                             { printf("Greater Than or Equal To\n"); }
"&&"                             { printf("Logical AND\n"); }
"||"                             { printf("Logical OR\n"); }
"!"                              { printf("Logical NOT\n"); }
\"[^"]*\"                        { printf("String: %s\n", yytext); }
.                                { /* Ignore other characters */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Input :: ");
    yylex();
    return 0;
}
