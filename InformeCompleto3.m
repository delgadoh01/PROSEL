 %% 1. Simulaci髇: Alumnos

% Definicion inicial de los bloques
bloques = {
     1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];      % Preparatoria
     1, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];      % Facultades
     1, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43];              % Centros Universitarios
     1, [44, 45, 46, 47, 48, 49, 50];      % Unidades Acad茅micas
     1, [51, 52, 53];              % Institutos
     1, [54];      % Administraci贸n central
  };

% Evaluaci贸n de las matrices fuertes y bloque
 
if all(fuertes(:) == 1) && all(bloque(:) == 1)
    Preferidos = 2;
elseif all(bloque(:) == 1)
    Preferidos = 1;
elseif all(fuertes(:) == 1)
    Preferidos = 0;
else
    Preferidos = 3; % Ninguna condici贸n se cumple
end

Texto_encabezados = 'Alumnos';
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el n煤mero de aspirantes
        favoritos=[favoritos1,fuertes(:,1)]; % Genera la matriz de preferencia 
        

% Bloques definidos por el usuario para Alumnos
if length(unique(bloque(:,1))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,1));
end

% Ejecuta simulaci髇
SimulacionRector2025_9Jun25;

%% 2. Simulaci贸n: Profesores
Texto_encabezados = 'Profesores';
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el n煤mero de aspirantes
        favoritos=[favoritos1,fuertes(:,2)]; % Genera la matriz de preferencia 
        
% Bloques definidos por el usuario para Profesores
if length(unique(bloque(:,2))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,2));
end

% Ejecuta Simulaci髇
SimulacionRector2025_9Jun25

%% 3. Simulaci贸n: Administrativos
Texto_encabezados = 'Administrativos';
        favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el n煤mero de aspirantes
        favoritos=[favoritos1,fuertes(:,3)]; % Genera la matriz de preferencia 
        
% Bloques definidos por el usuario para Administrativos
if length(unique(bloque(:,3))) == 1;
    bloques= [];
else
bloques(:, 1) = num2cell(bloque(:,3));
end

% Ejecuta simulaci髇
SimulacionRector2025_9Jun25

%% 4. Unir Resultados
unirResultados

%% 5. Analisis de la elecci髇 para tener el resultado de los tres sectores

% EJecuta Analisis de la elecci髇
AnalisisEleccion


%% 6. An谩lisis Entr髉ico
% Script principal para publicar an谩lisis entr贸pico

% % Definir la matriz M
% M = [
%     98216,24,4,5,0.4,1,100,20;
%     7200,36,30,6,0.7,70,100,40;
%     4601,48,35,1,0.5,60,80,100
% ];
% 
% % Guardar la matriz en un archivo temporal
% save('datosTemp.mat', 'M');
% 
% % Define el nombre del archivo de entrada
% filename = 'analisisEntropico.m';
% 
% % Crear wrapper temporal para cargar M y llamar analisisEntropico
% fid = fopen('wrapperEntropico.m', 'w');
% fprintf(fid, 'load(''datosTemp.mat'');\n');
% fprintf(fid, 'resultado = analisisEntropico(M);\n');
% fprintf(fid, 'disp(''Resultado del An谩lisis Entr贸pico:'');\n');
% fprintf(fid, 'disp(resultado);\n');
% fclose(fid);
% 
% 
% 
% % Configura las opciones de publicaci贸n
% options.format = 'pdf'; % Especifica el formato de salida como PDF
% options.evalCode = true; % Ejecuta el c贸digo durante la publicaci贸n
% options.catchError = true; % Captura errores durante la publicaci贸n
% options.outputDir = pwd; % Establece el directorio de salida al directorio actual
% 
% % Publica el archivo
% publish(filename, options);
% 
% % Renombra el archivo de salida
% movefile('analisisEntropico.pdf', 'AnalisisEntropico_1.pdf'); % Cambia el nombre del archivo
% 
%    close all;
% 
% % Limpiar temporales
% delete('wrapperEntropico.m');
% delete('datosTemp.mat');

%% 7. Procesar Resultados Ponderados

% Valores de entrada
A = 1; 
P = 1; 
T = 1;

% Ejecuta la ponderaci髇
procesarResultadosPonderados(A, P, T)

%% 8. Procesar Ganadores Ponderados

% Asignar valores de entrada
A = 1; 
P = 1; 
T = 1;

% Ejecuta la rutina
procesarGanadoresPonderados(A, P, T)

%% 9. Informe con las 10 combinaciones de peso por sector
% === Paso 2: Cargar archivo y validar ===
datos = load('ResultadosConcentrados.mat');
if isfield(datos, 'Votos_por_espacio')
    [~, nAspirantes] = size(datos.Votos_por_espacio);
else
    error('El archivo "ResultadosConcentrados.mat" no contiene la matriz "Votos_por_espacio".');
end

% === Generar gr醘icas de las combinaciones ===
for ii = 1:size(combinaciones, 1)
    A = combinaciones(ii,1);
    P = combinaciones(ii,2);
    T = combinaciones(ii,3);

    % Llamada correcta a la funci髇
    procesarResultadosPonderados(A, P, T);
    
    %Nueva linea
    procesarGanadoresPonderados(A, P, T)

    drawnow;
end

%% Guardar graficas en pdf
% === Configura nombre del archivo final ===
archivoFinal = 'InformeDeEleccionCompleta_1.pdf';

% === Encuentra todas las figuras abiertas ===
figs = findall(0, 'Type', 'figure');
figs = figs(isgraphics(figs, 'figure'));  % Evita placeholders
[~, idx] = sort(arrayfun(@(f) f.Number, figs));
figs = figs(idx);

% === Carpeta temporal para guardar PDFs individuales ===
carpetaTemp = fullfile(tempdir, 'figs_temp');
if ~exist(carpetaTemp, 'dir')
    mkdir(carpetaTemp);
end

% === Guardar cada figura como PDF individual ===
archivosIndividuales = cell(1, length(figs));
for k = 1:length(figs)
    nombre = fullfile(carpetaTemp, sprintf('figura_%03d.pdf', k));
    figure(figs(k));  % Asegura que sea la activa
    print(figs(k), '-dpdf', '-bestfit', nombre);
    archivosIndividuales{k} = nombre;
end

% === Unir todos los PDFs ===
archivoSalida = fullfile(pwd, archivoFinal);  % Se guarda en la carpeta actual
append_pdfs(archivoSalida, archivosIndividuales{:});

% === Limpiar temporales ===
pause(1);  % Asegura que se liberen archivos
try
    delete(archivosIndividuales{:});
    rmdir(carpetaTemp);
catch
    warning('No se pudieron eliminar archivos temporales');
end

fprintf('PDF generado exitosamente: %s\n', archivoSalida);


%% Solo dejar abiertas las figuras trascendentes
permitidas = [56, 111, 166, 221, 224:999];
todas = findall(0, 'Type', 'figure');
for i = 1:length(todas)
    figNum = todas(i).Number;
    if ~ismember(figNum, permitidas)
        close(figNum);
    end
end

% Crear tablero de subplots
figurasRestantes = findall(0, 'Type', 'figure');
figurasRestantes = figurasRestantes(isgraphics(figurasRestantes, 'figure'));
[~, idx] = sort(arrayfun(@(f) f.Number, figurasRestantes));
figurasRestantes = figurasRestantes(idx);

nFig = length(figurasRestantes);
filas = floor(sqrt(nFig));
cols = ceil(nFig / filas);

% Crear figura del tablero
figTablero = figure('Name', 'Tablero de Figuras Trascendentes', ...
                    'Units', 'normalized', 'OuterPosition', [0 0 1 1]);

% Bot髇 de cierre en el tablero
uicontrol(figTablero, ...
          'Style', 'pushbutton', ...
          'String', 'Cerrar Todo', ...
          'Units', 'normalized', ...
          'Position', [0.85 0.01 0.13 0.05], ...
          'FontSize', 12, ...
          'Callback', 'close all');

for k = 1:nFig
    subplot(filas, cols, k);
    axNew = gca;
    fig = figurasRestantes(k);

    % Buscar ejes originales
    axOlds = findall(fig, 'Type', 'axes');

    for j = 1:length(axOlds)
        axOld = axOlds(j);
        hijos = allchild(axOld);

        for h = 1:length(hijos)
            try
                nuevoObj = copyobj(hijos(h), axNew);
                set(nuevoObj, 'HitTest', 'on', 'PickableParts', 'all');
                set(nuevoObj, 'ButtonDownFcn', @(~,~) abrirFiguraCompleta(fig));
            catch
                warning('No se pudo copiar un objeto de la figura %d', fig.Number);
            end
        end

        % Copiar propiedades visuales
        try
            axNew.XLim = axOld.XLim;
            axNew.YLim = axOld.YLim;
            axNew.ZLim = axOld.ZLim;
            axNew.XLabel.String = axOld.XLabel.String;
            axNew.YLabel.String = axOld.YLabel.String;
            axNew.ZLabel.String = axOld.ZLabel.String;
            axNew.Title.String  = axOld.Title.String;
            axNew.XScale = axOld.XScale;
            axNew.YScale = axOld.YScale;
            axNew.Box = axOld.Box;
            axNew.GridLineStyle = axOld.GridLineStyle;
        catch
            warning('No se pudieron copiar propiedades de ejes en figura %d', fig.Number);
        end
    end
end