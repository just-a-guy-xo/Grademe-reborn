#include <stdlib.h>
#include <unistd.h>

void	ft_putnbr_base(int nbr, char *base);

int	main(int argc, char **argv)
{
	if (argc != 3)
	{
		write(1, "\n", 1);
		return (0);
	}
	ft_putnbr_base(atoi(argv[1]), argv[2]);
	write(1, "\n", 1);
	return (0);
}
