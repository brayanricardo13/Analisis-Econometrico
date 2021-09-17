*analisis econometrico modelos con restricion 
import delimited "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Datos históricos EC.csv", varnames(1) encoding(UTF-8) parselocale(es_CO)

*Declarar la variable como serie de tiempo 
tsset fecha,daily
tsline último
