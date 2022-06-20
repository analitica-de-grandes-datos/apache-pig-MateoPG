/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT  
       firstname,
       SUBSTRING_INDEX(firstname, 'a', 1)
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

persons_db = LOAD 'data.csv' USING PigStorage(',')
    AS (
      rank:int,
      name:chararray,
      lastname:chararray,
      data:chararray,
      color:chararray,
      number:int
    );

a_position_db = FOREACH persons_db GENERATE INDEXOF(name,'a');

STORE a_position_db INTO 'output/' USING PigStorage(',');