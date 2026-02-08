%% SCRIPT MAIN: RANDOM ERASE
% Objetivo: Borrar regiones de la imagen de manera aleatoria
% Método: Random Erase

% --- RUTAS ---
rutaIn  = 'D:\Posgrado Segundo MR-2\PDI\Fase1\ImagenesEscalaDeGrises';
rutaOut = fullfile(rutaIn, 'Resultados_Random_Erase');

if ~exist(rutaOut, 'dir')
    mkdir(rutaOut);
end

% --- PARÁMETROS DE RANDOM ERASE ---
p = 0.8;                             % 80% probabilidad de aplicar
areaRange = [0.05, 0.53];            % 5%–53% del área total
aspectRange = [0.1, 1.3];            % relación de aspecto mínima/máxima
eraseValue = 'random';               % pixels con valores aleatorios

% --- LISTA DE IMÁGENES ---
lista = dir(fullfile(rutaIn, '*.jpg'));

fprintf('Iniciando Random Erase sobre imágenes...\n');

for k = 1:length(lista)
    
    % Leer imagen actual y convertir a double
    img = im2double(imread(fullfile(rutaIn, lista(k).name)));
    
    % Aplicar Random Erasing
    augImg = random_erasing(img, p, areaRange, aspectRange, eraseValue);
    
    % Guardar imagen resultante
    [~, nombreArchivo, ext] = fileparts(lista(k).name);
    imwrite(augImg, fullfile(rutaOut, [nombreArchivo, '_aug', ext]));
    
    % Mostrar resultado (opcional)
    figure; imshow(augImg)
    title(['Random Erase: ', lista(k).name]);
end

fprintf('Proceso finalizado. Se aplicó Random Erase con p=%.2f\n', p);
