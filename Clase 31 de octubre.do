*Analis econometrico 
*31 de agosto del 2021 
* Base de datos 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Base de datos series de tiempo.xlsx", sheet("Hoja1") firstrow


generate AÑO1 = date(AÑO,"DMY")
tsset AÑO1, daily


tsset AÑO

tsline PIB
