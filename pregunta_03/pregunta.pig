/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
letters_db =  LOAD 'data.tsv' USING PigStorage('\t')
    AS (
        letter:chararray,
        date:chararray,
        number:int            
    );

letters_ordered = ORDER letters_db BY number asc;

third_column = FOREACH letters_ordered GENERATE number;

third_filtered = LIMIT third_column 5;

STORE third_filtered INTO 'output/' USING PigStorage(',');