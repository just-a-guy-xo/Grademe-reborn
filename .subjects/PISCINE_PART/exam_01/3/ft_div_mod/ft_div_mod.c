void	ft_div_mod(int a, int b, int *div, int *mod)
{
	if (b == 0)
	{
		if (div)
			*div = 0;
		if (mod)
			*mod = 0;
		return ;
	}
	if (div)
		*div = a / b;
	if (mod)
		*mod = a % b;
}
