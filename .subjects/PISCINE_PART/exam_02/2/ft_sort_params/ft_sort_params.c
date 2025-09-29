/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort_params.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <exam@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/27 00:00:00 by exam              #+#    #+#             */
/*   Updated: 2025/09/27 00:00:00 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

static int	ft_strcmp(char *s1, char *s2)
{
    while (*s1 && *s1 == *s2)
    {
        s1++;
        s2++;
    }
    return ((unsigned char)*s1 - (unsigned char)*s2);
}

static void	ft_putstr(char *s)
{
    while (*s)
        write(1, s++, 1);
    write(1, "\n", 1);
}

int	main(int ac, char **av)
{
    int i;
    int sorted;

    if (ac <= 1)
        return (0);
    sorted = 0;
    while (!sorted)
    {
        sorted = 1;
        i = 1;
        while (i + 1 < ac)
        {
            if (ft_strcmp(av[i], av[i + 1]) > 0)
            {
                char *tmp = av[i];
                av[i] = av[i + 1];
                av[i + 1] = tmp;
                sorted = 0;
            }
            i++;
        }
    }
    i = 1;
    while (i < ac)
        ft_putstr(av[i++]);
    return (0);
}
