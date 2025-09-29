#include <stdio.h>

int	ft_str_is_numeric(char *str);

int main(int argc, char **argv)
{
    int i;

    if (argc < 2)
    {
        printf("%d\n", ft_str_is_numeric(""));
        return (0);
    }
    i = 1;
    while (i < argc)
    {
        printf("%d\n", ft_str_is_numeric(argv[i]));
        i++;
    }
    return (0);
}
