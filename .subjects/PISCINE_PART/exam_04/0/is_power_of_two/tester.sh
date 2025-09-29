#!/bin/bash
FILE='is_power_of_two.c'
MAIN='main.c'
MAIN1='../.system/grading/main.c'
ASSIGN='is_power_of_two/is_power_of_two.c'

index=0

cd .system/grading || exit 1
cat > main.c << 'EOF'
#include <stdio.h>
int is_power_of_two(unsigned int n);
int main(int ac, char **av){
    if (ac < 2) return 0;
    unsigned long x = 0;
    sscanf(av[1], "%lu", &x);
    printf("%d", is_power_of_two((unsigned int)x));
    return 0;
}
EOF

cat > is_power_of_two.c << 'EOF'
int is_power_of_two(unsigned int n){
    return n && !(n & (n - 1));
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>traceback
./source "0"   | cat -e > sourcexam
rm -f source

cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "0" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1

DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then index=$((index+1)); fi
rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "1"   | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "1" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then index=$((index+1)); fi
rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "64"  | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "64" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then index=$((index+1)); fi
rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "65"  | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "65" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam)
if [ "$DIFF" != "" ]; then index=$((index+1)); fi
rm -f finalexam sourcexam

if [ $index -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true