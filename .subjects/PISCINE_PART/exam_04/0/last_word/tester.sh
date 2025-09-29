#!/bin/bash
FILE='last_word.c'
ASSIGN='last_word/last_word.c'

cd .system/grading || exit 1
cat > last_word.c << 'EOF'
#include <unistd.h>
int main(int ac, char **av){
    if (ac != 2){ write(1, "\n",1); return 0; }
    char *s=av[1]; int i=0; while(s[i]) i++; if (i==0){write(1,"\n",1);return 0;}
    i--; while(i>=0 && (s[i]==' '||s[i]=='\t')) i--; int end=i; while(i>=0 && s[i]!=' '&& s[i]!='\t') i--; int start=i+1;
    for(int j=start;j<=end;j++) write(1,&s[j],1); write(1,"\n",1); return 0;
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source "  hello world  " | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "  hello world  " | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
idx=0
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source $'\tfoo\tbar' | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final $'\tfoo\tbar' | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true