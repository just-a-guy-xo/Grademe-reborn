#!/bin/bash
FILE='ft_itoa.c'
MAIN='main.c'
ASSIGN='ft_itoa/ft_itoa.c'

cd .system/grading || exit 1
cat > main.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char *ft_itoa(int n);
int main(int ac, char **av){ if(ac<2) return 0; int n=atoi(av[1]); char *s=ft_itoa(n); if(!s) return 0; printf("%s", s); free(s); return 0; }
EOF

cat > ft_itoa.c << 'EOF'
#include <stdlib.h>
static int len(long n){ int l=(n<=0); while(n){ l++; n/=10;} return l; }
char *ft_itoa(int n){ long x=n; int l=len(x); char *s=malloc(l+1); if(!s) return 0; s[l]='\0'; if(x==0) s[0]='0'; if(x<0){ s[0]='-'; x=-x; } while(x){ s[--l]= '0' + (x%10); x/=10; } return s; }
EOF

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>traceback
./source "0" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "0" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); idx=0; if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f sourcexam finalexam

gcc -Wall -Wextra -Werror -o source $FILE $MAIN 2>>traceback
./source "-2147483648" | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
./final "-2147483648" | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f sourcexam finalexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true