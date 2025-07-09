%% Análisis de Elección de Rector - UA Mexicana

% === Paso 1: Definir combinaciones de pesos ===
% combinaciones = [
%     1, 1, 1;
%     4, 3, 3;
%     3, 4, 3;
%     3, 3, 4;
%     2, 1, 1;
%     1, 2, 1;
%     1, 1, 2;
%     3, 2, 2;
%     2, 3, 2;
%     2, 2, 1;
%     3, 2, 1
% ];

% === Paso 2: Cargar archivo y validar ===
datos = load('ResultadosConcentrados.mat');
if isfield(datos, 'Votos_por_espacio')
    [~, nAspirantes] = size(datos.Votos_por_espacio);
else
    error('El archivo "ResultadosConcentrados.mat" no contiene la matriz "Votos_por_espacio".');
end

fprintf('Número de aspirantes detectados: %d\n', nAspirantes);

% === Paso 3: Crear archivo wrapper ===
fid = fopen('wrapperInformeRector.m', 'w');
if fid == -1
    error('No se pudo crear el archivo wrapperInformeRector.m');
end

fprintf(fid, '%% Informe de Resultados Ponderados y Ganadores Ponderados\n');
fprintf(fid, 'load(''ResultadosConcentrados.mat'');\n');
fprintf(fid, 'close all;\n');

for i = 1:size(combinaciones, 1)
    A = combinaciones(i,1);
    P = combinaciones(i,2);
    T = combinaciones(i,3);

    fprintf(fid, '%% --- Análisis %d: Resultados Ponderados A=%d, P=%d, T=%d ---\n', 2*i-1, A, P, T);
    fprintf(fid, 'procesarResultadosPonderados(%d, %d, %d);\n', A, P, T);
    fprintf(fid, 'drawnow;\n\n');

    fprintf(fid, '%% --- Análisis %d: Ganadores Ponderados A=%d, P=%d, T=%d ---\n', 2*i, A, P, T);
    fprintf(fid, 'procesarGanadoresPonderados(%d, %d, %d);\n', A, P, T);
    fprintf(fid, 'drawnow;\n\n');
end
fclose(fid);

% === Paso 4: Publicar sin struct ===
try
    archivoGenerado = publish('wrapperInformeRector.m', ...
        'format', 'pdf', ...
        'outputDir', pwd, ...
        'showCode', false, ...
        'evalCode', true, ...
        'useNewFigure', true);

    % Validar y renombrar
    if isempty(archivoGenerado) || ~isfile(archivoGenerado)
        error('El archivo PDF no se generó correctamente.');
    end

    nombreFinal = fullfile(pwd, 'InformeCombinaciones_3Sectores_1.pdf');
    movefile(archivoGenerado, nombreFinal, 'f');
    disp(['? Informe generado exitosamente como: ', nombreFinal]);

catch ME
    warning('? Error durante la generación del informe:\n%s', ME.message);
end

% === Paso 5: Limpieza ===
if isfile('wrapperInformeRector.m')
    delete('wrapperInformeRector.m');
end
close all;


%% Rutina original

% %% Análisis de Elección de Rector - UA Mexicana
% 
% % === Paso 1: Definir combinaciones de pesos ===
% combinaciones = [
% 1, 1, 1;
% 4, 3, 3;
% 3, 4, 3;
% 3, 3, 4;
% 2, 1, 1;
% 1, 2, 1;
% 1, 1, 2;
% 3, 2, 2;
% 2, 3, 2;
% 2, 2, 1;
% 3, 2, 1;
% %     1 1 1;
% %     4 3 3;
% %     3 4 3;
% %     3 3 4;
% %     2 1 1;
% %     1 2 1;
% %     1 1 2;
% %     3 2 2;
% %     1 2 2;
% %     2 2 1
%  ];
% 
% % === Paso 2: Cargar archivo para determinar número de aspirantes ===
% datos = load('ResultadosConcentrados.mat');
% if isfield(datos, 'Votos_por_espacio')
%     [~, nAspirantes] = size(datos.Votos_por_espacio);
% else
%     error('El archivo "ResultadosConcentrados.mat" no contiene la matriz "Votos_por_espacio".');
% end
% 
% fprintf('Número de aspirantes detectados: %d\n', nAspirantes);
% 
% % === Paso 3: Crear wrapper temporal para publicar las gráficas ===
% fid = fopen('wrapperInformeRector.m', 'w');
% fprintf(fid, '%% Informe de Resultados Ponderados y Ganadores Ponderados\n');
% fprintf(fid, 'load(''ResultadosConcentrados.mat'');\n');
% fprintf(fid, 'close all;\n');
% 
% for i = 1:size(combinaciones, 1)
%     A = combinaciones(i,1);
%     P = combinaciones(i,2);
%     T = combinaciones(i,3);
% 
%     % Procesar Resultados Ponderados (gráfica impar)
%     fprintf(fid, '%% --- Análisis %d: Resultados Ponderados A=%d, P=%d, T=%d ---\n', 2*i-1, A, P, T);
%     fprintf(fid, 'procesarResultadosPonderados(%d, %d, %d);\n', A, P, T);
%     fprintf(fid, 'drawnow;\n\n');
% 
%     % Procesar Ganadores Ponderados (gráfica par)
%     fprintf(fid, '%% --- Análisis %d: Ganadores Ponderados A=%d, P=%d, T=%d ---\n', 2*i, A, P, T);
%     fprintf(fid, 'procesarGanadoresPonderados(%d, %d, %d);\n', A, P, T);
%     fprintf(fid, 'drawnow;\n\n');
% end
% 
% fclose(fid);
% 
% % === Paso 4: Configurar opciones de publicación ===
% opciones = struct();
% opciones.format = 'pdf';
% opciones.outputDir = pwd;
% opciones.showCode = false;
% opciones.evalCode = true;
% opciones.useNewFigure = true;
% 
% % === Paso 5: Publicar y renombrar ===
% archivoGenerado = publish('wrapperInformeRector.m', opciones);
% nombreFinal = fullfile(pwd, 'InformeCombinaciones_3Sectores_1.pdf');
% movefile(archivoGenerado, nombreFinal, 'f');
% 
% % === Paso 6: Limpiar === 
% delete('wrapperInformeRector.m');
% disp(['Informe generado exitosamente como: ' nombreFinal]);
% close all;



% %% Análisis de Elección de Rector - UA Mexicana (Original 7 Jul 25)
% 
% % === Paso 1: Definir combinaciones de pesos === Quitar comentario cuando
% % se corre aislada la rutina
% 
% % combinaciones = [
% % 1, 1, 1;
% % 4, 3, 3;
% % 3, 4, 3;
% % 3, 3, 4;
% % 2, 1, 1;
% % 1, 2, 1;
% % 1, 1, 2;
% % 3, 2, 2;
% % 2, 3, 2;
% % 2, 2, 1;
% % 3, 2, 1;
% % ];
% 
% % === Paso 2: Cargar archivo para determinar número de aspirantes ===
% datos = load('ResultadosConcentrados.mat');
% if isfield(datos, 'Votos_por_espacio')
%     [~, nAspirantes] = size(datos.Votos_por_espacio);
% else
%     error('El archivo "ResultadosConcentrados.mat" no contiene la matriz "Votos_por_espacio".');
% end
% 
% fprintf('Número de aspirantes detectados: %d\n', nAspirantes);
% 
% % === Paso 3: Crear wrapper temporal para publicar las gráficas ===
% fid = fopen('wrapperInformeRector.m', 'w');
% if fid == -1
%     error('No se pudo crear el archivo wrapperInformeRector.m');
% end
% 
% fprintf(fid, '%% Informe de Resultados Ponderados y Ganadores Ponderados\n');
% fprintf(fid, 'load(''ResultadosConcentrados.mat'');\n');
% fprintf(fid, 'close all;\n');
% 
% for i = 1:size(combinaciones, 1)
%     A = combinaciones(i,1);
%     P = combinaciones(i,2);
%     T = combinaciones(i,3);
% 
%     % Procesar Resultados Ponderados (gráfica impar)
%     fprintf(fid, '%% --- Análisis %d: Resultados Ponderados A=%d, P=%d, T=%d ---\n', 2*i-1, A, P, T);
%     fprintf(fid, 'procesarResultadosPonderados(%d, %d, %d);\n', A, P, T);
%     fprintf(fid, 'drawnow;\n\n');
% 
%     % Procesar Ganadores Ponderados (gráfica par)
%     fprintf(fid, '%% --- Análisis %d: Ganadores Ponderados A=%d, P=%d, T=%d ---\n', 2*i, A, P, T);
%     fprintf(fid, 'procesarGanadoresPonderados(%d, %d, %d);\n', A, P, T);
%     fprintf(fid, 'drawnow;\n\n');
% end
% 
% fclose(fid);
% 
% % % === Paso 4: Configurar opciones de publicación ===
% % opciones = struct();
% % opciones.format = 'pdf';
% % opciones.outputDir = pwd;
% % opciones.showCode = false;
% % opciones.evalCode = true;
% % opciones.useNewFigure = true;
% 
% archivoGenerado = publish(archivoScript, ...
%     'format', 'pdf', ...
%     'outputDir', carpetaSalida, ...
%     'showCode', false, ...
%     'evalCode', true, ...
%     'useNewFigure', true);
% 
% 
% % === Paso 5: Publicar y renombrar con validación robusta ===
% try
%     archivoGenerado = publish('wrapperInformeRector.m', opciones);
%     disp(['Archivo generado: ', archivoGenerado]);
% 
%     if isempty(archivoGenerado) || ~isfile(archivoGenerado)
%         error('El archivo PDF no se generó o su ruta es inválida.');
%     end
% 
%     nombreFinal = fullfile(pwd, 'InformeCombinaciones_3Sectores_1.pdf');
%     movefile(archivoGenerado, nombreFinal, 'f');
%     disp(['Informe generado exitosamente como: ' nombreFinal]);
% 
% catch ME
%     warning('Error durante la generación o publicación del informe:\n%s', ME.message);
% end
% 
% % === Paso 6: Limpiar === 
% if isfile('wrapperInformeRector.m')
% %    delete('wrapperInformeRector.m');
% end
% close all;
% 
% 
% %% Rutina original
% 
% % %% Análisis de Elección de Rector - UA Mexicana
% % 
% % % === Paso 1: Definir combinaciones de pesos ===
% % combinaciones = [
% % 1, 1, 1;
% % 4, 3, 3;
% % 3, 4, 3;
% % 3, 3, 4;
% % 2, 1, 1;
% % 1, 2, 1;
% % 1, 1, 2;
% % 3, 2, 2;
% % 2, 3, 2;
% % 2, 2, 1;
% % 3, 2, 1;
% % %     1 1 1;
% % %     4 3 3;
% % %     3 4 3;
% % %     3 3 4;
% % %     2 1 1;
% % %     1 2 1;
% % %     1 1 2;
% % %     3 2 2;
% % %     1 2 2;
% % %     2 2 1
% %  ];
% % 
% % % === Paso 2: Cargar archivo para determinar número de aspirantes ===
% % datos = load('ResultadosConcentrados.mat');
% % if isfield(datos, 'Votos_por_espacio')
% %     [~, nAspirantes] = size(datos.Votos_por_espacio);
% % else
% %     error('El archivo "ResultadosConcentrados.mat" no contiene la matriz "Votos_por_espacio".');
% % end
% % 
% % fprintf('Número de aspirantes detectados: %d\n', nAspirantes);
% % 
% % % === Paso 3: Crear wrapper temporal para publicar las gráficas ===
% % fid = fopen('wrapperInformeRector.m', 'w');
% % fprintf(fid, '%% Informe de Resultados Ponderados y Ganadores Ponderados\n');
% % fprintf(fid, 'load(''ResultadosConcentrados.mat'');\n');
% % fprintf(fid, 'close all;\n');
% % 
% % for i = 1:size(combinaciones, 1)
% %     A = combinaciones(i,1);
% %     P = combinaciones(i,2);
% %     T = combinaciones(i,3);
% % 
% %     % Procesar Resultados Ponderados (gráfica impar)
% %     fprintf(fid, '%% --- Análisis %d: Resultados Ponderados A=%d, P=%d, T=%d ---\n', 2*i-1, A, P, T);
% %     fprintf(fid, 'procesarResultadosPonderados(%d, %d, %d);\n', A, P, T);
% %     fprintf(fid, 'drawnow;\n\n');
% % 
% %     % Procesar Ganadores Ponderados (gráfica par)
% %     fprintf(fid, '%% --- Análisis %d: Ganadores Ponderados A=%d, P=%d, T=%d ---\n', 2*i, A, P, T);
% %     fprintf(fid, 'procesarGanadoresPonderados(%d, %d, %d);\n', A, P, T);
% %     fprintf(fid, 'drawnow;\n\n');
% % end
% % 
% % fclose(fid);
% % 
% % % === Paso 4: Configurar opciones de publicación ===
% % opciones = struct();
% % opciones.format = 'pdf';
% % opciones.outputDir = pwd;
% % opciones.showCode = false;
% % opciones.evalCode = true;
% % opciones.useNewFigure = true;
% % 
% % % === Paso 5: Publicar y renombrar ===
% % archivoGenerado = publish('wrapperInformeRector.m', opciones);
% % nombreFinal = fullfile(pwd, 'InformeCombinaciones_3Sectores_1.pdf');
% % movefile(archivoGenerado, nombreFinal, 'f');
% % 
% % % === Paso 6: Limpiar === 
% % delete('wrapperInformeRector.m');
% % disp(['Informe generado exitosamente como: ' nombreFinal]);
% % close all;
