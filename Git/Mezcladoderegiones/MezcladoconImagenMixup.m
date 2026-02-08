%% SCRIPT 3: MIXUP ALEATORIO PARA IMÁGENES EN UN FOLDER
% Objetivo: Mezclar aleatoriamente pares de imágenes mediante MixUp
% Método: alpha fijo o aleatorio

% --- RUTAS ---
rutaIn  = 'D:\Posgrado Segundo MR-2\PDI\Fase1\ImagenesEscalaDeGrises';
rutaOut = fullfile(rutaIn, 'Resultados_MixUp_Aleatorio');
if ~exist(rutaOut, 'dir')
    mkdir(rutaOut);
end

% --- PARÁMETROS ---
alpha = 0.5;   % Mezcla fija (0 = solo B, 1 = solo A)
numMezclas = 10; % Número de mezclas aleatorias a generar

% --- Lista de imágenes ---
lista = dir(fullfile(rutaIn, '*.jpg'));
numImgs = length(lista);

if numImgs < 2
    error('Se necesitan al menos dos imágenes para realizar MixUp.');
end

fprintf('Iniciando MixUp aleatorio...\n');

rng('shuffle'); % Para aleatoriedad diferente cada vez

for k = 1:numMezclas
    % Seleccionar dos imágenes distintas al azar
    idx = randperm(numImgs, 2);
    imgA = im2double(imread(fullfile(rutaIn, lista(idx(1)).name)));
    imgB = im2double(imread(fullfile(rutaIn, lista(idx(2)).name)));
    
    % Verificar que tengan el mismo tamaño
    if ~isequal(size(imgA), size(imgB))
        % Redimensionar imgB al tamaño de imgA
        imgB = imresize(imgB, [size(imgA,1), size(imgA,2)]);
    end
    
    % --- Mezclar imágenes ---
    imgMixUp = alpha * imgA + (1 - alpha) * imgB;
    
    % --- Guardar resultado ---
    nombreSalida = sprintf('MixUp_%d_%s_%s.jpg', k, lista(idx(1)).name, lista(idx(2)).name);
    imwrite(imgMixUp, fullfile(rutaOut, nombreSalida));
    
    fprintf('Mezcla %d: %s + %s -> %s\n', k, lista(idx(1)).name, lista(idx(2)).name, nombreSalida);
end

fprintf('MixUp aleatorio completado. Resultados guardados en: %s\n', rutaOut);
