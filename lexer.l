%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
do[' ']you[' ']have[' ']tetris { return TETRIS; }
what[' ']animations[' ']do[' ']you[' ']have { return ANIMATION; }
cube            { return CUBE; }
coffin          { return COFFIN; }
diamonds        { return DIAMONDS; }
yes             { return YES; }
no              { return NO; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}