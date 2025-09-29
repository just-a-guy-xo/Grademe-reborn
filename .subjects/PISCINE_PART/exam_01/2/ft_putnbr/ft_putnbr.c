#include <unistd.h>

static void	write_digit(int n)
{
	char	c;

	c = '0' + n;
	write(1, &c, 1);
}

void	ft_putnbr(int nb)
{
	long	n;

	n = nb;
	if (n < 0)
	{
		write(1, "-", 1);
		n = -n;
	}
	if (n >= 10)
		ft_putnbr(n / 10);
	write_digit(n % 10);
}
