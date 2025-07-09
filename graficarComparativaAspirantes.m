function graficarComparativaAspirantes(VotosAspiranteGanador, Total_de_Votos_finales)

    % Validación
    if length(VotosAspiranteGanador) ~= length(Total_de_Votos_finales)
        error('Ambos vectores deben tener la misma longitud.');
    end

    n = length(VotosAspiranteGanador);
    etiquetas = "Aspirante " + string(1:n);

    figure('Color','w', 'Position', [100, 100, 1000, 400]);

    % === Gráfica izquierda ===
    subplot(1, 2, 1);
    b1 = bar(VotosAspiranteGanador, 'FaceColor', [0.3 0.3 0.3]);
    title('Votos del Aspirante Ganador',  'FontName','Times New Roman','FontSize', 12);
    set(gca, 'XTick', 1:n, 'XTickLabel', etiquetas, 'XTickLabelRotation', 45, 'FontName','Times New Roman','FontSize', 12);
    set(gcf, 'Position', get(0, 'Screensize'));
    ylabel('Votos por espacio académico', 'FontName','Times New Roman','FontSize', 12);
    ylim([0, max(VotosAspiranteGanador) * 1.2]);

    % Añadir etiquetas numéricas sobre las barras
    for i = 1:n
        text(i, VotosAspiranteGanador(i) + max(VotosAspiranteGanador)*0.05, ...
            num2str(VotosAspiranteGanador(i)), ...
            'HorizontalAlignment', 'center', 'FontSize', 9);
    end

    % === Gráfica derecha ===
    subplot(1, 2, 2);
    b2 = bar(Total_de_Votos_finales, 'FaceColor', [0.6 0.6 0.6]);
    title('Total de Votos Finales', 'FontName','Times New Roman','FontSize', 12);
    set(gca, 'XTick', 1:n, 'XTickLabel', etiquetas, 'XTickLabelRotation', 45, 'FontName','Times New Roman','FontSize', 12);
    set(gcf, 'Position', get(0, 'Screensize'));
    ylabel('Votos individuales', 'FontName','Times New Roman','FontSize', 12);
    ylim([0, max(Total_de_Votos_finales) * 1.2]);

    for i = 1:n
        text(i, Total_de_Votos_finales(i) + max(Total_de_Votos_finales)*0.05, ...
            num2str(Total_de_Votos_finales(i)), ...
            'HorizontalAlignment', 'center', 'FontSize', 9);
    end

end
