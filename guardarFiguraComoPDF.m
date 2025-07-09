function guardarFiguraComoPDF(nombrePDF, crearNuevo)
    fig = gcf;  % Obtener figura actual
    if crearNuevo
        print(fig, nombrePDF, '-dpdf', '-bestfit'); % Crear PDF nuevo
    else
        print(fig, nombrePDF, '-dpdf', '-append');  % A�adir p�gina al PDF
    end
    close(fig);  % Cierra la figura despu�s de exportarla
end