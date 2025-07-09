function procesarGanadoresPonderados(A, P, T)
    % A, P, T: número de veces que se desea que aparezca cada bloque (Alumnos, Profesores, Administrativos)

    % === Paso 1: Cargar archivo original ===
    datos = load('ResultadosConcentrados.mat');
    ganadores = datos.Ganadores;

    if length(ganadores) ~= 162
        error('La matriz Ganadores debe tener exactamente 162 filas.');
    end

    % === Paso 2: Separar bloques ===
    bloqueA = ganadores(1:54);
    bloqueP = ganadores(55:108);
    bloqueT = ganadores(109:162);

    % === Paso 3: Replicar bloques según A, P, T ===
    ganA_rep = repmat(bloqueA, A, 1);
    ganP_rep = repmat(bloqueP, P, 1);
    ganT_rep = repmat(bloqueT, T, 1);

    % === Paso 4: Concatenar bloques ===
    GanadoresPonderados = [ganA_rep; ganP_rep; ganT_rep];

    % === Paso 5: Guardar archivo ===
    save('GanadoresPonderados.mat', 'GanadoresPonderados');

    % === Paso 6: Obtener lista de aspirantes únicos ===
    aspirantes = unique(ganadores);
    n = length(aspirantes);

    % === Paso 7: Contar frecuencias ===
    conteo_original = zeros(1, n);
    conteo_ponderado = zeros(1, n);
    for i = 1:n
        conteo_original(i) = sum(ganadores == aspirantes(i));
        conteo_ponderado(i) = sum(GanadoresPonderados == aspirantes(i));
    end

    % === Paso 8: Calcular rankings ===
    [~, orden_ori] = sort(conteo_original, 'descend');
    [~, orden_pond] = sort(conteo_ponderado, 'descend');

    ranking_ori = zeros(1, n);
    ranking_pond = zeros(1, n);
    for i = 1:n
        ranking_ori(orden_ori(i)) = i;
        ranking_pond(orden_pond(i)) = i;
    end

    cambio = ranking_ori ~= ranking_pond;

    % === Paso 9: Correlación de Spearman ===
    [rho, pval] = corr(conteo_original', conteo_ponderado', 'Type', 'Spearman');
    texto_cambio = 'Cambia jerarquía';
    if pval < 0.05
        texto_cambio = 'No cambia jerarquía';
    end
    texto_correlacion = sprintf('Coef. Spearman: %.2f\np-valor: %.4f\n%s', rho, pval, texto_cambio);

    % === Paso 10: Gráfica ===
    figure('Color','w');
    b = bar([conteo_original; conteo_ponderado]', 'grouped');
    b(1).FaceColor = [0.4 0.4 0.4];    
    b(2).FaceColor = [0 0 0];         

    set(gca, 'XTickLabel', aspirantes, 'FontName', 'Times New Roman', 'FontSize', 12);
    set(gcf, 'Position', get(0, 'Screensize'));
    xlabel('Aspirantes', 'FontName', 'Times New Roman', 'FontSize', 12);
    ylabel('Frecuencia de Ganadores', 'FontName', 'Times New Roman', 'FontSize', 12);
    title('Resultados Ponderados de la Votación', 'FontName', 'Times New Roman', 'FontSize', 12);

    % Mostrar valores y jerarquías sobre cada barra
    xt = get(gca, 'XTick');
    for i = 1:n
        text(xt(i)-0.15, conteo_original(i) + max(conteo_original)*0.02, ...
            sprintf('%d (%d)', conteo_original(i), ranking_ori(i)), ...
            'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);

        text(xt(i)+0.15, conteo_ponderado(i) + max(conteo_ponderado)*0.02, ...
            sprintf('%d (%d)', conteo_ponderado(i), ranking_pond(i)), ...
            'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);

        if cambio(i)
            y_max = max(conteo_original(i), conteo_ponderado(i));
            text(xt(i), y_max + max(conteo_ponderado)*0.08, '*', ...
                'HorizontalAlignment', 'center', 'Color', 'red', ...
                'FontSize', 16, 'FontWeight', 'bold');
        end
    end

    % === Paso 11: Leyenda de ponderación ===
    texto_leyenda = sprintf('Ponderación:\nA = %d\nP = %d\nT = %d', A, P, T);
    annotation('textbox', [0.92, 0.5, 0.15, 0.2], ...
        'String', texto_leyenda, ...
        'FitBoxToText', 'on', ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'black', ...
        'FontName', 'Times New Roman', ...
        'FontSize', 10);

    % === Paso 12: Leyenda de correlación ===
    annotation('textbox', [0.908, 0.25, 0.15, 0.2], ...
        'String', texto_correlacion, ...
        'FitBoxToText', 'on', ...
        'BackgroundColor', 'white', ...
        'EdgeColor', 'black', ...
        'FontName', 'Times New Roman', ...
        'FontSize', 10);

    % === Paso 13: Leyenda de barras ===
    legend('Original', 'Ponderado', 'Location', 'northoutside', 'Orientation', 'horizontal');
end

%% Rutina original sin coeficiente de spearman

% function procesarGanadoresPonderados(A, P, T)
%     % A, P, T: número de veces que se desea que aparezca cada bloque (Alumnos, Profesores, Administrativos)
% 
%     % === Paso 1: Cargar archivo original ===
%     datos = load('ResultadosConcentrados.mat');
%     ganadores = datos.Ganadores;
% 
%     if length(ganadores) ~= 162
%         error('La matriz Ganadores debe tener exactamente 162 filas.');
%     end
% 
%     % === Paso 2: Separar bloques ===
%     bloqueA = ganadores(1:54);
%     bloqueP = ganadores(55:108);
%     bloqueT = ganadores(109:162);
% 
%     % === Paso 3: Replicar bloques según A, P, T ===
%     ganA_rep = repmat(bloqueA, A, 1);
%     ganP_rep = repmat(bloqueP, P, 1);
%     ganT_rep = repmat(bloqueT, T, 1);
% 
%     % === Paso 4: Concatenar bloques ===
%     GanadoresPonderados = [ganA_rep; ganP_rep; ganT_rep];
% 
%     % === Paso 5: Guardar archivo ===
%     save('GanadoresPonderados.mat', 'GanadoresPonderados');
% 
%     % === Paso 6: Obtener lista de aspirantes únicos ===
%     %aspirantes = unique(ganadores, 'stable');
%     aspirantes = unique(ganadores);
%     n = length(aspirantes);
% 
%     % === Paso 7: Contar frecuencias ===
%     conteo_original = zeros(1, n);
%     conteo_ponderado = zeros(1, n);
%     for i = 1:n
%         conteo_original(i) = sum(ganadores == aspirantes(i));
%         conteo_ponderado(i) = sum(GanadoresPonderados == aspirantes(i));
%     end
% 
%     % === Paso 8: Gráfica comparativa ===
%     
%     figure('Color','w');
%     b = bar([conteo_original; conteo_ponderado]', 'grouped');
%     b(1).FaceColor = [0.4 0.4 0.4];    % gris medio
%     b(2).FaceColor = [0 0 0]; % Negro
%     
%     
%     set(gca, 'XTickLabel', aspirantes, 'FontName', 'Times New Roman', 'FontSize', 12);
%     set(gcf, 'Position', get(0, 'Screensize'));
%     xlabel('Aspirantes', 'FontName', 'Times New Roman', 'FontSize', 12);
%     ylabel('Frecuencia de Ganadores', 'FontName', 'Times New Roman', 'FontSize', 12);
%     title('Resultados Ponderados de la Votación', 'FontName', 'Times New Roman', 'FontSize', 12);
% 
%     % Mostrar valores sobre las barras
%     xt = get(gca, 'XTick');
%     for i = 1:n
%         text(xt(i)-0.15, conteo_original(i) + max(conteo_original)*0.02, ...
%             num2str(conteo_original(i)), 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);
%         text(xt(i)+0.15, conteo_ponderado(i) + max(conteo_ponderado)*0.02, ...
%             num2str(conteo_ponderado(i)), 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);
%     end
% 
%     % Leyenda con información de A, P, T
%     texto_leyenda = sprintf('Ponderación:\nA = %d\nP = %d\nT = %d', A, P, T);
%     annotation('textbox', [0.92, 0.5, 0.15, 0.2], ...
%                'String', texto_leyenda, ...
%                'FitBoxToText', 'on', ...
%                'BackgroundColor', 'white', ...
%                'EdgeColor', 'black', ...
%                'FontName', 'Times New Roman', ...
%                'FontSize', 10);
%            
%     % Leyenda normal para barras
%     legend('Original', 'Ponderado', 'Location', 'northoutside', 'Orientation', 'horizontal');
% end
