#include <stdio.h>
#include <stdlib.h>
#include "ft_list.h"

t_list	*ft_list_push_strs(int size, char **strs)
{
	t_list	*list;
	int		i;

	list = NULL;
	i = 0;
	while (i < size)
	{
		ft_list_push_front(&list, strs[i]);
		i++;
	}
	return (list);
}

static void	free_list(t_list *list)
{
	t_list	*next;

	while (list)
	{
		next = list->next;
		free(list);
		list = next;
	}
}

int	main(int argc, char **argv)
{
	t_list	*list;
	t_list	*iter;

	if (argc <= 1)
	{
		printf("NULL\n");
		return (0);
	}
	list = ft_list_push_strs(argc - 1, argv + 1);
	iter = list;
	while (iter)
	{
		printf("%s\n", (char *)iter->data);
		iter = iter->next;
	}
	printf("NULL\n");
	free_list(list);
	return (0);
}
