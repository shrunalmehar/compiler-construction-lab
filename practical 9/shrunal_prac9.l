%{
#include "y.tab.h"
%}

digit   [0-9]
id      [a-zA-Z_][a-zA-Z0-9_]*

%%

"for"               { return FOR; }
"("                 { return LP; }
")"                 { return RP; }
";"                 { return SC; }
"="                 { return EQ; }
"+"                 { return PLUS; }
"<"|"<=|>"|">="|"=="  { return RELOP; }
{id}                { return ID; }
{digit}+            { return NUM; }
[ \t\n]             ;   /* skip whitespace */
.                   { return yytext[0]; }

%%

int yywrap() { return 1; }

