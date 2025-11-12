%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int choice;    // 1-upper, 2-lower, 3-title
int start = 1; // for title case
%}

%%
.  {
    char c = yytext[0];
    if(choice == 1) {               // lowercase → uppercase
        putchar(toupper(c));
    } 
    else if(choice == 2) {          // uppercase → lowercase
        putchar(tolower(c));
    } 
    else if(choice == 3) {          // Title case
        if(isalpha(c)) {
            if(start) {
                putchar(toupper(c));
                start = 0;
            } else {
                putchar(tolower(c));
            }
        } else {
            putchar(c);
            if(c == ' ' || c == '\n' || c == '\t')
                start = 1;
        }
    }
}
\n  { putchar('\n'); }
%%

int yywrap(void){ return 1; }

int main() {
    printf("Choose conversion:\n");
    printf("1. Lowercase → Uppercase\n");
    printf("2. Uppercase → Lowercase\n");
    printf("3. Title Case\n");
    printf("Enter your choice: ");
    scanf("%d", &choice);
    printf("Enter text (Ctrl+D to end):\n");
    yylex();
    return 0;
}
