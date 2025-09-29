FILE='ft_print_reverse_alphabet.c'
ASSIGN='ft_print_reverse_alphabet'

bash .system/auto_correc_main.sh $FILE $ASSIGN
if [ -e .system/grading/traceback ]; then
    mv .system/grading/traceback .
    exit 1
fi

touch .system/grading/passed
