function generarReglasFuzzy()

    % Pesos para la suma producto
    pesos = [0.11, 0.14, 0.19, 0.04, 0.26, 0.22, 0.04];

    % Generar todas las combinaciones posibles de [1 1 1 1 1 1 1] a [3 3 3 3 3 3 3]
    [X1, X2, X3, X4, X5, X6, X7] = ndgrid(1:3, 1:3, 1:3, 1:3, 1:3, 1:3, 1:3);
    combinaciones = [X1(:), X2(:), X3(:), X4(:), X5(:), X6(:), X7(:)];

    % Inicializar la matriz de reglas
    numReglas = size(combinaciones, 1);
    reglas = zeros(numReglas, 10);  % 7 de antecedente + 1 de consecuencia + 2 extras

    for i = 1:numReglas
        antecedente = combinaciones(i, :);

        % Suma producto
        salida = sum(antecedente .* pesos);

        % Normalizar a [0, 1] (mínimo posible: 1, máximo: 3)
        salida_normalizada = (salida - 1) / (3 - 1);

        % Construir la regla
        reglas(i, :) = [antecedente, salida_normalizada, 1, 1]; % columnas 3 y 4: fijos en 1
    end

    % Guardar como archivo de texto
    archivo = 'FuzzyRector2025a.rule';
    fid = fopen(archivo, 'w');

    fprintf(fid, '%% Fuzzy Logic Ruleset: FuzzyRector2025a\n');
    fprintf(fid, '%% Format: [antecedent1 antecedent2 ... antecedent7 consequent weight1 weight2]\n\n');

    for i = 1:numReglas
        fprintf(fid, '[%d %d %d %d %d %d %d %.4f %d %d]\n', ...
            reglas(i, 1), reglas(i, 2), reglas(i, 3), reglas(i, 4), reglas(i, 5), ...
            reglas(i, 6), reglas(i, 7), reglas(i, 8), reglas(i, 9), reglas(i, 10));
    end

    fclose(fid);

    disp(['Archivo de reglas generado exitosamente: ', archivo]);

end
