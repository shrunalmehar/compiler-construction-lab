%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
%}
%token NUMBER
%%
input:
    /* empty */
  | input line
  ;

line:
    '\n'
  | expr '\n'       { printf("= %d\n", $1); }
  | error '\n'      { 
                        printf("Syntax Error. Please try again.\n");
                        yyerrok; /* recover from error */
                    }
  ;
expr:
    NUMBER
  | expr '+' expr   { $$ = $1 + $3; }
  | expr '-' expr   { $$ = $1 - $3; }
  | expr '*' expr   { $$ = $1 * $3; }
  | expr '/' expr   { 
                        if ($3 == 0) {
                            printf("Error: Division by zero\n");
                            $$ = 0;
                        } else {
                            $$ = $1 / $3;
                        }
                    }
  | '(' expr ')'    { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Simple Desk Calculator (with Error Recovery)\n");
    printf("Type expressions or press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}

