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
   WHERE 
       color REGEXP '[aeiou]$';

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
      data:datetime,
      color:chararray,
      number:int
    );

filtered_db = FILTER persons_db BY ENDSWITH(color ,'a') OR
           ENDSWITH(color ,'e') OR
           ENDSWITH(color ,'i') OR
           ENDSWITH(color ,'o') OR
           ENDSWITH(color ,'u') ;

colorname_db = FOREACH filtered_db GENERATE name, color;

STORE colorname_db INTO 'output/' USING PigStorage(',');