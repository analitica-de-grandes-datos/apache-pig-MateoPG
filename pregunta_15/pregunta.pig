/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

persons_db = LOAD 'data.csv' USING PigStorage(',')
    AS (
      rank:int,
      name:chararray,
      lastname:chararray,
      data:datetime,
      color:chararray,
      number:int
    );

filtered_db = FILTER persons_db BY color == 'blue' AND STARTSWITH(name,'Z');

colorname_db = FOREACH filtered_db GENERATE CONCAT(name,' ',color);

STORE colorname_db INTO 'output/' USING PigStorage(',');