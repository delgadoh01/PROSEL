function guardarFiguraComoPDF(nombrePDF, crearNuevo)
    fig = gcf;  % Obtener figura actual
    if crearNuevo
        print(fig, nombrePDF, '-dpdf', '-bestfit'); % Crear PDF nuevo
    else
        print(fig, nombrePDF, '-dpdf', '-append');  % Añadir página al PDF
    end
    close(fig);  % Cierra la figura después de exportarla
end