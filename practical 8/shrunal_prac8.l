%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+              { yylval = atoi(yytext); return NUMBER; }
[ \t]+              ; /* Ignore spaces/tabs */
\n                  return '\n';
.                   return yytext[0];  /* Return single characters like + - * / ( ) */
%%

int yywrap(void) { return 1; }

