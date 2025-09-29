FILE='ft_split_whitespaces.c'
ASSIGN='ft_split_whitespaces'

bash .system/auto_correc_main.sh $FILE $ASSIGN
if [ -e .system/grading/traceback ]; then
    mv .system/grading/traceback .
    exit 1
fi

bash .system/auto_correc_main.sh $FILE $ASSIGN "Hello world"
if [ -e .system/grading/traceback ]; then
    mv .system/grading/traceback .
    exit 1
fi

INPUT=$(printf '  multiple\twords  here   ')
bash .system/auto_correc_main.sh $FILE $ASSIGN "$INPUT"
if [ -e .system/grading/traceback ]; then
    mv .system/grading/traceback .
    exit 1
fi

INPUT2=$(printf '\n\tSpacing\nTest\t')
bash .system/auto_correc_main.sh $FILE $ASSIGN "$INPUT2"
if [ -e .system/grading/traceback ]; then
    mv .system/grading/traceback .
    exit 1
fi

touch .system/grading/passed
