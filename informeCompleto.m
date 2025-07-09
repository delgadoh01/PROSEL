%% Informe de Simulación de Elección de Rector 2025
% Este informe contiene la salida de todas las rutinas relevantes.

%% 1. Simulación: Alumnos
%clear all;
%clc; 
tic;

% Definicion inicial de los bloques
bloques = {
     1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];      % Preparatoria
     1, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];      % Facultades
     1, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43];              % Centros Universitarios
     1, [44, 45, 46, 47, 48, 49, 50];      % Unidades Académicas
     1, [51, 52, 53];              % Institutos
     1, [54];      % Administración central
  };

% Define si habra preferidos para cada aspirtante por sector o por bloques de cada sector
% Preferidos = 0; % Hay favoritos por bloque
% Preferidos = 1; % Hay favoritos por aspirtante (porcentajes)
% Preferidos = 2; % Piso parejo

% Evaluación de las matrices fuertes y bloque
 
if all(fuertes(:) == 1) && all(bloque(:) == 1)
    Preferidos = 2;
elseif all(bloque(:) == 1)
    Preferidos = 1;
elseif all(fuertes(:) == 1)
    Preferidos = 0;
else
    Preferidos = 3; % Ninguna condición se cumple
end

Texto_encabezados = 'Alumnos';
%orden_favoritismo = [5 4 3 2 1]; 
% orden_favoritismo = [ ];
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
        favoritos=[favoritos1,fuertes(:,1)]; % Genera la matriz de preferencia 
        

% Bloques definidos por el usuario para Alumnos
if length(unique(bloque(:,1))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,1));
end

%  bloques = {
% %      1, [ ];
% %      2, [ ];
%      1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];      % Preparatoria
%      5, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];      % Facultades
%      5, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43];              % Centros Universitarios
%      1, [44, 45, 46, 47, 48, 49, 50];      % Unidades Académicas
%      5, [51, 52, 53];              % Institutos
%      5, [54];      % Administración central
%  };

% % Nombre del archivo fuente
%     archivoScript = 'SimulacionRector2025_9Jun25.m';
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
%     % Publicar en PDF
%     opciones = struct();
%     opciones.format = 'pdf';
%     opciones.outputDir = carpetaSalida;
%     opciones.showCode = false;
%     opciones.evalCode = true;
%     opciones.useNewFigure = true;
% 
%     % Ejecutar publish
%     archivoGenerado = publish(archivoScript, opciones);
% 
%     % Renombrar el archivo PDF
%     nombreNuevo = fullfile(carpetaSalida, 'SimulacionAlumnos_1.pdf');
%     movefile(archivoGenerado, nombreNuevo, 'f');
% 
%     disp(['Informe generado como: ' nombreNuevo]);


% Ruta del archivo script
archivoScript = 'SimulacionRector2025_9Jun25.m';

% Carpeta donde guardar el PDF
carpetaSalida = pwd;

% Publicar el informe
archivoGenerado = publish(archivoScript, ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar el archivo PDF generado
nuevoNombre = fullfile(carpetaSalida, 'SimulacionAlumnos_1.pdf');
movefile(archivoGenerado, nuevoNombre, 'f');

    disp(['Informe generado como: ' nuevoNombre]);

    close all;

%% 2. Simulación: Profesores
%clear all;
%clc; 

Texto_encabezados = 'Profesores';
%orden_favoritismo = [1 2 3 4 5];
%orden_favoritismo = [ ];
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
        favoritos=[favoritos1,fuertes(:,2)]; % Genera la matriz de preferencia 
        

% Bloques definidos por el usuario para Profesores
if length(unique(bloque(:,2))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,2));
end

% bloques = {
% %      1, [ ];
% %      2, [ ];
%      1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];      % Preparatoria
%      5, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];      % Facultades
%      3, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43];              % Centros Universitarios
%      1, [44, 45, 46, 47, 48, 49, 50];      % Unidades Académicas
%      5, [51, 52, 53];              % Institutos
%      5, [54];      % Administración central
% % %      3, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];      % Bloque 1 ? posición 1
% % %      3, [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];      % Bloque 2 ? posición 2
% % %      3, [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];              % Bloque 3 ? posición 3
% % %      3, [34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44];      % Bloque 2 ? posición 2
% % %      3, [45, 46, 47, 48, 49, 50, 51, 52, 53, 54];              % Bloque 3 ? posición 3
% };

% % Nombre del archivo fuente
%     archivoScript = 'SimulacionRector2025_9Jun25.m';
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
%     % Publicar en PDF
%     opciones = struct();
%     opciones.format = 'pdf';
%     opciones.outputDir = carpetaSalida;
%     opciones.showCode = false;
%     opciones.evalCode = true;
%     opciones.useNewFigure = true;
% 
%     % Ejecutar publish
%     archivoGenerado = publish(archivoScript, opciones);
% 
%     % Renombrar el archivo PDF
%     nombreNuevo = fullfile(carpetaSalida, 'SimulacionProfesores_1.pdf');
%     movefile(archivoGenerado, nombreNuevo, 'f');
% 
%     disp(['Informe generado como: ' nombreNuevo]);
% 
%     close all;

% Ruta del archivo script
archivoScript = 'SimulacionRector2025_9Jun25.m';

% Carpeta donde guardar el PDF
carpetaSalida = pwd;

% Publicar el informe
archivoGenerado = publish(archivoScript, ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar el archivo PDF generado
nuevoNombre = fullfile(carpetaSalida, 'SimulacionProfesores_1.pdf');
movefile(archivoGenerado, nuevoNombre, 'f');

    disp(['Informe generado como: ' nuevoNombre]);

    close all;


%% 3. Simulación: Administrativos

%clear all;
%clc; 

Texto_encabezados = 'Administrativos';
%orden_favoritismo = [1 1 1 1 4]; 
%orden_favoritismo = [ ];
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
        favoritos=[favoritos1,fuertes(:,3)]; % Genera la matriz de preferencia 
        

% Bloques definidos por el usuario para Administrativos

if length(unique(bloque(:,3))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,3));
end

% bloques = {
% %      1, [ ];
% %      2, [ ];
% %      1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];      % Preparatoria
% %      3, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];      % Facultades
% %      5, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43];              % Centros Universitarios
% %      4, [44, 45, 46, 47, 48, 49, 50];      % Unidades Académicas
% %      5, [51, 52, 53];              % Institutos
% %      5, [54];      % Administración central
% %     1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];      % Bloque 1 ? posición 1
% %     2, [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];      % Bloque 2 ? posición 2
% %     3, [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];              % Bloque 3 ? posición 3
% %     3, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];      % Bloque 1 ? posición 1
% %     4, [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];      % Bloque 2 ? posición 2
% %     5, [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];              % Bloque 3 ? posición 3
% %     1, [34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44];      % Bloque 2 ? posición 2
% %     2, [45, 46, 47, 48, 49, 50, 51, 52, 53, 54];              % Bloque 3 ? posición 3
% };

% % Nombre del archivo fuente
%     archivoScript = 'SimulacionRector2025_9Jun25.m';
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
%     % Publicar en PDF
%     opciones = struct();
%     opciones.format = 'pdf';
%     opciones.outputDir = carpetaSalida;
%     opciones.showCode = false;
%     opciones.evalCode = true;
%     opciones.useNewFigure = true;
% 
%     % Ejecutar publish
%     archivoGenerado = publish(archivoScript, opciones);
% 
%     % Renombrar el archivo PDF
%     nombreNuevo = fullfile(carpetaSalida, 'SimulacionAdministrativos_1.pdf');
%     movefile(archivoGenerado, nombreNuevo, 'f');
% 
%     disp(['Informe generado como: ' nombreNuevo]);
% 
%     close all;

% Ruta del archivo script
archivoScript = 'SimulacionRector2025_9Jun25.m';

% Carpeta donde guardar el PDF
carpetaSalida = pwd;

% Publicar el informe
archivoGenerado = publish(archivoScript, ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar el archivo PDF generado
nuevoNombre = fullfile(carpetaSalida, 'SimulacionAdministrativos_1.pdf');
movefile(archivoGenerado, nuevoNombre, 'f');

    disp(['Informe generado como: ' nuevoNombre]);

    close all;


%% 4. Unir Resultados
unirResultados

%% 5. Analisis de la elección para tener el resultado de los tres sectores

% Nombre del archivo fuente
    archivoScript = 'AnalisisEleccion.m';

    % Directorio de salida (puede ajustarse)
    carpetaSalida = pwd;

%     % Publicar en PDF
%     opciones = struct();
%     opciones.format = 'pdf';
%     opciones.outputDir = carpetaSalida;
%     opciones.showCode = false;
%     opciones.evalCode = true;
%     opciones.useNewFigure = true;

%     % Ejecutar publish
%     archivoGenerado = publish(archivoScript, opciones);

% Publicar el informe
archivoGenerado = publish(archivoScript, ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

    % Renombrar el archivo PDF
    nombreNuevo = fullfile(carpetaSalida, 'AnalisisEleccionTresSectores_1.pdf');
    movefile(archivoGenerado, nombreNuevo, 'f');

    disp(['Informe generado como: ' nombreNuevo]);

    close all;


%% 6. Análisis Entrópico
% Script principal para publicar análisis entrópico

% Definir la matriz M
M = [
    98216,24,4,5,0.4,1,100,20;
    7200,36,30,6,0.7,70,100,40;
    4601,48,35,1,0.5,60,80,100
];

% Guardar la matriz en un archivo temporal
save('datosTemp.mat', 'M');

% Crear wrapper temporal para cargar M y llamar analisisEntropico
fid = fopen('wrapperEntropico.m', 'w');
fprintf(fid, 'load(''datosTemp.mat'');\n');
fprintf(fid, 'resultado = analisisEntropico(M);\n');
fprintf(fid, 'disp(''Resultado del Análisis Entrópico:'');\n');
fprintf(fid, 'disp(resultado);\n');
fclose(fid);

% Publicar el wrapper como PDF (sin usar struct)
archivoGenerado = publish('wrapperEntropico.m', ...
    'format', 'pdf', ...
    'outputDir', pwd, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar archivo final
nombreNuevo = fullfile(pwd, 'AnalisisEntropico_1.pdf');
movefile(archivoGenerado, nombreNuevo, 'f');

% Limpiar temporales
delete('wrapperEntropico.m');
delete('datosTemp.mat');

% Confirmación
disp(['Informe generado como: ' nombreNuevo]);
close all;

% % Script principal para publicar análisis entrópico (Original, con error
% por llamar a ArchivoScritp -7 JUl 25)
%
% % Definir la matriz M
% 
% M = [
%     98216,24,4,5,0.400000000000000,1,100,20;
%     7200,36,30,6,0.700000000000000,70,100,40;
%     4601,48,35,1,0.500000000000000,60,80,100
%   ];
% 
% 
% % M = [ ...
% %     98331 24 4 0.00054917 0.7 5 100 20;
% %     7518 36 30 0.0072 0.6 10 100 50;
% %     4601 48 35 0.00043469 0.66 20 80 300];
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
%     % Guardar M en workspace temporal para que lo lea el script publicado
%     save('datosTemp.mat', 'M');
% 
% % Crear un wrapper temporal que cargue M y llame a analisisEntropico
% fid = fopen('wrapperEntropico.m', 'w');
% fprintf(fid, 'load(''datosTemp.mat'');\nresultado = analisisEntropico(M);\ndisp(resultado);');
% fclose(fid);
% 
% % % Opciones de publicación
% % opciones = struct();
% % opciones.format = 'pdf';
% % opciones.outputDir = pwd;
% % opciones.showCode = false;
% % opciones.evalCode = true;
% % opciones.useNewFigure = true;
% % 
% % % Publicar
% % archivoGenerado = publish('wrapperEntropico.m', opciones);
% % 
% 
% archivoGenerado = publish(archivoScript, ...
%     'format', 'pdf', ...
%     'outputDir', carpetaSalida, ...
%     'showCode', false, ...
%     'evalCode', true, ...
%     'useNewFigure', true);
% 
% % Renombrar archivo
% nombreNuevo = fullfile(pwd, 'AnalisisEntropico_1.pdf');
% movefile(archivoGenerado, nombreNuevo, 'f');
% 
% % Limpiar
% delete('wrapperEntropico.m');
% delete('datosTemp.mat');
% 
% disp(['Informe generado como: ' nombreNuevo]);
% close all;

%% 7. Procesar Resultados Ponderados

% Valores de entrada
A = 1; 
P = 1; 
T = 1;

% Carpeta de salida (actual)
carpetaSalida = pwd;

% Guardar A, P y T en archivo temporal
save('valoresAPT.mat', 'A', 'P', 'T');

% Crear archivo wrapper temporal
fid = fopen('wrapperPonderados.m', 'w');
fprintf(fid, 'load(''valoresAPT.mat'');\n');
fprintf(fid, 'disp(''Resultado del análisis ponderado:'');\n');
fprintf(fid, 'procesarResultadosPonderados(A, P, T);\n');
fclose(fid);

% Ejecutar publish del wrapper (sin usar struct)
archivoGenerado = publish('wrapperPonderados.m', ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar archivo final
nombreNuevo = fullfile(pwd, 'ResultadosPonderadosTresSectores_1.pdf');
movefile(archivoGenerado, nombreNuevo, 'f');

% Limpiar archivos temporales
delete('wrapperPonderados.m');
delete('valoresAPT.mat');

% Confirmación
disp(['Informe generado como: ' nombreNuevo]);
close all;
 
% %% 7. Procesar Resultados Ponderados (Original - 7 Jul 25)
% A = 1; P = 1; T = 1;
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
% % Guardar A, P y T en un archivo temporal
% save('valoresAPT.mat', 'A', 'P', 'T');
% 
% % Crear wrapper temporal que cargue A, P, T y ejecute la función
% fid = fopen('wrapperPonderados.m', 'w');
% fprintf(fid, 'load(''valoresAPT.mat'');\n');
% %fprintf(fid, 'resultado = procesarResultadosPonderados(A, P, T);\n');
% fprintf(fid, 'procesarResultadosPonderados(A, P, T);\n');
% fprintf(fid, 'disp(''Resultado del análisis ponderado:'');\n');
% %fprintf(fid, 'disp(resultado);\n');
% fclose(fid);
% 
% % % Configurar opciones para publicar
% % opciones = struct();
% % opciones.format = 'pdf';
% % opciones.outputDir = pwd;
% % opciones.showCode = false;
% % opciones.evalCode = true;
% % opciones.useNewFigure = true;
% % 
% % % Ejecutar publish
% % archivoGenerado = publish('wrapperPonderados.m', opciones);
% 
% archivoGenerado = publish(archivoScript, ...
%     'format', 'pdf', ...
%     'outputDir', carpetaSalida, ...
%     'showCode', false, ...
%     'evalCode', true, ...
%     'useNewFigure', true);
% 
% % Renombrar el archivo PDF
% nombreNuevo = fullfile(pwd, 'ResultadosPonderadosTresSectores_1.pdf');
% movefile(archivoGenerado, nombreNuevo, 'f');
% 
% % Limpiar archivos temporales
% delete('wrapperPonderados.m');
% delete('valoresAPT.mat');
% 
% disp(['Informe generado como: ' nombreNuevo]);
% 
% close all;

%% 8. Procesar Ganadores Ponderados

% Asignar valores de entrada
A = 1; 
P = 1; 
T = 1;

% Directorio actual
carpetaSalida = pwd;

% Guardar A, P y T temporalmente
save('valoresAPT.mat', 'A', 'P', 'T');

% Crear un wrapper temporal que cargue y ejecute la función
fid = fopen('wrapperGanadores.m', 'w');
fprintf(fid, 'load(''valoresAPT.mat'');\n');
fprintf(fid, 'disp(''Resultado del análisis ponderado:'');\n');
fprintf(fid, 'procesarGanadoresPonderados(A, P, T);\n');
fclose(fid);

% Ejecutar publish sin usar struct
archivoGenerado = publish('wrapperGanadores.m', ...
    'format', 'pdf', ...
    'outputDir', carpetaSalida, ...
    'showCode', false, ...
    'evalCode', true, ...
    'useNewFigure', true);

% Renombrar el archivo final
nombreNuevo = fullfile(pwd, 'ResultadosGanadoresPonderadosTresSectores_1.pdf');
movefile(archivoGenerado, nombreNuevo, 'f');

% Eliminar archivos temporales
delete('wrapperGanadores.m');
delete('valoresAPT.mat');

% Confirmación
disp(['Informe generado como: ' nombreNuevo]);
close all;

% %% 8. Procesar Ganadores Ponderados (Original 7 Jul 25)
% A = 1; P = 1; T = 1;
% 
%     % Directorio de salida (puede ajustarse)
%     carpetaSalida = pwd;
% 
% % Guardar A, P y T en un archivo temporal
% save('valoresAPT.mat', 'A', 'P', 'T');
% 
% % Crear wrapper temporal que cargue A, P, T y ejecute la función
% fid = fopen('wrapperPonderados.m', 'w');
% fprintf(fid, 'load(''valoresAPT.mat'');\n');
% %fprintf(fid, 'resultado = procesarGanadoresPonderados(A, P, T);\n');
% fprintf(fid, 'procesarGanadoresPonderados(A, P, T);\n');
% fprintf(fid, 'disp(''Resultado del análisis ponderado:'');\n');
% %fprintf(fid, 'disp(resultado);\n');
% fclose(fid);
% 
% % % Configurar opciones para publicar
% % opciones = struct();
% % opciones.format = 'pdf';
% % opciones.outputDir = pwd;
% % opciones.showCode = false;
% % opciones.evalCode = true;
% % opciones.useNewFigure = true;
% % 
% % % Ejecutar publish
% % archivoGenerado = publish('wrapperPonderados.m', opciones);
% 
% archivoGenerado = publish(archivoScript, ...
%     'format', 'pdf', ...
%     'outputDir', carpetaSalida, ...
%     'showCode', false, ...
%     'evalCode', true, ...
%     'useNewFigure', true);
% 
% % Renombrar el archivo PDF
% nombreNuevo = fullfile(pwd, 'ResultadosGanadoresPonderadosTresSectores_1.pdf');
% movefile(archivoGenerado, nombreNuevo, 'f');
% 
% % Limpiar archivos temporales
% delete('wrapperPonderados.m');
% delete('valoresAPT.mat');
% 
% disp(['Informe generado como: ' nombreNuevo]);
% 
% close all;

%% 9. Informe con las 10 combinaciones de peso por sector
InformeCombinacionesEleccionRector

%% 10. Concatenar archivos

%     inputFiles = {'SimulacionAlumnos_1.pdf', 'SimulacionProfesores_1.pdf', 'SimulacionAdministrativos_1.pdf', 'AnalisisEleccionTresSectores_1.pdf', 'AnalisisEntropico_1.pdf', 'ResultadosPonderadosTresSectores_1.pdf', 'ResultadosGanadoresPonderadosTresSectores_1.pdf', 'ResultadosGanadoresPonderadosTresSectores_1.pdf',  'InformeCombinaciones_3Sectores_1.pdf'};
%     outputFileName = 'SimulacionesTresSectores_1.pdf';
%     append_pdfs(outputFileName, inputFiles{:})
% 
%     disp(['Informe integrado como: ' outputFileName]);

% === Definir archivos de entrada y salida ===
inputFiles = {
    'DatosIniciales.pdf',
    'SimulacionAlumnos_1.pdf',
    'SimulacionProfesores_1.pdf',
    'SimulacionAdministrativos_1.pdf',
    'AnalisisEleccionTresSectores_1.pdf',
%    'AnalisisEntropico_1.pdf',
%    'ResultadosPonderadosTresSectores_1.pdf',
%    'ResultadosGanadoresPonderadosTresSectores_1.pdf',
%    'ResultadosGanadoresPonderadosTresSectores_1.pdf',  % Duplicado
    'InformeCombinaciones_3Sectores_1.pdf'
};

outputFileName = 'SimulacionesTresSectores_1.pdf';

% === Unir archivos PDF ===
append_pdfs(outputFileName, inputFiles{:});

% === Eliminar archivos de entrada ===
archivosEliminados = {};
for k = 1:length(inputFiles)
    try
        if exist(inputFiles{k}, 'file') == 2
            delete(inputFiles{k});
            archivosEliminados{end+1} = inputFiles{k}; %#ok<AGROW>
        end
    catch ME
        warning('No se pudo eliminar %s: %s', inputFiles{k}, ME.message);
    end
end

% === Confirmar éxito ===
fprintf('PDF combinado creado como: %s\n', outputFileName);
fprintf('Se eliminaron los siguientes archivos:\n');
disp(archivosEliminados');
toc;