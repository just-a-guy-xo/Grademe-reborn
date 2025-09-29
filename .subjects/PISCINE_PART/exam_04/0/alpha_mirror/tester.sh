#!/bin/bash
FILE='alpha_mirror.c'
ASSIGN='alpha_mirror/alpha_mirror.c'

cd .system/grading || exit 1
cat > alpha_mirror.c << 'EOF'
#include <unistd.h>
int main(int ac, char **av){
    if (ac<2){ write(1,"\n",1); return 0; }
    for (int i=1; i<ac; i++){
        for (int j=0; av[i][j]; j++){
            char c=av[i][j];
            if (c>='a'&&c<='z') c = 'z' - (c - 'a');
            else if (c>='A'&&c<='Z') c = 'Z' - (c - 'A');
            write(1,&c,1);
        }
        if (i+1<ac) write(1," ",1);
    }
    write(1,"\n",1); return 0;
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source "abc XYZ!" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final "abc XYZ!" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
idx=0
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