%% === PROGRAMA INTEGRADO DE ORDEN DE FAVORITISMO ===
% Requiere:
% - Aspirantes (scalar)
% - bloques (celda: {posición fija, [iteraciones]})
% - fuertes (Aspirantes x 3)
% - Texto_encabezados: 'Alumnos', 'Profesores' o 'Administrativos'

%% === CONFIGURACIÓN GENERAL ===
guardar_graficas = true;       % ? Cambia a true si deseas guardar archivos
graficar_resultados = false;     % ? Cambia a false si NO deseas mostrar gráficas

%% === PARTE 1: Inicialización ===
n = Aspirantes;
total_iteraciones = 54;

% Validación de posiciones fijas
for bbb = 1:size(bloques, 1)
    pos = bloques{bbb, 1};
    if pos < 1 || pos > n
        error('Posición fija inválida en el bloque %d: %d (debe estar entre 1 y %d).', ...
              bbb, pos, n);
    end
end

%% === PARTE 2: Preferencias por bloque ===
favoritos_celda = cell(total_iteraciones, 1);
for iii = 1:total_iteraciones
    favorito = rand(1, n);
    for bbb = 1:size(bloques, 1)
        pos_fija = bloques{bbb, 1};
        iteraciones = bloques{bbb, 2};
        if ismember(iii, iteraciones)
            favorito(pos_fija) = 1;
        end
    end
    favoritos_celda{iii} = favorito;
end

%% === PARTE 3: Preferencias sectoriales ===
switch Texto_encabezados
    case 'Profesores'
        favoritos = [(1:n)', fuertes(:,2)];
    case 'Administrativos'
        favoritos = [(1:n)', fuertes(:,3)];
    otherwise
        favoritos = [(1:n)', fuertes(:,1)];
end

%% === PARTE 4: Fusión bloque + sector ===
orden_favoritismo_iteraciones = cell(total_iteraciones, 1);
for iii = 1:total_iteraciones
    vector_base = favoritos_celda{iii};
    vector_sector = ones(1, n);
    for jjj = 1:size(favoritos, 1)
        idx = favoritos(jjj, 1);
        peso = favoritos(jjj, 2);
        vector_sector(idx) = peso;
    end
    orden = vector_base .* vector_sector;
    orden = orden / max(orden);
    orden_favoritismo_iteraciones{iii} = orden;
end

%% === PARTE 5: Consolidación ===
orden_favoritismo = zeros(total_iteraciones, n);
for iii = 1:total_iteraciones
    orden_favoritismo(iii,:) = orden_favoritismo_iteraciones{iii};
end

%% === PARTE 6: Gráficas si se desea ===
if graficar_resultados
    orden_promedio = mean(orden_favoritismo, 1);
    [~, ranking] = sort(orden_promedio, 'descend');

    % Gráfica de Barras
    figure('Color','w');
    bar(orden_promedio, 'FaceColor', [0.5 0.5 0.5]);

    xlabel('Aspirantes', 'FontName', 'Times New Roman', 'FontSize', 12);
    ylabel('Nivel de Favoritismo Normalizado', 'FontName', 'Times New Roman', 'FontSize', 12);
    title(['Orden de Favoritismo Promedio - Sector: ', Texto_encabezados], ...
          'FontName', 'Times New Roman', 'FontSize', 12);

    xticklabels(arrayfun(@(k) ['A' num2str(k)], 1:n, 'UniformOutput', false));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    grid on;

    for kkk = 1:n
        rank_kkk = find(ranking == kkk);
        txt = sprintf('%.2f (%d)', orden_promedio(kkk), rank_kkk);
        text(kkk, orden_promedio(kkk) + 0.02, txt, ...
            'HorizontalAlignment', 'center', ...
            'FontName', 'Times New Roman', 'FontSize', 12);
    end

    % Boxplot de Variabilidad
    figure('Color','w');
    boxplot(orden_favoritismo, 'Labels', arrayfun(@(k) ['A' num2str(k)], 1:n, 'UniformOutput', false));
    title(['Variabilidad del Orden de Favoritismo - Sector: ', Texto_encabezados], ...
          'FontName', 'Times New Roman', 'FontSize', 12);
    ylabel('Valor Normalizado', 'FontName', 'Times New Roman', 'FontSize', 12);
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    grid on;
end

%% === PARTE 7: Guardado automático (si aplica) ===
if guardar_graficas
    carpeta = fullfile(pwd, 'Graficas');
    if ~exist(carpeta, 'dir')
        mkdir(carpeta);
    end

    base = fullfile(carpeta, ['Favoritismo_', Texto_encabezados]);
    saveas(figure(1), [base, '_barras.png']);
    print(figure(1), [base, '_barras.pdf'], '-dpdf', '-bestfit');

    saveas(figure(2), [base, '_boxplot.png']);
    print(figure(2), [base, '_boxplot.pdf'], '-dpdf', '-bestfit');

    disp(['Gráficas guardadas en: ', carpeta]);
end

%% === Parte 8: Asignación final de orden promedio al workspace ===
orden_favoritismo = mean(orden_favoritismo, 1);
orden_favoritismo = orden_favoritismo / max(orden_favoritismo)  % Normalización
