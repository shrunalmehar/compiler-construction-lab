%{
#include <stdio.h>
#include <string.h>

int comment = 0, keywords = 0, identifiers = 0, words = 0, lines = 0, space = 0;

char *keyword[] = {
    "int", "float", "char", "double", "if", "else", "for", "while", "return", "void", "main", NULL
};

int is_keyword(char *word) {
    int i = 0;
    while (keyword[i] != NULL) {
        if (strcmp(word, keyword[i]) == 0)
            return 1;
        i++;
    }
    return 0;
}
%}

%%
\n                { lines++; }
[ \t]+            { space++; }
"//".*            { comment++; }
"/*"([^*]|\*+[^/])*"*"+"/"    { comment++; }
[a-zA-Z_][a-zA-Z0-9_]* {
                    words++;
                    if (is_keyword(yytext))
                        keywords++;
                    else
                        identifiers++;
                  }
.                 ; // Ignore other characters
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter input (Ctrl+D to end):\n");
    yylex();
    printf("\n--- Token Summary ---\n");
    printf("Words: %d\n", words);
    printf("Lines: %d\n", lines);
    printf("Spaces: %d\n", space);
    printf("Comments: %d\n", comment);
    printf("Keywords: %d\n", keywords);
    printf("Identifiers: %d\n", identifiers);
    return 0;
}


