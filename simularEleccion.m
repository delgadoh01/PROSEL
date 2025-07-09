function [votos, total_votaron] = simularEleccion(padron_total, n)

    % Obtener el valor de 'Texto_encabezados' desde el workspace base
    Texto_encabezados = evalin('base', 'Texto_encabezados');
    media_participacion_alumnos = evalin('base', 'media_participacion_alumnos');
    media_participacion_profesores = evalin('base', 'media_participacion_profesores');
    media_participacion_administrativos = evalin('base', 'media_participacion_administrativos');

    % Definir parámetros de participación según el sector
    switch Texto_encabezados
        case 'Profesores'
            %media_participacion = 0.7;
            media_participacion = media_participacion_alumnos;
            desviacion_participacion = 0.2 * media_participacion;
        case 'Administrativos'
            %media_participacion = 1.0;
            media_participacion = media_participacion_administrativos;
            desviacion_participacion = 0.2 * media_participacion;
        otherwise  % Alumnos por defecto
            %media_participacion = 0.4;
            media_participacion = media_participacion_alumnos;
            desviacion_participacion = 0.3 * media_participacion;
    end

    % Generar porcentaje de participación aleatorio dentro del rango [0,1]
    participacion = min(max(normrnd(media_participacion, desviacion_participacion), 0), 1); 

    % Calcular número total de votantes
    total_votaron = round(padron_total * participacion);

    % Generar pesos aleatorios y normalizar
    pesos = rand(1, n);
    pesos = pesos / sum(pesos);

    % Asignar votos según los pesos
    votos = floor(pesos * total_votaron);

    % Ajustar la diferencia por redondeo
    diferencia = total_votaron - sum(votos);
    if diferencia > 0
        [~, orden] = sort(pesos, 'descend');
        for iii = 1:diferencia
            votos(orden(iii)) = votos(orden(iii)) + 1;
        end
    end

%     % Mostrar resultados
%     fprintf('Participación: %.2f%% (%d de %d electores)\n', participacion * 100, total_votaron, padron_total);
%     disp('Votos por candidato:');
%     disp(votos);

end


%% Funcion original

% function [votos, total_votaron] = simularEleccion(padron_total, n)
% 
% switch Texto_encabezados
%     case 'Profesores' % Porcentajes de participación de Profesores
%         media_participacion = 0.7;
%         desviacion_participacion = 0.2*media_participacion;
% 
%     case 'Administrativos' % Porcentajes de participación de Administrativos
%         media_participacion = 1;
%         desviacion_participacion = 0.2*media_participacion;
% 
%     otherwise % Porcentajes de participación de Alumnos
%         media_participacion = 0.4; 
%         desviacion_participacion = 0.3*media_participacion;
% 
% end
% 
%     % 1. Generar porcentaje de participación con N(0.6, 0.2), acotado entre 0 y 1
%     %participacion = min(max(normrnd(0.6, 0.2), 0), 1);
%     participacion = min(max(normrnd(media_participacion, desviacion_participacion), 0), 1); 
%     
%     
%     % 2. Calcular número de votantes reales
%     total_votaron = round(padron_total * participacion);
% 
%     % 3. Generar pesos aleatorios positivos para los candidatos
%     pesos = rand(1, n);  % valores aleatorios entre 0 y 1
%     pesos = pesos / sum(pesos);  % normalizar para que sumen 1
% 
%     % 4. Asignar votos proporcionales
%     votos = floor(pesos * total_votaron);
% 
%     % 5. Ajustar la suma exacta (corregir votos faltantes por redondeo)
%     diferencia = total_votaron - sum(votos);
%     if diferencia > 0
%         [~, orden] = sort(pesos, 'descend');
%         for i = 1:diferencia
%             votos(orden(i)) = votos(orden(i)) + 1;
%         end
%     end
% 
%     % Mostrar resultados
%     fprintf('Participación: %.2f%% (%d de %d electores)\n', ...
%         participacion*100, total_votaron, padron_total);
%     disp('Votos por candidato:');
%     disp(votos);
% 
% end
