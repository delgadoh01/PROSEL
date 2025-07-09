function procesarResultadosPonderados(A, P, T)
    % A, P, T: pesos enteros relativos para Alumnos, Profesores y Trabajadores

    % === Paso 1: Cargar datos originales ===
    datos = load('ResultadosConcentrados.mat');
    votos = datos.Votos_por_espacio;  % 162 x n

    [total_filas, n] = size(votos);
    if total_filas ~= 162
        error('La matriz Votos_por_espacio debe tener 162 filas.');
    end

    % === Paso 2: Separar por bloques ===
    bloqueA = votos(1:54, :);
    bloqueP = votos(55:108, :);
    bloqueT = votos(109:162, :);

    % === Paso 3: Ponderación ===
    wA = A; wP = P; wT = T;
    bloqueA_pond = bloqueA * wA;
    bloqueP_pond = bloqueP * wP;
    bloqueT_pond = bloqueT * wT;

    Votos_ponderados = [bloqueA_pond; bloqueP_pond; bloqueT_pond];
    save('ResultadosPonderadosPorSector.mat', 'Votos_ponderados');

    % === Paso 4: Totales por aspirante ===
    total_original = sum(votos, 1);           
    total_ponderado = sum(Votos_ponderados, 1);

    % === Paso 5: Correlación Spearman ===
    [rho, pval] = corr(total_original', total_ponderado', 'Type', 'Spearman');
    hay_cambio = pval < 0.05;
    texto_cambio = 'Cambia jerarquía';
    if hay_cambio
        texto_cambio = 'No cambia jerarquía';
    end
    texto_correlacion = sprintf('Coef. Spearman: %.2f\np-valor: %.4f\n%s', rho, pval, texto_cambio);

    % === Paso 6: Ranking ===
    [~, orden_ori] = sort(total_original, 'descend');
    [~, orden_pond] = sort(total_ponderado, 'descend');

    ranking_ori = zeros(1, n);
    ranking_pond = zeros(1, n);
    for i = 1:n
        ranking_ori(orden_ori(i)) = i;
        ranking_pond(orden_pond(i)) = i;
    end

    cambio_ranking = ranking_ori ~= ranking_pond;

    % === Paso 7: Gráfica ===
    aspirantes = "Aspirante " + string(1:n);
    figure('Color','w');
    b = bar([total_original; total_ponderado]', 'grouped');
    b(1).FaceColor = [0.5 0.5 0.5];
    b(2).FaceColor = [0 0 0];

    title('Resultados Ponderados de la Votación');
    ylabel('Votos obtenidos', 'FontName', 'Times New Roman', 'FontSize', 12);
    set(gca, 'XTickLabel', aspirantes, 'FontName', 'Times New Roman', 'FontSize', 12);
    set(gcf, 'Position', get(0, 'Screensize'));
    legend('Original', 'Ponderado', 'Location', 'northoutside', 'Orientation', 'horizontal');

    % Mostrar valores + jerarquías sobre barras
    xt = get(gca, 'XTick');
    for i = 1:n
        text(xt(i)-0.15, total_original(i)+max(total_original)*0.02, ...
            sprintf('%d (%d)', total_original(i), ranking_ori(i)), ...
            'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);

        text(xt(i)+0.15, total_ponderado(i)+max(total_original)*0.02, ...
            sprintf('%d (%d)', total_ponderado(i), ranking_pond(i)), ...
            'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);

        if cambio_ranking(i)
            y_max = max(total_original(i), total_ponderado(i));
            text(xt(i), y_max + max(total_original)*0.08, '*', ...
                'HorizontalAlignment', 'center', 'Color', 'red', ...
                'FontSize', 16, 'FontWeight', 'bold');
        end
    end

    % === Paso 8: Anotaciones laterales ===
    texto_leyenda = sprintf('Ponderación:\nA = %d\nP = %d\nT = %d', A, P, T);
    annotation('textbox', [0.92, 0.5, 0.15, 0.2], ...
               'String', texto_leyenda, ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'white', ...
               'EdgeColor', 'black', ...
               'FontName', 'Times New Roman', ...
               'FontSize', 10);

    annotation('textbox', [0.908, 0.25, 0.15, 0.2], ...
               'String', texto_correlacion, ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'white', ...
               'EdgeColor', 'black', ...
               'FontName', 'Times New Roman', ...
               'FontSize', 10);
end


%% Función original sin coeficiente de Spearman

% function procesarResultadosPonderados(A, P, T)
%     % A, P, T: pesos enteros relativos para Alumnos, Profesores y Trabajadores
% 
%     % === Paso 1: Cargar datos originales ===
%     datos = load('ResultadosConcentrados.mat');
%     votos = datos.Votos_por_espacio;  % 162 x n
% 
%     [total_filas, n] = size(votos);  % n: número de aspirantes
%     if total_filas ~= 162
%         error('La matriz Votos_por_espacio debe tener 162 filas.');
%     end
% 
%     % === Paso 2: Separar por bloques ===
%     bloqueA = votos(1:54, :);
%     bloqueP = votos(55:108, :);
%     bloqueT = votos(109:162, :);
% 
%     % === Paso 3: Calcular ponderaciones como proporciones ===
% %     total_peso = A + P + T;
% %     wA = A / total_peso;
% %     wP = P / total_peso;
% %     wT = T / total_peso;
% 
%     total_peso = A + P + T;
%     wA = A ;
%     wP = P ;
%     wT = T ;
%     
%     % === Paso 4: Aplicar ponderaciones ===
%     bloqueA_pond = bloqueA * wA;
%     bloqueP_pond = bloqueP * wP;
%     bloqueT_pond = bloqueT * wT;
% 
%     % === Paso 5: Unir bloques y guardar archivo ===
%     Votos_ponderados = [bloqueA_pond; bloqueP_pond; bloqueT_pond];
%     save('ResultadosPonderadosPorSector.mat', 'Votos_ponderados');
% 
%     % === Paso 6: Calcular totales por aspirante ===
%     total_original = sum(votos, 1);           % 1 x n
%     total_ponderado = sum(Votos_ponderados, 1); % 1 x n
%     
%    
%        % === Paso 7: Graficar resultados comparativos en escala de grises ===
%     aspirantes = "Aspirante " + string(1:n);
%     figure('Color','w');
%   
%     b = bar([total_original; total_ponderado]', 'grouped');
% 
%     % Colores en escala de grises
%     b(1).FaceColor = [0.5 0.5 0.5];   % gris medio para original
% %    b(2).FaceColor = [0.8 0.8 0.8];   % gris claro para ponderado
%     b(2).FaceColor = [0 0 0];   % negro para ponderado
% 
%     
%     title('Resultados Ponderados de la Votación');
%     ylabel('Votos obtenidos', 'FontName', 'Times New Roman', 'FontSize', 12);
%     set(gca, 'XTickLabel', aspirantes, 'FontName', 'Times New Roman', 'FontSize', 12);
%     set(gcf, 'Position', get(0, 'Screensize'));
%     legend('Original', 'Ponderado', 'Location', 'northoutside', 'Orientation', 'horizontal');
% 
%     % Mostrar valores sobre cada barra
%     xt = get(gca, 'XTick');
%     for i = 1:n
%         text(xt(i)-0.15, total_original(i)+max(total_original)*0.02, ...
%             num2str(total_original(i)), 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);
%         text(xt(i)+0.15, total_ponderado(i)+max(total_original)*0.02, ...
%             num2str(total_ponderado(i)), 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman', 'FontSize', 9);
%     end
% 
%      % Leyenda con información de A, P, T
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
%     
% end
