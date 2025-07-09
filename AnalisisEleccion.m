%% limpia variables y pantalla
%clear;
%clc;

%% Definir que espacio acad�mico y sector se analizar�

%EspacioAcademico = 1;
% Sector = 3;

% Sector 1 Alumnos, 2 Profesores, 3 Administrativos

% Espacio Academico
% 1	Cuauhtemoc
% 2	Angel Garibay
% 3	Pablo Gonz�lez
% 4	Ignacio Ram�rez
% 5	Isidro Fabela
% 6	Adolfo L�pez
% 7	Ignacio Pichardo
% 8	Nezahualcoyotl
% 9	Sor Juana
% 10	Texcoco
% 11	Escuela Artes
% 12	F. Antropolog�a
% 13	F. Arquitectura y D
% 14	F. Artes
% 15	F. Ciencias
% 16	F. Ciencias Agricolas
% 17	F. Ciencias Conducta
% 18	F. Ciencias Pol�ticas
% 19	F. Contadur�a y Adm
% 20	F. Derecho
% 21	F. Econom�a
% 22	F. Enfermer�a
% 23	F. Geograf�a
% 24	F. Humanidades
% 25	F. Ingenier�a
% 26	F. Lenguas
% 27	F. Medicina
% 28	F. Medicina Veterinaria
% 29	F. Odontolog�a
% 30	F. Planeaci�n Urbana
% 31	F. Qu�mica
% 32	F. Turismo
% 33	CU Amecameca
% 34	CU Atlacomulco
% 35	CU Ecatepec
% 36	CU Nezahualcoyotl
% 37	CU Temascaltepec
% 38	CU Tenancingo
% 39	CU Texcoco
% 40	CU Valle de Chalco
% 41	CU Valle de M�xico
% 42	CU Teotihuacan
% 43	CU Zumpango
% 44	UAP Acolman
% 45	UAP Chimalhuacan
% 46	UAP Cuautitl�n Izcalli
% 47	UAP Huehuetoca
% 48	UAP Tejupilco
% 49	UAP Tianguistenco
% 50	UAP Tlalnepantla
% 51	Instituto Ciencias Agr�colas
% 52	Instituto Estudios Universidad
% 53	Instituto Ciencias del Agua
% 54	Administraci�n Central


%% Carga el archivo con los resultados simulados de la votacion de los tres sectores
load('ResultadosConcentrados')

% switch Sector
%     case '1'
%     TextoSector = "Alumnos";
%     case '2'
%     TextoSector = "Profesores";
%     otherwise
%     TextoSector = "Administrativos";
% end

%% Calcula el porcentaje con el que fue favorecido cada aspirante en los espacios academicos

Suma_por_fila = sum(Votos_por_espacio, 2);
Porcentajes = Votos_por_espacio ./ repmat(Suma_por_fila, 1, size(Votos_por_espacio, 2)) * 100;
    
%% Genera una grafica de barras con los resultados del sector y los compara con los generales

graficarVotosPorEspacio(Espacios, Votos_por_espacio, Ganadores)    

%% Resultados por aspirante, espacios ganados

for ii=1:size(Votos_por_espacio,2);
 VotosAspiranteGanador(ii) = sum(count(Ganadores, "A" + (ii)));
end

%% Resultados por votos totales ganados por sector

Total_de_Votos_finales=sum(Votos_por_espacio, 1);


%% Gr�fica los resultados finales

graficarComparativaAspirantes(VotosAspiranteGanador, Total_de_Votos_finales)