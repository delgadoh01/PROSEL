% function IVR = calcular_IVR(popularidad, criterio, alpha)
% calcular_IVR - Calcula el Índice de Viabilidad Rectoral para n candidatos
%
% Entradas:
%   popularidad - vector columna de popularidad en porcentaje (%), suma debe ser 100
%   criterio    - vector columna de calificación multicriterio (valores entre 0 y 1)
%   alpha       - peso asignado a la popularidad (valor entre 0 y 1)
%
% Salida:
%   IVR         - vector columna con el índice IVR para cada candidato

% Ejemplo
% Datos de entrada
 popularidad = [45; 35; 20];  % En porcentaje
 criterio = [0.82; 0.91; 0.75];  % Normalizado entre 0 y 1
 alpha = 0.6;
% 
% Calcular IVR
% IVR = calcular_IVR(popularidad, criterio, alpha);


    % Validaciones básicas
    if length(popularidad) ~= length(criterio)
        error('Los vectores de popularidad y criterio deben tener el mismo tamaño.');
    end
    if any(popularidad < 0) || any(popularidad > 100)
        error('La popularidad debe estar en porcentaje (0 a 100).');
    end
    if any(criterio < 0) || any(criterio > 1)
        error('Las calificaciones del análisis multicriterio deben estar entre 0 y 1.');
    end
    if alpha < 0 || alpha > 1
        error('El valor de alpha debe estar entre 0 y 1.');
    end

    % Normalizar la popularidad
    P = popularidad / 100;

    % Calcular el índice IVR
    IVR = alpha .* P + (1 - alpha) .* criterio

    % Mostrar resultados en consola
%     T = table((1:length(IVR))', popularidad, criterio, IVR, ...
%         'VariableNames', {'Candidato', 'Popularidad_%', 'Criterio', 'IVR'});
%     disp(T);

%end