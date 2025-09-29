#include <stdlib.h>

static int	is_whitespace(char c)
{
	return (c == ' ' || c == '\t' || c == '\n');
}

static int	count_words(char *str)
{
	int	count;
	int	i;

	count = 0;
	i = 0;
	while (str[i])
	{
		while (str[i] && is_whitespace(str[i]))
			i++;
		if (str[i])
		{
			count++;
			while (str[i] && !is_whitespace(str[i]))
				i++;
		}
	}
	return (count);
}

static char	*dup_word(char *start, int len)
{
	char	*word;
	int		i;

	word = (char *)malloc(sizeof(char) * (len + 1));
	if (!word)
		return (NULL);
	i = 0;
	while (i < len)
	{
		word[i] = start[i];
		i++;
	}
	word[i] = '\0';
	return (word);
}

static void	free_words(char **words, int upto)
{
	int		k;

	k = 0;
	while (k < upto)
	{
		free(words[k]);
		k++;
	}
	free(words);
}

char	**ft_split_whitespaces(char *str)
{
	char	**result;
	int		word_count;
	int		index;
	int		i;
	int		len;

	if (!str)
		return (NULL);
	word_count = count_words(str);
	result = (char **)malloc(sizeof(char *) * (word_count + 1));
	if (!result)
		return (NULL);
	i = 0;
	index = 0;
	while (str[i])
	{
		while (str[i] && is_whitespace(str[i]))
			i++;
		if (!str[i])
			break ;
		len = 0;
		while (str[i + len] && !is_whitespace(str[i + len]))
			len++;
		result[index] = dup_word(str + i, len);
		if (!result[index])
		{
			free_words(result, index);
			return (NULL);
		}
		index++;
		i += len;
	}
	result[index] = NULL;
	return (result);
}
