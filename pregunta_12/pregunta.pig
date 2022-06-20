/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

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

filtered_db = FILTER persons_db BY STARTSWITH(LOWER(lastname),'d') OR
     STARTSWITH(LOWER(lastname),'e') OR
     STARTSWITH(LOWER(lastname),'f') OR
     STARTSWITH(LOWER(lastname),'g') OR
     STARTSWITH(LOWER(lastname),'h') OR
     STARTSWITH(LOWER(lastname),'i') OR
     STARTSWITH(LOWER(lastname),'j') OR
     STARTSWITH(LOWER(lastname),'k');

lastname_db = FOREACH filtered_db GENERATE lastname;

STORE lastname_db INTO 'output/' USING PigStorage(',');