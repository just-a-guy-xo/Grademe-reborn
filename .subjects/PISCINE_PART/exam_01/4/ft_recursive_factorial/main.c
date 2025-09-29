#include <stdlib.h>
#include <stdio.h>

int	ft_recursive_factorial(int nb);

int	main(int argc, char **argv)
{
	int	value;

	if (argc != 2)
		return (0);
	value = ft_recursive_factorial(atoi(argv[1]));
	printf("%d", value);
	return (0);
}
