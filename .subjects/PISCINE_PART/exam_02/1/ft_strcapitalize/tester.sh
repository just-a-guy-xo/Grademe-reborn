#!/bin/bash
FILE='ft_strcapitalize.c'
ASSIGN='ft_strcapitalize/ft_strcapitalize.c'

cd .system/grading || exit 1
cat > ref_ft_strcapitalize.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int	is_alnum(char c)
{
    if (c >= '0' && c <= '9')
        return (1);
    if (c >= 'a' && c <= 'z')
        return (1);
    if (c >= 'A' && c <= 'Z')
        return (1);
    return (0);
}

static char	to_lower(char c)
{
    if (c >= 'A' && c <= 'Z')
        return (c - 'A' + 'a');
    return (c);
}

static char	to_upper(char c)
{
    if (c >= 'a' && c <= 'z')
        return (c - 'a' + 'A');
    return (c);
}

char	*ft_strcapitalize(char *str)
{
    int i;
    int new_word;

    i = 0;
    new_word = 1;
    while (str[i])
    {
        if (is_alnum(str[i]))
        {
            if (new_word)
                str[i] = to_upper(str[i]);
            else
                str[i] = to_lower(str[i]);
            new_word = 0;
        }
        else
            new_word = 1;
        i++;
    }
    return (str);
}

static void emit(char *s)
{
    char *copy;

    copy = strdup(s);
    if (!copy)
        return;
    ft_strcapitalize(copy);
    printf("%s\n", copy);
    free(copy);
}

int main(int ac, char **av)
{
    int i;

    if (ac < 2)
    {
        printf("\n");
        return (0);
    }
    i = 1;
    while (i < ac)
        emit(av[i++]);
    return (0);
}
EOF

cat > main.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char	*ft_strcapitalize(char *str);

static void emit(char *s)
{
    char *copy;

    copy = strdup(s);
    if (!copy)
        return;
    ft_strcapitalize(copy);
    printf("%s\n", copy);
    free(copy);
}

int main(int ac, char **av)
{
    int i;

    if (ac < 2)
    {
        printf("\n");
        return (0);
    }
    i = 1;
    while (i < ac)
        emit(av[i++]);
    return (0);
}
EOF

gcc -Wall -Wextra -Werror -o source ref_ft_strcapitalize.c 2>traceback || exit 1

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

run_test "basic" "salut, comment tu vas ? 42mots quarante-deux; cinquante+et+un"
run_test "upper" "HELLO WORLD"
run_test "mix" "already Capitalized"
run_test "numbers" "123abc 456DEF"
run_test "empty"

if [ $idx -eq 0 ]; then
    touch passed
fi

rm -f source ref_ft_strcapitalize.c final
mv traceback ../../traceback 2>/dev/null || true
