% Número de aspirantes
% Aspirantes = 5; %Solo usar en pruebas locales de la rutina, pero comentar
% en la prueba global

% Texto_encabezados = 'Alumnos';
% Texto_encabezados = 'Profesores';
% Texto_encabezados = 'Administrativos';

% Generar valores aleatorios base entre 0 y 1
orden_favoritismo = rand(1, Aspirantes)

% % Selecciona los favoritos por sector Comentar en la rutina globlal y no
% % acerlo en pruebas locales
% 
% switch Texto_encabezados
%     case 'Profesores'
%         favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
%         favoritos=[favoritos1,fuertes(:,2)] % Genera la matriz de preferencia 
%         
% %         favoritos = [
% %      1, 1;   % Aspirante 1 con el 1 de peso
% %      2, 1;  % Aspirante 2 con peso 2
% %      3, 1;   % Aspirante 3 con el 3 de peso
% %      4, 1;  % Aspirante 4 con peso 4
% %      5, 1;   % Aspirante 5 con 1 de peso
% % ];        
%         
%     case 'Administrativos'
%         favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
%         favoritos=[favoritos1,fuertes(:,3)] % Genera la matriz de preferencia 
%         
% %         favoritos = [
% %      1, 1;   % Aspirante 1 con el 1 de peso
% %      2, 1  % Aspirante 2 con peso 2
% %      3, 1;   % Aspirante 3 con el 3 de peso
% %      4, 1;  % Aspirante 4 con peso 4
% %      5, 1;   % Aspirante 5 con 1 de peso
% % ];
% 
%     otherwise % Favoritos para alumnos
%          favoritos1=(1:size(fuertes,1))'; % Vector columna auxiliar con el número de aspirantes
%          favoritos=[favoritos1,fuertes(:,1)] % Genera la matriz de preferencia 
%         
% %         favoritos = [
% %      1, 1;   % Aspirante 1 con el 1 de peso
% %      2, 1;  % Aspirante 2 con peso 2
% %      3, 1;   % Aspirante 3 con el 3 de peso
% %      4, 1;  % Aspirante 4 con peso 4
% %      5, 1;   % Aspirante 5 con 1 de peso
% % ];
% 
% end
% 


% === Definir favoritos manualmente ===
% Estructura: [índice, peso]; puedes poner varios

% favoritos = [
%      1, 1;   % Aspirante 1 con el 1 de peso
%      2, 1  % Aspirante 2 con peso 2
%      3, 1;   % Aspirante 3 con el 3 de peso
%      4, 4;  % Aspirante 4 con peso 4
%      5, 1;   % Aspirante 5 con 1 de peso
% ];

% Aplicar pesos adicionales a favoritos
for iii = 1:size(favoritos, 1)
    idx = favoritos(iii, 1);
    peso_extra = favoritos(iii, 2);
    orden_favoritismo(idx) = orden_favoritismo(idx) * peso_extra;
end

%Normalizar para que todos los valores estén en la escala 0-1 (opcional)
orden_favoritismo = orden_favoritismo / max(orden_favoritismo);

% Mostrar resultado
% disp('Vector orden_favoritismo generado:');
% disp(orden_favoritismo);