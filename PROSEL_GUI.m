function PROSEL_GUI
    % PROSEL: Programa de Simulación de Elecciones
    % Autor: Dr. David Joaquín Delgado Hernández, Facultad de Ingeniería, UAEMEX

    % Crear la ventana principal
    f = figure('Name','PROSEL - Programa de Simulación de Elecciones',...
        'Position',[100 100 1000 700],'Color','white','NumberTitle','off');

    % Encabezado con título y autor
encabezado = uipanel(f,'Position',[0 0.85 1 0.15],'BackgroundColor','white');

uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.4 0.7 0.5],...
    'String','PROSEL - Programa de Simulación de Elecciones','FontSize',16,'FontWeight','bold',...
    'BackgroundColor','white','HorizontalAlignment','left');

uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.1 0.7 0.3],...
    'String','Dr. David Joaquín Delgado Hernández. Investigador. Facultad de Ingeniería. UAEMEX',...
    'FontSize',10,'BackgroundColor','white','HorizontalAlignment','left');

try
    escudo = imread('escudo_uaemex.png');  % Asegúrate de que el archivo existe
    axEscudo = axes('Parent', encabezado, 'Units','normalized', 'Position',[0.82 0.05 0.15 0.9]);
    imshow(escudo, 'Parent', axEscudo);
    axis(axEscudo, 'off');
catch
    warning('No se pudo cargar el escudo UAEMEX. Verifica que el archivo escudo_uaemex.png exista.');
end

    %% Paneles de interfaz (inicialmente deshabilitados)
    p1 = uipanel(f,'Title','Ponderaciones','FontSize',10,...
        'Position',[0.05 0.55 0.45 0.25],'BackgroundColor','white','Visible','off');
    p2 = uipanel(f,'Title','Preferencias Electorales por Aspirante','FontSize',10,...
        'Position',[0.55 0.55 0.4 0.25],'BackgroundColor','white','Visible','off');
    p3 = uipanel(f,'Title','Espacios Universitarios (Aspirantes Preferidos)','FontSize',10,...
        'Position',[0.05 0.25 0.45 0.25],'BackgroundColor','white','Visible','off');
    p4 = uipanel(f,'Title','Porcentajes de participación esperados','FontSize',10,...
        'Position',[0.55 0.25 0.4 0.25],'BackgroundColor','white','Visible','off');

    %% Campos de número de aspirantes
    uicontrol('Style','text','Position',[30 130 150 20],'String','Número de aspirantes:',...
        'FontSize',10,'HorizontalAlignment','left','BackgroundColor','white');
    hAsp = uicontrol('Style','edit','Position',[190 130 60 25],'Tag','aspirantes',...
        'BackgroundColor','yellow');

    hDefinir = uicontrol('Style','pushbutton','String','Definir Aspirantes','Position',[270 130 120 25],...
        'BackgroundColor',[0.85 0.85 0.85],'Callback',@definirAspirantes);

    hAceptar = uicontrol('Style','pushbutton','String','Aceptar Datos',...
        'Position',[550 30 180 40],'FontSize',12,'FontWeight','bold',...
        'BackgroundColor',[0.6 0.6 0.6],'Callback',@aceptarDatos,...
        'Enable','off');

    hSimular = uicontrol('Style','pushbutton','String','Ejecutar Simulación',...
        'Position',[750 30 180 40],'FontSize',12,'FontWeight','bold',...
        'BackgroundColor',[0.3 0.3 0.3],'ForegroundColor','white',...
        'Callback',@ejecutarSimulacion,'Enable','off');

    % Entradas de porcentajes
    uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.7 0.4 0.2],...
              'String','Alumnos (%)','BackgroundColor','white','HorizontalAlignment','left');
    hPA = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.7 0.4 0.2],...
              'String','60');

    uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.4 0.4 0.2],...
              'String','Profesores (%)','BackgroundColor','white','HorizontalAlignment','left');
    hPP = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.4 0.4 0.2],...
              'String','60');

    uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.1 0.4 0.2],...
              'String','Administrativos (%)','BackgroundColor','white','HorizontalAlignment','left');
    hPT = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.1 0.4 0.2],...
              'String','60');

    %% Variables iniciales
    assignin('base','combinaciones',[2 1 1;3 2 1; 3 2 2]);
    assignin('base','Texto_encabezado',{'Alumnos','Profesores','Administrativos'});

    %% Función para definir aspirantes
    function definirAspirantes(~,~)
        n = str2double(get(hAsp,'String'));
        if isnan(n) || n < 1 || mod(n,1) ~= 0
            errordlg('Ingrese un número entero positivo de aspirantes.','Error');
            return;
        end

        % Activar paneles y botón Aceptar
        set([p1 p2 p3 p4],'Visible','on');
        set(hAceptar, 'Enable', 'on');

        Texto_encabezado = evalin('base','Texto_encabezado');

        % Crear controles en panel Ponderaciones
        uicontrol(p1,'Style','text','Units','normalized','Position',[0.05 0.78 0.1 0.15],'String','A:', 'BackgroundColor','white');
        hA = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.15 0.78 0.15 0.18]);

        uicontrol(p1,'Style','text','Units','normalized','Position',[0.32 0.78 0.1 0.15],'String','P:', 'BackgroundColor','white');
        hP = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.42 0.78 0.15 0.18]);

        uicontrol(p1,'Style','text','Units','normalized','Position',[0.59 0.78 0.1 0.15],'String','T:', 'BackgroundColor','white');
        hT = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.69 0.78 0.15 0.18]);

        hTablaComb = uitable(p1,'Data',evalin('base','combinaciones'),...
             'ColumnName',Texto_encabezado,...
             'Units','normalized','Position',[0.05 0.05 0.75 0.5],...
             'Tag','tablaCombinaciones','ColumnEditable',[false false false]);

        uicontrol(p1,'Style','pushbutton','String','Agregar Ponderación',...
            'Units','normalized','Position',[0.05 0.6 0.4 0.15],'Callback',@agregarPonderacion);

        uicontrol(p1,'Style','pushbutton','String','Eliminar Selección',...
            'Units','normalized','Position',[0.5 0.6 0.4 0.15],'Callback',@eliminarPonderacion);

        set(hTablaComb, 'CellSelectionCallback', @(src, event) set(src,'UserData',event.Indices(1)));

        function agregarPonderacion(~,~)
            A = str2double(get(hA,'String'));
            P = str2double(get(hP,'String'));
            T = str2double(get(hT,'String'));
            if any(isnan([A P T]))
                errordlg('Valores no válidos en A, P o T');
                return;
            end
            combinaciones = evalin('base','combinaciones');
            combinaciones = [A P T; combinaciones];
            assignin('base','combinaciones',combinaciones);
            set(hTablaComb, 'Data', combinaciones);
        end

        function eliminarPonderacion(~,~)
            combinaciones = evalin('base','combinaciones');
            selected = get(hTablaComb, 'UserData');
            if isempty(selected) || selected < 1 || selected > size(combinaciones,1)
                warndlg('Seleccione una fila para eliminar.');
                return;
            end
            combinaciones(selected,:) = [];
            assignin('base','combinaciones',combinaciones);
            set(hTablaComb, 'Data', combinaciones);
        end

        % Panel Preferencias Electorales
        uitable('Parent',p2,'Data',ones(n,3),...
           'ColumnName',Texto_encabezado,...
           'Tag','tablaPreferencias','ColumnEditable',[true true true],...
           'Units','normalized','Position',[0.05 0.05 0.9 0.9]);

        % Panel Espacios Universitarios
        uitable('Parent',p3,'Data',ones(6,3),...
            'ColumnName',Texto_encabezado,...
            'RowName',{'Prepas','Facultades','C. Univ.','U. Acad.','Institutos','Adm. Central'},...
            'Tag','tablabloque','ColumnEditable',[true true true],...
            'Units','normalized','Position',[0.05 0.05 0.9 0.9]);
    end

    %% Aceptar datos
    function aceptarDatos(~,~)
        fuertes = get(findobj('Tag','tablaPreferencias'), 'Data');
        bloque = get(findobj('Tag','tablabloque'), 'Data');
        n = str2double(get(hAsp,'String'));

        % Validar porcentajes
        valA = str2double(get(hPA,'String'));
        valP = str2double(get(hPP,'String'));
        valT = str2double(get(hPT,'String'));
        if any(isnan([valA valP valT])) || any([valA valP valT] < 0 | [valA valP valT] > 100)
            errordlg('Ingrese porcentajes válidos (entre 0 y 100) en participación esperada.');
            return;
        end

        % Guardar en base
        assignin('base','Aspirantes',n);
        assignin('base','fuertes',fuertes);
        assignin('base','bloque',bloque);
        assignin('base','media_participacion_alumnos',valA/100);
        assignin('base','media_participacion_profesores',valP/100);
        assignin('base','media_participacion_administrativos',valT/100);

        % Captura de pantalla y PDF
        try
            frame = getframe(f);
            imwrite(frame.cdata, 'DatosIniciales_temp.png');
            img = imread('DatosIniciales_temp.png');
            fig = figure('Visible','off'); imshow(img); axis off; set(gca,'Position',[0 0 1 1]);
            print(fig, 'DatosIniciales', '-dpdf', '-bestfit');
            close(fig);
            delete('DatosIniciales_temp.png');
        catch ME
            warning('No se pudo generar el PDF: %s', ME.message);
        end

        msgbox('Datos enviados al Workspace y guardados como DatosIniciales.pdf','Éxito');
        set(hSimular, 'Enable', 'on');
    end

    %% Ejecutar simulación
    function ejecutarSimulacion(~, ~)
        try
            evalin('base', 'run(''InformeCompleto3.m'')');
            %evalin('base', 'run(''informeCompleto.m'')');
            %evalin('base', 'run(''informeCompleto1.m'')');
            close(gcf);
        catch ME
            errordlg(['No se pudo ejecutar el script: ' ME.message], 'Error');
        end
    end
end


%% Función previa de Prosel al 4 Jul 25
% 
% function PROSEL_GUI
%     % PROSEL: Programa de Simulación de Elecciones
%     % Autor: Dr. David Joaquín Delgado Hernández, Facultad de Ingeniería, UAEMEX
%  
%     % Crear la ventana principal
%     f = figure('Name','PROSEL - Programa de Simulación de Elecciones',...
%         'Position',[100 100 1000 700],'Color','white','NumberTitle','off');
%  
%     % Encabezado con título, autor y escudo
%     encabezado = uipanel(f,'Position',[0 0.85 1 0.15],'BackgroundColor','white');
%  
%     uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.4 0.7 0.5],...
%         'String','PROSEL - Programa de Simulación de Elecciones','FontSize',16,'FontWeight','bold',...
%         'BackgroundColor','white','HorizontalAlignment','left');
%  
%     uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.1 0.7 0.3],...
%         'String','Dr. David Joaquín Delgado Hernández. Investigador. Facultad de Ingeniería. UAEMEX',...
%         'FontSize',10,'BackgroundColor','white','HorizontalAlignment','left');
%  
%     try
%         escudo = imread('escudo_uaemex.png');
%         axEscudo = axes('Parent', encabezado, 'Units','normalized', 'Position',[0.82 0.05 0.15 0.9]);
%         imshow(escudo, 'Parent', axEscudo);
%         axis(axEscudo, 'off');
%     catch
%         warning('No se pudo cargar el escudo UAEMEX.');
%     end
%  
%     %% Paneles por cuadrantes
%     p1 = uipanel(f,'Title','Ponderaciones','FontSize',10,'Position',[0.05 0.55 0.45 0.25],'BackgroundColor','white');
%     p2 = uipanel(f,'Title','Preferencias Electorales por Aspirante','FontSize',10,'Position',[0.55 0.55 0.4 0.25],'BackgroundColor','white');
%     p3 = uipanel(f,'Title','Espacios Universitarios (Aspirantes Prefereidos)','FontSize',10,'Position',[0.05 0.25 0.45 0.25],'BackgroundColor','white');
%     p4 = uipanel(f,'Title','Porcentajes de participación esperados','FontSize',10,'Position',[0.55 0.25 0.4 0.25],'BackgroundColor','white');
%  
%     %% Controles de ejecución en parte inferior
%     uicontrol('Style','text','Position',[30 130 150 20],'String','Número de aspirantes:',...
%         'FontSize',10,'HorizontalAlignment','left','BackgroundColor','white');
%     hAsp = uicontrol('Style','edit','Position',[190 130 60 25],'Tag','aspirantes');
%  
%     uicontrol('Style','pushbutton','String','Definir Aspirantes','Position',[270 130 120 25],...
%         'Callback',@definirAspirantes,'BackgroundColor',[0.85 0.85 0.85]);
%  
%     uicontrol('Style','pushbutton','String','Aceptar Datos',...
%         'Position',[550 30 180 40],'FontSize',12,'FontWeight','bold',...
%         'BackgroundColor',[0.6 0.6 0.6],'Callback',@aceptarDatos);
%  
%     uicontrol('Style','pushbutton','String','Ejecutar Simulación',...
%         'Position',[750 30 180 40],'FontSize',12,'FontWeight','bold',...
%         'BackgroundColor',[0.3 0.3 0.3],'ForegroundColor','white','Callback',@ejecutarSimulacion);
% 
%     % Panel de porcentajes
%     uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.7 0.4 0.2],...
%               'String','Alumnos (%)','BackgroundColor','white','HorizontalAlignment','left');
%     hPA = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.7 0.4 0.2],...
%               'String','60');
% 
%     uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.4 0.4 0.2],...
%               'String','Profesores (%)','BackgroundColor','white','HorizontalAlignment','left');
%     hPP = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.4 0.4 0.2],...
%               'String','60');
% 
%     uicontrol('Parent',p4,'Style','text','Units','normalized','Position',[0.05 0.1 0.4 0.2],...
%               'String','Administrativos (%)','BackgroundColor','white','HorizontalAlignment','left');
%     hPT = uicontrol('Parent',p4,'Style','edit','Units','normalized','Position',[0.5 0.1 0.4 0.2],...
%               'String','60');
% 
%     %% Variables internas dinámicas
%     assignin('base','combinaciones',[1 1 1;2 1 1;3 2 1; 3 2 2]);
%     assignin('base','Texto_encabezado',{'Alumnos','Profesores','Administrativos'});
%  
%     function definirAspirantes(~,~)
%         n = str2double(get(hAsp,'String'));
%         if isnan(n) || n < 1
%             errordlg('Ingrese un número válido de aspirantes');
%             return;
%         end
%  
%         Texto_encabezado = evalin('base','Texto_encabezado');
%  
%         % Panel 1 - Ponderaciones
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.05 0.78 0.1 0.15],'String','A:', 'BackgroundColor','white');
%         hA = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.15 0.78 0.15 0.18]);
%  
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.32 0.78 0.1 0.15],'String','P:', 'BackgroundColor','white');
%         hP = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.42 0.78 0.15 0.18]);
%  
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.59 0.78 0.1 0.15],'String','T:', 'BackgroundColor','white');
%         hT = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.69 0.78 0.15 0.18]);
%  
%         hTablaComb = uitable(p1,'Data',evalin('base','combinaciones'),...
%              'ColumnName',Texto_encabezado,...
%             'Units','normalized','Position',[0.05 0.05 0.75 0.5],...
%             'Tag','tablaCombinaciones','ColumnEditable',[false false false]);
%  
%         uicontrol(p1,'Style','pushbutton','String','Agregar Ponderación',...
%             'Units','normalized','Position',[0.05 0.6 0.4 0.15],'Callback',@agregarPonderacion,'BackgroundColor',[0.8 0.8 0.8]);
%  
%         uicontrol(p1,'Style','pushbutton','String','Eliminar Selección',...
%             'Units','normalized','Position',[0.5 0.6 0.4 0.15],'Callback',@eliminarPonderacion,'BackgroundColor',[0.8 0.8 0.8]);
%  
%         function agregarPonderacion(~,~)
%             A = str2double(get(hA,'String'));
%             P = str2double(get(hP,'String'));
%             T = str2double(get(hT,'String'));
%             if any(isnan([A P T]))
%                 errordlg('Valores no válidos en A, P o T');
%                 return;
%             end
%             combinaciones = evalin('base','combinaciones');
%             combinaciones = [A P T; combinaciones];
%             assignin('base','combinaciones',combinaciones);
%             set(hTablaComb, 'Data', combinaciones);
%         end
%  
%         function eliminarPonderacion(~,~)
%             combinaciones = evalin('base','combinaciones');
%             selected = get(hTablaComb, 'UserData');
%             if isempty(selected) || selected < 1 || selected > size(combinaciones,1)
%                 warndlg('Seleccione una fila para eliminar.');
%                 return;
%             end
%             combinaciones(selected,:) = [];
%             assignin('base','combinaciones',combinaciones);
%             set(hTablaComb, 'Data', combinaciones);
%         end
%  
%         set(hTablaComb, 'CellSelectionCallback', @(src, event) set(src,'UserData',event.Indices(1)));
%  
%         % Panel 2 - Preferencias Electorales
%         uitable('Parent',p2,'Data',ones(n,3),...
%            'ColumnName',Texto_encabezado,...
%             'Tag','tablaPreferencias','ColumnEditable',[true true true],...
%             'Units','normalized','Position',[0.05 0.05 0.9 0.9]);
%  
%         % Panel 3 - Espacios Universitarios
%         uitable('Parent',p3,'Data',ones(6,3),...
%             'ColumnName',Texto_encabezado,...
%             'RowName',{'Prepas','Facultades','C. Univ.','U. Acad.','Institutos','Adm. Central'},...
%             'Tag','tablabloque','ColumnEditable',[true true true],...
%             'Units','normalized','Position',[0.05 0.05 0.9 0.9]);
%     end
%  
% function aceptarDatos(~,~)
%     Texto_encabezado = evalin('base','Texto_encabezado');
%     hTablaPref = findobj('Tag','tablaPreferencias');
%     hTablaBloq = findobj('Tag','tablabloque');
%     if isempty(hTablaPref) || isempty(hTablaBloq)
%         errordlg('Debe definir entradas primero.');
%         return;
%     end
%     fuertes = get(hTablaPref, 'Data');
%     bloque = get(hTablaBloq, 'Data');
%     n = str2double(get(hAsp,'String'));
%     assignin('base','Aspirantes',n);
%     assignin('base','fuertes',fuertes);
%     assignin('base','bloque',bloque);
% 
%     % Participaciones esperadas
%     valA = str2double(get(hPA,'String')) / 100;
%     valP = str2double(get(hPP,'String')) / 100;
%     valT = str2double(get(hPT,'String')) / 100;
% 
%     assignin('base','media_participacion_alumnos',valA);
%     assignin('base','media_participacion_profesores',valP);
%     assignin('base','media_participacion_administrativos',valT);
% 
%     % --- Captura de pantalla y guardado como PDF ---
%     try
%         frame = getframe(f);                     % Captura la ventana principal
%         img = frame.cdata;                      % Obtiene los datos de imagen
%         imwrite(img, 'DatosIniciales_temp.png'); % Guarda imagen temporal
% 
% %         img_rgb = imread('DatosIniciales_temp.png'); % Vuelve a leer la imagen
% %         imwrite(img_rgb, 'DatosIniciales.pdf', 'pdf'); % Guarda como PDF
% % 
% %         delete('DatosIniciales_temp.png');      % Borra imagen temporal
% 
% % Leer la imagen PNG
% img = imread('DatosIniciales_temp.png');
% 
% % Crear una figura invisible temporal
% fig = figure('Visible', 'off');
% imshow(img);  % Mostrar la imagen
% 
% % Ajustar para ocupar toda la figura
% set(gca, 'Position', [0 0 1 1]);
% axis off
% 
% % Guardar como PDF
% print(fig, 'DatosIniciales', '-dpdf', '-bestfit');
% 
% % Cerrar figura temporal
% close(fig);
% 
% % Eliminar imagen temporal si se desea
% delete('DatosIniciales_temp.png');
% 
%     catch ME
%         warning('No se pudo guardar la imagen como PDF: %s', ME.message);
%     end
% 
%     msgbox('Datos enviados al Workspace y guardados en DatosIniciales.pdf.','Éxito');
% end
% 
% %     function aceptarDatos(~,~)
% %         Texto_encabezado = evalin('base','Texto_encabezado');
% %         hTablaPref = findobj('Tag','tablaPreferencias');
% %         hTablaBloq = findobj('Tag','tablabloque');
% %         if isempty(hTablaPref) || isempty(hTablaBloq)
% %             errordlg('Debe definir entradas primero.');
% %             return;
% %         end
% %         fuertes = get(hTablaPref, 'Data');
% %         bloque = get(hTablaBloq, 'Data');
% %         n = str2double(get(hAsp,'String'));
% %         assignin('base','Aspirantes',n);
% %         assignin('base','fuertes',fuertes);
% %         assignin('base','bloque',bloque);
% % 
% %         % Participaciones esperadas
% %         valA = str2double(get(hPA,'String')) / 100;
% %         valP = str2double(get(hPP,'String')) / 100;
% %         valT = str2double(get(hPT,'String')) / 100;
% % 
% %         assignin('base','media_participacion_alumnos',valA);
% %         assignin('base','media_participacion_profesores',valP);
% %         assignin('base','media_participacion_administrativos',valT);
% % 
% %         msgbox('Datos enviados al Workspace.','Éxito');
% %     end
% %  
% 
% function ejecutarSimulacion(~, ~)
%     try
%         % Ejecutar el script en el workspace base, evitando errores
%         evalin('base', 'run(''informeCompleto.m'')');
%         close(gcf);  % Cerrar GUI actual
%     catch ME
%         errordlg(['No se pudo ejecutar el script: ' ME.message], 'Error');
%     end
% end
% end


%% Funcion Original sin capturar porcentajes de participacion

% function PROSEL_GUI
%     % PROSEL: Programa de Simulación de Elecciones
%     % Autor: Dr. David Joaquín Delgado Hernández, Facultad de Ingeniería, UAEMEX
% 
%     % Crear la ventana principal
%     f = figure('Name','PROSEL - Programa de Simulación de Elecciones',...
%         'Position',[100 100 1000 700],'Color','white','NumberTitle','off');
% 
%     % Encabezado con título, autor y escudo
%     encabezado = uipanel(f,'Position',[0 0.85 1 0.15],'BackgroundColor','white');
% 
%     uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.4 0.7 0.5],...
%         'String','PROSEL - Programa de Simulación de Elecciones','FontSize',16,'FontWeight','bold',...
%         'BackgroundColor','white','HorizontalAlignment','left');
% 
%     uicontrol('Parent',encabezado,'Style','text','Units','normalized','Position',[0.05 0.1 0.7 0.3],...
%         'String','Dr. David Joaquín Delgado Hernández. Investigador. Facultad de Ingeniería. UAEMEX',...
%         'FontSize',10,'BackgroundColor','white','HorizontalAlignment','left');
% 
%     try
%         escudo = imread('escudo_uaemex.png');
%         axEscudo = axes('Parent', encabezado, 'Units','normalized', 'Position',[0.82 0.05 0.15 0.9]);
%         imshow(escudo, 'Parent', axEscudo);
%         axis(axEscudo, 'off');
%     catch
%         warning('No se pudo cargar el escudo UAEMEX.');
%     end
% 
%     %% Paneles por cuadrantes
%     p1 = uipanel(f,'Title','Ponderaciones','FontSize',10,'Position',[0.05 0.55 0.45 0.25],'BackgroundColor','white');
%     p2 = uipanel(f,'Title','Preferencias Electorales por Aspirante','FontSize',10,'Position',[0.55 0.55 0.4 0.25],'BackgroundColor','white');
%     p3 = uipanel(f,'Title','Espacios Universitarios (Aspirantes Prefereidos)','FontSize',10,'Position',[0.05 0.25 0.45 0.25],'BackgroundColor','white');
% 
%     %% Controles de ejecución en parte inferior
%     uicontrol('Style','text','Position',[30 130 150 20],'String','Número de aspirantes:',...
%         'FontSize',10,'HorizontalAlignment','left','BackgroundColor','white');
%     hAsp = uicontrol('Style','edit','Position',[190 130 60 25],'Tag','aspirantes');
% 
%     uicontrol('Style','pushbutton','String','Definir Aspirantes','Position',[270 130 120 25],...
%         'Callback',@definirAspirantes,'BackgroundColor',[0.85 0.85 0.85]);
% 
%     uicontrol('Style','pushbutton','String','Aceptar Datos',...
%         'Position',[550 30 180 40],'FontSize',12,'FontWeight','bold',...
%         'BackgroundColor',[0.6 0.6 0.6],'Callback',@aceptarDatos);
% 
%     uicontrol('Style','pushbutton','String','Ejecutar Simulación',...
%         'Position',[750 30 180 40],'FontSize',12,'FontWeight','bold',...
%         'BackgroundColor',[0.3 0.3 0.3],'ForegroundColor','white','Callback',@ejecutarSimulacion);
%         % 'BackgroundColor',[0.3 0.3 0.3],'ForegroundColor','white','Callback',@(src, event) ejecutarSimulacion();
%     
%     %% Variables internas dinámicas
%     assignin('base','combinaciones',[1 1 1;2 1 1;3 2 1; 3 2 2]);
%     assignin('base','Texto_encabezado',{'Alumnos','Profesores','Administrativos'});
% 
%     function definirAspirantes(~,~)
%         n = str2double(get(hAsp,'String'));
%         if isnan(n) || n < 1
%             errordlg('Ingrese un número válido de aspirantes');
%             return;
%         end
% 
%         Texto_encabezado = evalin('base','Texto_encabezado');
% 
%         % Panel 1 - Ponderaciones
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.05 0.78 0.1 0.15],'String','A:', 'BackgroundColor','white');
%         hA = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.15 0.78 0.15 0.18]);
% 
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.32 0.78 0.1 0.15],'String','P:', 'BackgroundColor','white');
%         hP = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.42 0.78 0.15 0.18]);
% 
%         uicontrol(p1,'Style','text','Units','normalized','Position',[0.59 0.78 0.1 0.15],'String','T:', 'BackgroundColor','white');
%         hT = uicontrol(p1,'Style','edit','Units','normalized','Position',[0.69 0.78 0.15 0.18]);
% 
%         hTablaComb = uitable(p1,'Data',evalin('base','combinaciones'),...
%              'ColumnName',Texto_encabezado,...
%             'Units','normalized','Position',[0.05 0.05 0.75 0.5],...
%             'Tag','tablaCombinaciones','ColumnEditable',[false false false]);
% 
%         uicontrol(p1,'Style','pushbutton','String','Agregar Ponderación',...
%             'Units','normalized','Position',[0.05 0.6 0.4 0.15],'Callback',@agregarPonderacion,'BackgroundColor',[0.8 0.8 0.8]);
% 
%         uicontrol(p1,'Style','pushbutton','String','Eliminar Selección',...
%             'Units','normalized','Position',[0.5 0.6 0.4 0.15],'Callback',@eliminarPonderacion,'BackgroundColor',[0.8 0.8 0.8]);
% 
%         function agregarPonderacion(~,~)
%             A = str2double(get(hA,'String'));
%             P = str2double(get(hP,'String'));
%             T = str2double(get(hT,'String'));
%             if any(isnan([A P T]))
%                 errordlg('Valores no válidos en A, P o T');
%                 return;
%             end
%             combinaciones = evalin('base','combinaciones');
%             combinaciones = [A P T; combinaciones];
%             assignin('base','combinaciones',combinaciones);
%             set(hTablaComb, 'Data', combinaciones);
%         end
% 
%         function eliminarPonderacion(~,~)
%             combinaciones = evalin('base','combinaciones');
%             selected = get(hTablaComb, 'UserData');
%             if isempty(selected) || selected < 1 || selected > size(combinaciones,1)
%                 warndlg('Seleccione una fila para eliminar.');
%                 return;
%             end
%             combinaciones(selected,:) = [];
%             assignin('base','combinaciones',combinaciones);
%             set(hTablaComb, 'Data', combinaciones);
%         end
% 
%         set(hTablaComb, 'CellSelectionCallback', @(src, event) set(src,'UserData',event.Indices(1)));
% 
%         % Panel 2 - Preferencias Electorales
%         uitable('Parent',p2,'Data',ones(n,3),...
%            'ColumnName',Texto_encabezado,...
%             'Tag','tablaPreferencias','ColumnEditable',[true true true],...
%             'Units','normalized','Position',[0.05 0.05 0.9 0.9]);
% 
%         % Panel 3 - Espacios Universitarios
%         uitable('Parent',p3,'Data',ones(6,3),...
%             'ColumnName',Texto_encabezado,...
%             'RowName',{'Prepas','Facultades','C. Univ.','U. Acad.','Institutos','Adm. Central'},...
%             'Tag','tablabloque','ColumnEditable',[true true true],...
%             'Units','normalized','Position',[0.05 0.05 0.9 0.9]);
%     end
% 
%     function aceptarDatos(~,~)
%         Texto_encabezado = evalin('base','Texto_encabezado');
%         hTablaPref = findobj('Tag','tablaPreferencias');
%         hTablaBloq = findobj('Tag','tablabloque');
%         if isempty(hTablaPref) || isempty(hTablaBloq)
%             errordlg('Debe definir entradas primero.');
%             return;
%         end
%         fuertes = get(hTablaPref, 'Data');
%         bloque = get(hTablaBloq, 'Data');
%         n = str2double(get(hAsp,'String'));
%         assignin('base','Aspirantes',n);
%         assignin('base','fuertes',fuertes);
%         assignin('base','bloque',bloque);
%         %assignin('base','Texto_encabezado',Texto_encabezado);
%         msgbox('Datos enviados al Workspace.','Éxito');
%     end
% 
% function ejecutarSimulacion(~, ~)
%     try
%         % Ejecutar el script en el workspace base, evitando errores
%         evalin('base', 'run(''informeCompleto.m'')');
%         close(gcf);  % Cerrar GUI actual
%     catch ME
%         errordlg(['No se pudo ejecutar el script: ' ME.message], 'Error');
%     end
% end
% 
% 
% 
% %     function ejecutarSimulacion(~,~)
% %         try
% %             run('informeCompleto.m');
% %         catch ME
% %             errordlg(['No se pudo ejecutar el script: ' ME.message],'Error');
% %         end
% %     end
% end
