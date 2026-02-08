%% SCRIPT MAIN: INTERPOLACIÓN BILINEAL MANUAL
% Objetivo: Reescalar imágenes usando implementación propia
% Método: Interpolación bilineal manual

% --- RUTAS ---
rutaIn  = 'D:\Posgrado Segundo MR-2\PDI\Fase1';
rutaOut = fullfile(rutaIn, 'Resultados_Interpolaciobilineal_Manual');

if ~exist(rutaOut, 'dir')
    mkdir(rutaOut);
end

% --- PARÁMETROS DE ESCALA ---
Sx = 0.5;   % Escala vertical
Sy = 0.75;  % Escala horizontal

% --- LISTA DE IMÁGENES ---
lista = dir(fullfile(rutaIn, '*.jpg'));

fprintf('Iniciando interpolación bilineal manual...\n');

for k = 1:length(lista)
    
    % Leer imagen
    I = imread(fullfile(rutaIn, lista(k).name));
    
    % Convertir a gris si es RGB
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    
    % Llamada a la función propia
    ImgEscalada = InterpolacionbilinialManual(I, Sx, Sy);
    
    % Guardar resultado
    imwrite(ImgEscalada, fullfile(rutaOut, lista(k).name));
    
    fprintf('Procesada: %s\n', lista(k).name);
end

fprintf('Proceso finalizado. Escala aplicada: Sx=%.2f, Sy=%.2f\n', Sx, Sy);
