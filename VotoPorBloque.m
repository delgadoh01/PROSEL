% Número de aspirantes definido por el usuario
%n= 5 % Ejemplo de número inicial de aspirantes
n = Aspirantes;
%Aspirantes = rand(1, n);  % valores aleatorios base

%% Bloques definidos por el usuario
%  bloques = {
%  %     1, [ ];
%  %     2, [ ];
%       1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];      % Bloque 1 ? posición 1
%     2, [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];      % Bloque 2 ? posición 2
%     3, [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];              % Bloque 3 ? posición 3
% };

% Validar que las posiciones fijas estén dentro del rango válido
for b = 1:size(bloques, 1)
    pos = bloques{b, 1};
    if pos < 1 || pos > n
        error('Posición fija inválida en el bloque %d: %d (debe estar entre 1 y %d).', ...
              b, pos, n);
    end
end

% Total de iteraciones
total_iteraciones = 54;

% Inicializar celda para almacenar los vectores
favoritos_celda = cell(total_iteraciones, 1);

% Generar vectores por iteración
for i = 1:total_iteraciones
    favorito = rand(1, n);  % por defecto, todos aleatorios
    asignado = false;
    
    for b = 1:size(bloques, 1)
        pos_fija = bloques{b, 1};
        iteraciones = bloques{b, 2};
        
        if ismember(i, iteraciones)
            favorito = rand(1, n);
            favorito(pos_fija) = 1;  % asigna el 1 en la posición fija
            asignado = true;
            break;
        end
    end
    
    favoritos_celda{i} = favorito;
end

% Mostrar resultados por bloque
for b = 1:size(bloques, 1)
    pos_fija = bloques{b, 1};
    iteraciones = bloques{b, 2};
    fprintf('\nResultados del bloque %d (posición fija del 1: %d):\n', b, pos_fija);
    
    for i = iteraciones
        fprintf('favoritos(%2d) = [', i);
        fprintf('%.2f ', favoritos_celda{i});
        fprintf(']\n');
    end
end