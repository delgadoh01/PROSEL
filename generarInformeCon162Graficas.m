function generarInformeCon162Graficas()

    % Nombre del PDF de salida
    nombrePDF = 'SimulacionRectorInforme.pdf';

    % Eliminar el PDF anterior si existe
    if exist(nombrePDF, 'file')
        delete(nombrePDF);
    end

    % Valores de Texto_encabezados
    categorias = {'Alumnos', 'Profesores', 'Administrativos'};

    % Recorre cada categoría
    for i = 1:length(categorias)
        Texto_encabezados = categorias{i}; %#ok<NASGU>
        close all; % Cerrar cualquier figura abierta previamente

        % Ejecutar script (debe generar 54 figuras)
        SimulacionRector2025_9Jun25;

        % Obtener handles de las figuras generadas
        figs = findall(0, 'Type', 'figure');
        figs = sort(figs); % Asegurar orden

        % Guardar cada figura como página del PDF
        for j = 1:length(figs)
            figure(figs(j)); % Traer figura al frente
            if i == 1 && j == 1
                print(figs(j), nombrePDF, '-dpdf', '-bestfit'); % Primera página
            else
                print(figs(j), nombrePDF, '-dpdf', '-append');  % Páginas siguientes
            end
            close(figs(j)); % Cerrar figura después de guardar
        end
    end

    disp(['Informe generado con 162 gráficas en: ' nombrePDF]);

end
