#include <stdio.h>
#include <stdlib.h>

char	**ft_split_whitespaces(char *str);

static void	free_words(char **words)
{
	int		k;

	if (!words)
		return ;
	k = 0;
	while (words[k])
	{
		free(words[k]);
		k++;
	}
	free(words);
}

int	main(int argc, char **argv)
{
	char	**words;
	int		i;

	if (argc < 2)
	{
		words = ft_split_whitespaces("");
	}
	else
		words = ft_split_whitespaces(argv[1]);
	if (!words)
	{
		printf("NULL\n");
		return (0);
	}
	i = 0;
	while (words[i])
	{
		printf("%s\n", words[i]);
		i++;
	}
	printf("NULL\n");
	free_words(words);
	return (0);
}
