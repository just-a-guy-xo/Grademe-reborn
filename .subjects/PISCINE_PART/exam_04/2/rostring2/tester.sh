#!/bin/bash
FILE='rostring2.c'
ASSIGN='rostring2/rostring2.c'

cd .system/grading || exit 1
cat > rostring2.c << 'EOF'
#include <unistd.h>
static int issp(char c){ return c==' '||c=='\t'; }
int main(int ac, char **av){ if (ac<2){write(1,"\n",1); return 0;} char *s=av[1]; int i=0; while(issp(s[i])) i++; int a=i; while(s[i] && !issp(s[i])) i++; int b=i; while(issp(s[i])) i++; int w=0; while(s[i]){ if(!issp(s[i])){ w=1; write(1,&s[i],1);} else { while(issp(s[i])) i++; if(s[i]) write(1," ",1); continue;} i++; } if (w && a<b) write(1," ",1); for(int k=a;k<b;k++) write(1,&s[k],1); write(1,"\n",1); return 0; }
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source $'  first\tsecond  third ' | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final $'  first\tsecond  third ' | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); idx=0; if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f sourcexam finalexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true