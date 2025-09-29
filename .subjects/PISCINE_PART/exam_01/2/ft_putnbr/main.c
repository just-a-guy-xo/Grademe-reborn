#include <stdlib.h>
#include <unistd.h>

void	ft_putnbr(int nb);

int	main(int argc, char **argv)
{
	if (argc == 2)
		ft_putnbr(atoi(argv[1]));
	write(1, "\n", 1);
	return (0);
}
