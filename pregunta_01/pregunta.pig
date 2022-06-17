/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

letters_db = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letter:chararray,
            date:chararray,
            number:int
    );

grouped = GROUP letters_db BY letter;

lettercount = FOREACH grouped GENERATE group, COUNT(letters_db);

STORE lettercount INTO 'output/' USING PigStorage(',');

