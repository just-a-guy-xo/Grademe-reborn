#include <stdio.h>
#include <stdlib.h>

char	*ft_strjoin(int size, char **strs, char *sep);

int	main(int argc, char **argv)
{
	char	*result;
	char	*separator;

	separator = "";
	if (argc >= 2)
		separator = argv[1];
	if (argc <= 2)
		result = ft_strjoin(0, NULL, separator);
	else
		result = ft_strjoin(argc - 2, argv + 2, separator);
	if (!result)
	{
		printf("NULL\n");
		return (0);
	}
	printf("%s\n", result);
	free(result);
	return (0);
}
