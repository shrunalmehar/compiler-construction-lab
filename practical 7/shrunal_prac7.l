%{
#include "y.tab.h"
%}

%%

[0-9]+              { yylval = atoi(yytext); return NUMBER; }
[ \t]+              ;   /* ignore spaces/tabs */
\n                  return '\n';
.                   return yytext[0];

%%

