#!/bin/bash
FILE='print_memory2.c'
ASSIGN='print_memory2/print_memory2.c'

cd .system/grading || exit 1
cat > print_memory2.c << 'EOF'
#include <unistd.h>
#include <stddef.h>
static void hex(unsigned char c){ char *b="0123456789abcdef"; char x[2]={b[c>>4],b[c&15]}; write(1,x,2);} 
static void pad(int n){ while(n--) write(1," ",1);} 
void print_memory2(const void *addr, size_t size){
    const unsigned char *p=addr; for(size_t i=0;i<size;i+=16){
        for(size_t j=0;j<16;j++){ if (i+j<size){ hex(p[i+j]); if(j%2==1) write(1," ",1);} else { write(1,"  ",2); if(j%2==1) write(1," ",1);} }
        for(size_t j=0;j<16 && i+j<size;j++){ char c=p[i+j]; if(c<32||c>126) c='.'; write(1,&c,1);} write(1,"\n",1);
    }
}
int main(){ unsigned char buf[]={0,1,2,3,'A','B','C',0xff,'x','y','z','\n'}; print_memory2(buf,sizeof(buf)); return 0; }
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback
./source | cat -e > sourcexam
rm -f source
cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
./final | cat -e > finalexam
mv finalexam ../.system/grading/
rm -f final
cd ../.system/grading || exit 1
DIFF=$(diff sourcexam finalexam); idx=0; if [ "$DIFF" != "" ]; then idx=$((idx+1)); fi; rm -f sourcexam finalexam

if [ $idx -eq 0 ]; then touch passed; fi
mv traceback ../../traceback 2>/dev/null || true