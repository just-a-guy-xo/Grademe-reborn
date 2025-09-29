#!/bin/bash
FILE='ft_sort_params.c'
ASSIGN='ft_sort_params/ft_sort_params.c'

cd .system/grading || exit 1
cat > ref_ft_sort_params.c <<'EOF'
#include <unistd.h>

static int	ft_strcmp(char *s1, char *s2)
{
    while (*s1 && *s1 == *s2)
    {
        s1++;
        s2++;
    }
    return ((unsigned char)*s1 - (unsigned char)*s2);
}

static void	ft_putstr(char *s)
{
    while (*s)
        write(1, s++, 1);
    write(1, "\n", 1);
}

int	main(int ac, char **av)
{
    int i;
    int sorted;

    if (ac <= 1)
        return (0);
    sorted = 0;
    while (!sorted)
    {
        sorted = 1;
        i = 1;
        while (i + 1 < ac)
        {
            if (ft_strcmp(av[i], av[i + 1]) > 0)
            {
                char *tmp = av[i];
                av[i] = av[i + 1];
                av[i + 1] = tmp;
                sorted = 0;
            }
            i++;
        }
    }
    i = 1;
    while (i < ac)
        ft_putstr(av[i++]);
    return (0);
}
EOF

gcc -Wall -Wextra -Werror -o source ref_ft_sort_params.c 2>traceback || exit 1

cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN 2>>../.system/grading/traceback
if [ ! -f final ]; then
    exit 1
fi
mv final ../.system/grading/

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
            printf "   INPUT: %s\n" "$*"
            printf "   EXPECTED:\n"; cat sourcexam
            printf "   YOUR OUTPUT:\n"; cat finalexam
            echo "----------------8<------------- END TEST ]"
        } >> traceback
    fi
    rm -f sourcexam finalexam
}

run_test "basic" "banana" "apple" "cherry"
run_test "duplicates" "b" "a" "a"
run_test "single" "alone"
run_test "empty"

if [ $idx -eq 0 ]; then
    touch passed
fi

rm -f source ref_ft_sort_params.c final
mv traceback ../../traceback 2>/dev/null || true
