#include <unistd.h>

static int	base_length(char *base)
{
	int	len;

	len = 0;
	while (base[len])
		len++;
	return (len);
}

static int	is_valid_base(char *base)
{
	int	i;
	int	j;
	int	len;

	if (!base)
		return (0);
	len = base_length(base);
	if (len < 2)
		return (0);
	i = 0;
	while (i < len)
	{
		if (base[i] == '+' || base[i] == '-')
			return (0);
		j = i + 1;
		while (j < len)
		{
			if (base[i] == base[j])
				return (0);
			j++;
		}
		i++;
	}
	return (1);
}

static void	putnbr_recursive(long nb, char *base, int len)
{
	char	c;

	if (nb >= len)
		putnbr_recursive(nb / len, base, len);
	c = base[nb % len];
	write(1, &c, 1);
}

void	ft_putnbr_base(int nbr, char *base)
{
	long	lnbr;
	int		len;

	if (!is_valid_base(base))
		return ;
	len = base_length(base);
	lnbr = nbr;
	if (lnbr < 0)
	{
		write(1, "-", 1);
		lnbr = -lnbr;
	}
	putnbr_recursive(lnbr, base, len);
}
