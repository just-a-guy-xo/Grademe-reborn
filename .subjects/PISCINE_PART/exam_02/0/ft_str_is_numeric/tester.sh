#!/bin/bash
FILE='ft_str_is_numeric.c'
ASSIGN='ft_str_is_numeric/ft_str_is_numeric.c'

cd .system/grading || exit 1
cat > ref_ft_str_is_numeric.c <<'EOF'
#include <stdio.h>

int	ft_str_is_numeric(char *str)
{
    int i;

    if (!str)
        return (1);
    i = 0;
    if (!str[i])
        return (1);
    while (str[i])
    {
        if (str[i] < '0' || str[i] > '9')
            return (0);
        i++;
    }
    return (1);
}

static void run(char *label, int ac, char **av)
{
    (void)label;
    (void)ac;
    int i;

    if (ac < 2)
    {
        printf("%d\n", ft_str_is_numeric(""));
        return;
    }
    i = 1;
    while (i < ac)
        printf("%d\n", ft_str_is_numeric(av[i++]));
}

int main(int ac, char **av)
{
    run("ref", ac, av);
    return (0);
}
EOF

cat > main.c <<'EOF'
#include <stdio.h>

int	ft_str_is_numeric(char *str);

int main(int ac, char **av)
{
    int i;

    if (ac < 2)
    {
        printf("%d\n", ft_str_is_numeric(""));
        return (0);
    }
    i = 1;
    while (i < ac)
        printf("%d\n", ft_str_is_numeric(av[i++]));
    return (0);
}
EOF

gcc -Wall -Wextra -Werror -o source ref_ft_str_is_numeric.c 2>traceback || exit 1

cd ../../rendu || exit 1
gcc -Wall -Wextra -Werror -o final $ASSIGN ../.system/grading/main.c 2>>../.system/grading/traceback
if [ ! -f final ]; then
    exit 1
fi
mv final ../.system/grading/

cd ../.system/grading || exit 1

rm -f main.c

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

run_test "digits" "0123456789"
run_test "alpha" "fortytwo"
run_test "mix" "123abc456"
run_test "empty"
run_test "leading_plus" "+123"

if [ $idx -eq 0 ]; then
    touch passed
fi

rm -f source ref_ft_str_is_numeric.c final
mv traceback ../../traceback 2>/dev/null || true
