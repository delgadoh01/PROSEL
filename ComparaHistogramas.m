% Script: CompararHistogramas_TTest_Boxplot.m
% Autor: GPT adaptado para David Joaquín
% Descripción: 
%   - Grafica histogramas con curvas normales.
%   - Realiza pruebas t (ttest2) entre todas las columnas.
%   - Muestra un boxplot para comparar gráficamente la dispersión.

clc; clear; close all;

% --------- GENERACIÓN O CARGA DE DATOS ---------
% Simulación de ejemplo (puedes reemplazar por tu propia matriz de datos)
Datos = [randn(1000,1)*2+10, randn(1000,1)*3+15, randn(1000,1)*7+35, randn(1000,1)*2.2+10];

[~, nColumnas] = size(Datos);
colores = lines(nColumnas);  % paleta para gráficas

%% --------- FIGURA 1: Histogramas con curvas normales ---------
figure('Name','Histogramas y Distribuciones Normales','NumberTitle','off');
hold on; grid on;
nbins = 30;
leyendas = cell(1,nColumnas);

for i = 1:nColumnas
    datos_col = Datos(:,i);

    % Histograma normalizado
    histogram(datos_col, nbins, 'Normalization', 'pdf', ...
              'FaceAlpha', 0.3, 'EdgeColor', 'none', ...
              'FaceColor', colores(i,:));
    
    % Curva normal
    mu = mean(datos_col);
    sigma = std(datos_col);
    x_vals = linspace(min(datos_col), max(datos_col), 200);
    y_vals = normpdf(x_vals, mu, sigma);
    plot(x_vals, y_vals, 'Color', colores(i,:), 'LineWidth', 2);
    
    leyendas{i} = sprintf('Col %d: \\mu=%.2f, \\sigma=%.2f', i, mu, sigma);
end

xlabel('Valor'); ylabel('Densidad de probabilidad');
title('Histogramas superpuestos con curvas normales');
legend(leyendas, 'Location', 'best');
hold off;

%% --------- FIGURA 2: Diagrama de cajas (boxplot) ---------
figure('Name','Boxplots Comparativos','NumberTitle','off');
boxplot(Datos, 'Colors', colores(1:nColumnas,:), 'Symbol','r+');
title('Diagrama de cajas por variable');
xlabel('Variable (columna)');
ylabel('Valor');
grid on;

%% --------- PRUEBAS T ENTRE TODAS LAS COLUMNAS ---------
fprintf('\n---- Comparación de medias con prueba t (ttest2) ----\n');
alpha = 0.05; % Nivel de significancia

for i = 1:nColumnas-1
    for j = i+1:nColumnas
        x = Datos(:,i);
        y = Datos(:,j);
        
        [h, p] = ttest2(x, y, 'Alpha', alpha);
        
        if h == 0
            resultado = 'NO hay diferencia significativa';
        else
            resultado = 'SÍ hay diferencia significativa';
        end
        
        fprintf('Columna %d vs Columna %d: p = %.4f / %s en las medias (al %.2f%%)\n', ...
                i, j, p, resultado, 100*alpha);
    end
end
