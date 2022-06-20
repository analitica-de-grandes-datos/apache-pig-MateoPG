/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
letters_db = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letters:chararray,
                dict_letters:BAG{dict:TUPLE(letter:chararray)},
                letters_list:MAP[]
        );

letters_second_col = FOREACH letters_db GENERATE FLATTEN(dict_letters) AS ind_letter;

letters_grouped = GROUP letters_second_col BY ind_letter;

letters_count = FOREACH letters_grouped GENERATE group, COUNT(letters_second_col);

STORE letters_count INTO 'output/' USING PigStorage(',');
