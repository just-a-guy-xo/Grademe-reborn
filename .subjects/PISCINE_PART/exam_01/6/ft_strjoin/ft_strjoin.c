#include <stdlib.h>

static int	ft_strlen(char *str)
{
	int	len;

	len = 0;
	while (str && str[len])
		len++;
	return (len);
}

static void	append(char *dest, char *src, int *index)
{
	int	i;

	i = 0;
	while (src && src[i])
	{
		dest[*index] = src[i];
		(*index)++;
		i++;
	}
}

char	*ft_strjoin(int size, char **strs, char *sep)
{
	int		total_len;
	int		sep_len;
	char	*result;
	int		i;
	int		idx;

	sep_len = ft_strlen(sep);
	if (size <= 0)
	{
		result = (char *)malloc(sizeof(char));
		if (result)
			result[0] = '\0';
		return (result);
	}
	total_len = 0;
	i = 0;
	while (i < size)
	{
		total_len += ft_strlen(strs[i]);
		i++;
	}
	total_len += sep_len * (size - 1);
	result = (char *)malloc(sizeof(char) * (total_len + 1));
	if (!result)
		return (NULL);
	idx = 0;
	i = 0;
	while (i < size)
	{
		append(result, strs[i], &idx);
		if (i + 1 < size)
			append(result, sep, &idx);
		i++;
	}
	result[idx] = '\0';
	return (result);
}
