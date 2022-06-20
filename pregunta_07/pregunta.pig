/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
letters_db = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letters:chararray,
                dict_letters:chararray,
                letters_list:chararray
        );

organized_db = FOREACH letters_db GENERATE letters, TOKENIZE(dict_letters,',') AS secondcol, TOKENIZE(letters_list,',') AS thirdcol;

counted_db = FOREACH organized_db GENERATE letters, COUNT(secondcol) AS second, COUNT(thirdcol) AS third;

ordered_db = ORDER counted_db BY letters asc, second asc, third asc;

STORE ordered_db INTO 'output/' USING PigStorage(',');