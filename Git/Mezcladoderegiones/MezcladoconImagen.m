%% SCRIPT 5: CUTMIX ALEATORIO
% Objetivo: Mezclar regiones de dos imágenes aleatoriamente usando CutMix
% Método: Selección de par de imágenes al azar y mezcla de parches

% --- RUTAS ---
rutaIn  = 'D:\Posgrado Segundo MR-2\PDI\Fase1\ImagenesEscalaDeGrises';
rutaOut = fullfile(rutaIn, 'Resultados_CutMix');
if ~exist(rutaOut, 'dir')
    mkdir(rutaOut);
end

% --- PARÁMETROS ---
alpha = 1.0;          % Factor de mezcla (1 = solo imagen A, 0 = solo B)
numMezclas = 10;      % Número de mezclas aleatorias a generar

% --- Lista de imágenes ---
lista = dir(fullfile(rutaIn, '*.jpg'));
numImgs = length(lista);

if numImgs < 2
    error('Se necesitan al menos dos imágenes para CutMix.');
end

fprintf('Iniciando CutMix aleatorio...\n');

rng('shuffle'); % Para aleatoriedad

for k = 1:numMezclas
    % Seleccionar dos imágenes distintas al azar
    idx = randperm(numImgs, 2);
    imgA = im2double(imread(fullfile(rutaIn, lista(idx(1)).name)));
    imgB = im2double(imread(fullfile(rutaIn, lista(idx(2)).name)));
    
    % Redimensionar imgB si no coincide con imgA
    if ~isequal(size(imgA), size(imgB))
        imgB = imresize(imgB, [size(imgA,1), size(imgA,2)]);
    end
    
    % --- Aplicar CutMix ---
    imgCutMix = cutmix_image_only(imgA, imgB, alpha);
    
    % --- Guardar resultado ---
    nombreSalida = sprintf('CutMix_%d_%s_%s.jpg', k, lista(idx(1)).name, lista(idx(2)).name);
    imwrite(imgCutMix, fullfile(rutaOut, nombreSalida));
    
    fprintf('CutMix %d: %s + %s -> %s\n', k, lista(idx(1)).name, lista(idx(2)).name, nombreSalida);
end

fprintf('CutMix aleatorio completado. Resultados guardados en: %s\n', rutaOut);
