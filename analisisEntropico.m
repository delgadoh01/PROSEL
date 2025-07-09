function [pesosSectores, rankingSectores, tablaResultados] = analisisEntropico(matrizEvaluacion)
    % Entradas:
    % - matrizEvaluacion: matriz 3xN (sectores x criterios)
    % Salidas:
    % - pesosSectores: vector 3x1 con el valor ponderado final por sector
    % - rankingSectores: orden descendente de sectores (�ndices)
    % - tablaResultados: tabla con etiquetas y pesos finales
    
%% Resultados del an�lisis entr�pico para ponderar los sectores de la Universidad
%  Para usar esta rutina, se genera la matriz de evaluaci�n M 
%  Los criterios (columnas) son:
% [1] N�mero de miembros
% [2] Horas por semana en la universidad
% [3] Tiempo total de vida en la universidad
% [4] Participaci�n en �rganos colegiados
% [5] Participaci�n en procesos electorales internos
% [6] Acceso a recursos institucionales
% [7] Aportes documentados al desarrollo institucional
% [8] Tareas operativas ejecutadas directamente  

% EJemplo de matriz
%  M = [
%     98216,24,4,5,0.400000000000000,1,100,20;
%     7200,36,30,6,0.700000000000000,70,100,40;
%     4601,48,35,1,0.500000000000000,60,80,100
%   ];
% 
% [pesos, ranking, tabla] = analisisEntropico(M);

%% Analisis Entropico

    format short;

    [m, n] = size(matrizEvaluacion);

    if m ~= 3
        error('La matriz debe tener 3 filas: Alumnos, Profesores y Administrativos.');
    end

    % === Paso 1: Normalizaci�n por columnas ===
    matrizNormalizada = zeros(m, n);
    for j = 1:n
        colSum = sum(matrizEvaluacion(:, j));
        if colSum == 0
            matrizNormalizada(:, j) = 0;
        else
            matrizNormalizada(:, j) = matrizEvaluacion(:, j) / colSum;
        end
    end

    % === Paso 2: C�lculo de entrop�a por criterio ===
    k = 1 / log(m);  % m = n�mero de sectores
    entropias = zeros(1, n);
    for j = 1:n
        col = matrizNormalizada(:, j);
        col(col == 0) = eps;  % evitar log(0)
        entropias(j) = -k * sum(col .* log(col));
    end

    % Imprimir M
    matrizEvaluacion;
    
    % === Paso 3: Diversidades y pesos por criterio ===
    diversidades = 1 - entropias;
    pesosCriterios = diversidades / sum(diversidades);

    % === Paso 4: Peso final por sector ===
    pesosSectores = matrizNormalizada * pesosCriterios';

    % === Paso 5: Ranking de sectores ===
    [~, rankingSectores] = sort(pesosSectores, 'descend');

    % === Paso 6: Tabla con etiquetas ===
    sectores = ["Alumnos"; "Profesores"; "Administrativos"];
    tablaResultados = table(sectores, pesosSectores, 'VariableNames', {'Sector', 'PesoFinal'});

    % === Mostrar en consola ===
    disp('--- Resultados del An�lisis Entr�pico ---');
    disp(tablaResultados);

    disp('--- Jerarqu�a ---');
    for i = 1:3
        fprintf('%d� lugar: %s\n', i, sectores(rankingSectores(i)));
    end

    % === Paso 7: Gr�fica de barras ===
    figure('Color','w');
    %bar(pesosSectores, 'FaceColor', [0.3 0.3 0.7]);
    bar(pesosSectores, 'FaceColor', 'k');
    set(gca, 'XTickLabel', sectores, 'FontName','Times New Roman', 'FontSize', 12);
    ylabel('Peso Entr�pico', 'FontName','Times New Roman','FontSize', 12);
    title('Jerarqu�a de Sectores seg�n An�lisis Entr�pico', 'FontName','Times New Roman','FontSize', 12);

    % Mostrar valor en cada barra
    for i = 1:length(pesosSectores)
        text(i, pesosSectores(i) + 0.01, ...
            sprintf('%.3f', pesosSectores(i)), ...
            'HorizontalAlignment', 'center', 'FontSize', 10);
    end

    % (Opcional) === Paso 8: Exportar tabla a Excel ===
%     filename = 'PesosEntropicosPorSector.xlsx';
%     writetable(tablaResultados, filename);
%     fprintf('Tabla exportada exitosamente a "%s"\n', filename);
end
