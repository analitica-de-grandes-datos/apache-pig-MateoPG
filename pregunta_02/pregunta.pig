/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

letters_db = LOAD 'data.tsv' USING PigStorage('\t')
     AS (
          letter:chararray,
          date:chararray,
          number:int
     );

letters_ordered = ORDER letters_db BY letter asc, number asc;

STORE letters_ordered INTO 'output/' USING PigStorage(',');