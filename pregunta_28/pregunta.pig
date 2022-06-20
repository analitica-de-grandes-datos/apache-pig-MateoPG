/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       birthday, 
       DATE_FORMAT(birthday, "yyyy"),
       DATE_FORMAT(birthday, "yy"),
   FROM 
       persons
   LIMIT
       5;

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

years_db = FOREACH persons_db GENERATE SUBSTRING(data,0,4), SUBSTRING(data,2,4) ;

STORE years_db INTO 'output/' USING PigStorage(',');