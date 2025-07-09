function graficarVotosPorEspacio(Espacios, Votos_por_espacio, Ganadores)

    % Validación básica
    if length(Espacios) ~= 162 || size(Votos_por_espacio,1) ~= 162 || length(Ganadores) ~= 162
        error('Todas las variables deben tener 162 filas.');
    end

    % Sectores
    sectores = {'Alumnos', 'Profesores', 'Administrativos'};
    indices_base = [1, 55, 109];

    % Normalizar la matriz de votos por fila
    Votos_normalizados = Votos_por_espacio ./ sum(Votos_por_espacio, 2);

    % Para cada espacio (1 a 54)
    for i = 1:54
        % Índices actuales
        idx = indices_base + (i - 1);

        % Obtener máximo de cada fila
        valores_maximos = max(Votos_por_espacio(idx, :), [], 2);
        porcentajes = max(Votos_normalizados(idx, :), [], 2);  % Normalizados

        % Crear gráfica
        figure('Color','w');
        grid on;
        grid minor;
        b = bar(valores_maximos, 'FaceColor', 'flat');

        % Escala de grises
        colormap(gray(3));
        b.CData = gray(3);  % Cada barra diferente tono de gris

        % Ejes y título
        set(gca, 'XTickLabel', sectores, 'FontName','Times New Roman','FontSize', 12);
        set(gcf, 'Position', get(0, 'Screensize'));
        ylabel('Votos máximos', 'FontName','Times New Roman','FontSize', 12 );
        xlabel('Sector', 'FontName','Times New Roman','FontSize', 12);
        title("Espacio: " + Espacios{i});

        % Añadir etiquetas de porcentaje sobre cada barra
        for j = 1:3
            text(j, valores_maximos(j) + max(valores_maximos)*0.05, ...
                sprintf('%.1f%%', porcentajes(j)*100), ...
                'HorizontalAlignment', 'center', 'FontSize', 9);
        end

        % Leyenda de ganadores
        leyenda = sprintf('Ganador Alumnos = %s,\nGanador Profesores = %s,\nGanador Administrativos = %s', ...
            Ganadores{idx(1)}, Ganadores{idx(2)}, Ganadores{idx(3)});
        legend(leyenda, 'Location', 'northeastoutside');

        % Opcional: pausar o guardar figura
        pause(0.2); % Quitar si se van a guardar automáticamente
        % saveas(gcf, sprintf('Grafica_Espacio_%02d.png', i));  % opcional
    end

    disp('Se han generado las 54 gráficas de votación por espacio.');

end

