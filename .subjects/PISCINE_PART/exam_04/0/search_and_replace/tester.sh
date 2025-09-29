#!/bin/bash
FILE='search_and_replace.c'
ASSIGN='search_and_replace/search_and_replace.c'

cd .system/grading || exit 1
cat > search_and_replace.c << 'EOF'
#include <unistd.h>
int main(int ac, char **av){
    if (ac!=4 || !av[2][0] || !av[3][0] || av[2][1]||av[3][1]){ write(1,"\n",1); return 0; }
    for (int i=0; av[1][i]; i++){
        char c=av[1][i]; if (c==av[2][0]) c=av[3][0]; write(1,&c,1);
    }
    write(1,"\n",1); return 0;
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source "foobar" "o" "a" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "foobar" "o" "a" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
idx=0
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source "hello" "l" "x" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "hello" "l" "x" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE 2>>traceback
./source "abc" "ab" "x" | cat -e > sourcexam  # invalid args -> newline
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "abc" "ab" "x" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true