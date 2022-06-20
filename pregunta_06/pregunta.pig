/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

colum_flatten = FOREACH letters_db GENERATE FLATTEN(letters_list) AS flatten_col;

colum_separated = FOREACH colum_flatten GENERATE REPLACE(flatten_col,',',' ') AS key_val;

column_grouped = GROUP colum_separated BY key_val;

column_count = FOREACH column_grouped GENERATE group, COUNT(colum_separated);

STORE column_count INTO 'output/' USING PigStorage(',');
