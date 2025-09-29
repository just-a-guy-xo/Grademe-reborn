#include <stdlib.h>
#include <stdio.h>

void	ft_div_mod(int a, int b, int *div, int *mod);

int	main(int argc, char **argv)
{
	int	div;
	int	mod;

	if (argc != 3)
		return (0);
	ft_div_mod(atoi(argv[1]), atoi(argv[2]), &div, &mod);
	printf("%d %d", div, mod);
	return (0);
}
