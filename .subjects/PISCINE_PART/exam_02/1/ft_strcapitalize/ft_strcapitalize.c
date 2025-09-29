/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcapitalize.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <exam@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/27 00:00:00 by exam              #+#    #+#             */
/*   Updated: 2025/09/27 00:00:00 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

static int	is_alnum(char c)
{
    if (c >= '0' && c <= '9')
        return (1);
    if (c >= 'a' && c <= 'z')
        return (1);
    if (c >= 'A' && c <= 'Z')
        return (1);
    return (0);
}

static char	to_lower(char c)
{
    if (c >= 'A' && c <= 'Z')
        return (c - 'A' + 'a');
    return (c);
}

static char	to_upper(char c)
{
    if (c >= 'a' && c <= 'z')
        return (c - 'a' + 'A');
    return (c);
}

char	*ft_strcapitalize(char *str)
{
    int i;
    int new_word;

    i = 0;
    new_word = 1;
    while (str[i])
    {
        if (is_alnum(str[i]))
        {
            if (new_word)
                str[i] = to_upper(str[i]);
            else
                str[i] = to_lower(str[i]);
            new_word = 0;
        }
        else
            new_word = 1;
        i++;
    }
    return (str);
}
