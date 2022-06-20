/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

dates_db = FOREACH persons_db GENERATE ToString(data,'yyyy-MM-dd') AS Date
                                        ,ToString(data,'dd') AS TwodigitDay
                                        ,GetDay(data) AS Day
                                        ,LOWER(ToString(data,'EEEEE')) AS StringweekDay
                                        ;

corrected_dates_db = FOREACH dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'monday','lunes') as StringweekDay;  
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'tuesday','martes') as StringweekDay; 
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'wednesday','miercoles') as StringweekDay;
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'thursday','jueves') as StringweekDay;
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'friday','viernes') as StringweekDay;
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'saturday','sabado') as StringweekDay;
corrected_dates_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, REPLACE(StringweekDay,'sunday','domingo') as StringweekDay;

final_date_columns_db = FOREACH corrected_dates_db GENERATE Date, TwodigitDay, Day, SUBSTRING(StringweekDay,0,3), StringweekDay;

STORE final_date_columns_db INTO 'output/' USING PigStorage(',');