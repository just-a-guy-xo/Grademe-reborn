int	ft_sqrt(int nb)
{
	long	low;
	long	high;
	long	mid;
	long	square;

	if (nb < 0)
		return (0);
	low = 0;
	high = nb;
	while (low <= high)
	{
		mid = (low + high) / 2;
		square = mid * mid;
		if (square == nb)
			return ((int)mid);
		if (square < nb)
			low = mid + 1;
		else
			high = mid - 1;
	}
	return (0);
}
