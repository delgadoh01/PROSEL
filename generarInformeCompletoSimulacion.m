function generarInformeCompletoSimulacion()

    % Nombre del PDF de salida
    nombrePDF = 'SimulacionRectorInforme.pdf';
    if exist(nombrePDF, 'file')
        delete(nombrePDF);
    end

    % 1. Simulaciones por sector
    sectores = {'Alumnos', 'Profesores', 'Administrativos'};
    for i = 1:length(sectores)
        Texto_encabezados = sectores{i}; %#ok<NASGU>
        close all;
        SimulacionRector2025_9Jun25;  % Genera 54 figuras

        % Guardar todas las figuras de esta ejecución
        figs = findall(0, 'Type', 'figure');
        figs = sort(figs); % Asegurar orden
        for j = 1:length(figs)
            figure(figs(j));
            if i == 1 && j == 1
                print(figs(j), nombrePDF, '-dpdf', '-bestfit');
            else
                print(figs(j), nombrePDF, '-dpdf', '-append');
            end
            close(figs(j));
        end
    end

    % 2. unirResultados (no se guarda en el PDF)
    unirResultados;

    % 3. graficarVotosPorEspacio
    Espacios = {'Fac1','Fac2','Fac3'}; % ejemplo
    Votos_por_espacio = [500, 300, 700];
    Ganadores = {'Asp1','Asp2','Asp1'};
    close all;
    graficarVotosPorEspacio(Espacios, Votos_por_espacio, Ganadores);
    guardarFiguraComoPDF(nombrePDF);

    % 4. graficarComparativaAspirantes
    VotosAspiranteGanador = [700, 600, 550];
    Total_de_Votos_finales = 1850;
    close all;
    graficarComparativaAspirantes(VotosAspiranteGanador, Total_de_Votos_finales);
    guardarFiguraComoPDF(nombrePDF);

    % 5. analisisEntropico
    M = [ ...
        98331	24	4	0.00054917	0.7	5	100	20;
        7518	36	30	0.0072	0.6	10	100	50;
        4601	48	35	0.00043469	0.66	20	80	300];
    close all;
    analisisEntropico(M);
    guardarFiguraComoPDF(nombrePDF);

    % 6. procesarResultadosPonderados
    A = 1; P = 1; T = 1;
    close all;
    procesarResultadosPonderados(A, P, T);
    guardarFiguraComoPDF(nombrePDF);

    % 7. procesarGanadoresPonderados
    close all;
    procesarGanadoresPonderados(A, P, T);
    guardarFiguraComoPDF(nombrePDF);

    disp(['? Informe completo generado: ' nombrePDF]);

end

% %% Auxiliar para guardar figura actual en el PDF
% function guardarFiguraComoPDF(nombrePDF)
%     fig = gcf;
%     if ~exist(nombrePDF, 'file')
%         print(fig, nombrePDF, '-dpdf', '-bestfit');
%     else
%         print(fig, nombrePDF, '-dpdf', '-append');
%     end
%     close(fig);
% end
