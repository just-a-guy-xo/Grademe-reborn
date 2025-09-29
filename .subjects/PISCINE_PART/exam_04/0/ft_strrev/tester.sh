#!/bin/bash
FILE='ft_strrev.c'
MAIN='main.c'
MAIN1='../.system/grading/main.c'
ASSIGN='ft_strrev/ft_strrev.c'

cd .system/grading || exit 1
cat > main.c << 'EOF'
#include <stdio.h>
char *ft_strrev(char *s);
int main(int ac, char **av){
    if (ac<2){return 0;}
    char buf[1024];
    snprintf(buf,sizeof(buf),"%s",av[1]);
    printf("%s", ft_strrev(buf));
    return 0;
}
EOF

cat > ft_strrev.c << 'EOF'
char *ft_strrev(char *s){
    int i=0,j=0; while(s[j]) j++; if (j) j--; while(i<j){ char t=s[i]; s[i]=s[j]; s[j]=t; i++; j--; } return s;
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>traceback
./source "abcdef" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "abcdef" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
idx=0
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "a" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "a" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f finalexam sourcexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true