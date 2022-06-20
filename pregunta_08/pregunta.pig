/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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

flatten_second = FOREACH letters_db GENERATE FLATTEN(dict_letters) AS secondcol, FLATTEN(letters_list) AS thirdcol;

grouped_col = GROUP flatten_second BY (secondcol, thirdcol);

counted_col = FOREACH grouped_col GENERATE group, COUNT(flatten_second);

STORE counted_col INTO 'output/' USING PigStorage(',');