%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
%}

%token FOR LP RP SC EQ PLUS RELOP ID NUM

%%

stmt    : FOR LP init SC cond SC incr RP body  { printf("✅ Valid FOR loop\n"); }
        ;

init    : ID EQ NUM
        ;

cond    : ID RELOP NUM
        ;

incr    : ID EQ ID PLUS NUM
        ;

body    : ID EQ ID PLUS ID SC
        ;

%%

void yyerror(const char *s) {
    printf("❌ Syntax Error: %s\n", s);
}

int main() {
    printf("Enter a FOR loop statement:\n");
    yyparse();
    return 0;
}

