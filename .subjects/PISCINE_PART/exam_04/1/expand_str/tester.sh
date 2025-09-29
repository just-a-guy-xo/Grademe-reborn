#!/bin/bash
FILE='expand_str.c'
ASSIGN='expand_str/expand_str.c'

cd .system/grading || exit 1
cat > expand_str.c << 'EOF'
#include <unistd.h>

static void put_space(int *first)
{
    if (*first)
    {
        *first = 0;
        return;
    }
    write(1, " ", 1);
}

int main(int ac, char **av)
{
    int i;
    int first;

    if (ac != 2)
    {
        write(1, "\n", 1);
        return (0);
    }
    i = 0;
    first = 1;
    while (av[1][i])
    {
        while (av[1][i] == ' ' || av[1][i] == '\t')
            i++;
        if (!av[1][i])
            break;
        put_space(&first);
        while (av[1][i] && av[1][i] != ' ' && av[1][i] != '\t')
            write(1, &av[1][i++], 1);
    }
    write(1, "\n", 1);
    return (0);
}
EOF

gcc -Wall -Wextra -Werror -o source $FILE 2>traceback

cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback || exit 1

cd ../.system/grading || exit 1

idx=0

run_test() {
    local label="$1"
    shift
    ./source "$@" | cat -e > sourcexam
    ./final "$@" | cat -e > finalexam
    if ! diff -u sourcexam finalexam >/dev/null; then
        idx=$((idx + 1))
        {
            echo "----------------8<-------------[ START TEST $label ]"
            printf "   🔎 INPUT: %s\n" "$*"
            printf "   🗝 EXPECTED:\n"; cat sourcexam
            printf "   ❌ YOUR OUTPUT:\n"; cat finalexam
            echo "----------------8<------------- END TEST ]"
        } >> traceback
    fi
    rm -f sourcexam finalexam
}

run_test "spaces" $'  this\t\t is   Sparta  '
run_test "single_word" "hello"
run_test "no_arg"

if [ $idx -eq 0 ]; then
    touch passed
fi

rm -f source
rm -f final

mv traceback ../../traceback 2>/dev/null || true