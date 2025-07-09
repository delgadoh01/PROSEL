function unirResultados()

    % Archivos a integrar
    archivos = {'ResultadosAlumnos.mat', 'ResultadosProfesores.mat', 'ResultadosAdministrativos.mat'};

    % Inicializar contenedores vacíos
    Espacios = [];
    Miembros = [];
    Participacion_absoluta_por_espacio = [];
    Participacion_relativa_por_espacio = [];
    Votos_por_espacio = [];
    Ganadores = [];

    for i = 1:length(archivos)
        % Cargar datos del archivo actual
        datos = load(archivos{i});

        % Concatenar verticalmente (asumimos vectores columna o matrices compatibles)
        Espacios = [Espacios; datos.Espacios];
        Miembros = [Miembros; datos.Miembros];
        Participacion_absoluta_por_espacio = [Participacion_absoluta_por_espacio; datos.Participacion_absoluta_por_espacio];
        Participacion_relativa_por_espacio = [Participacion_relativa_por_espacio; datos.Participacion_relativa_por_espacio];
        Votos_por_espacio = [Votos_por_espacio; datos.Votos_por_espacio];
        Ganadores = [Ganadores; datos.Ganadores];
    end

    % Guardar archivo unificado
    save('ResultadosConcentrados.mat', ...
        'Espacios', ...
        'Miembros', ...
        'Participacion_absoluta_por_espacio', ...
        'Participacion_relativa_por_espacio', ...
        'Votos_por_espacio', ...
        'Ganadores');

    disp('Archivo ResultadosConcentrados.mat creado exitosamente.');
end
