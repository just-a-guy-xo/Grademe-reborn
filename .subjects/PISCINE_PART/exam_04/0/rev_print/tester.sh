#!/bin/bash
FILE='rev_print.c'
ASSIGN='rev_print/rev_print.c'

cd .system/grading || exit 1
cat > rev_print.c << 'EOF'
#include <unistd.h>
int main(int ac, char **av){
    if (ac < 2){ write(1, "\n", 1); return 0; }
    int i=0; while(av[1][i]) i++;
    while(i>0){ char c=av[1][--i]; write(1,&c,1);} write(1,"\n",1);
    return 0;
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source "abc" | cat -e > sourcexam
rm -f source

cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "abc" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final

cd ../.system/grading || exit 1
idx=0
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi
rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source "Hello 42!" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "Hello 42!" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi
rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi
rm -f finalexam sourcexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true