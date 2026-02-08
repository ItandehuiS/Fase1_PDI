clc;
clear;
close all;
%%Utilizando las herramientas e Matlab genera el escalamiento 

% 1. Cargar imagen en escala de grises
I = im2double(imread('1.jpg'));   % imagen de ejemplo de MATLAB
I = im2double(I);              % convertir a double para interp2

% Mostrar imagen original
figure;
subplot(2,3,1);
imshow(I);
title('Imagen original');

% 2. Escalamiento con imresize (bilinear)
I_up = imresize(I, 2, 'bilinear');      % Agrandar 2x
I_down = imresize(I, 0.5, 'bilinear');  % Reducir a la mitad

subplot(2,3,2);
imshow(I_up);
title('Agrandada 2x (imresize bilinear)');

subplot(2,3,3);
imshow(I_down);
title('Reducida 0.5x (imresize bilinear)');

% 3. Escalamiento usando interp2 (bilineal manual)
[rows, cols] = size(I);

% Nueva grilla (2x)
[X, Y] = meshgrid(1:cols, 1:rows);
[Xq, Yq] = meshgrid(linspace(1, cols, 2*cols), ...
                    linspace(1, rows, 2*rows));

I_interp2 = interp2(X, Y, I, Xq, Yq, 'linear');

subplot(2,3,4);
imshow(I_interp2);
title('Agrandada 2x (interp2 bilinear)');

% 4. Comparación con vecino más cercano
I_nearest = imresize(I, 2, 'nearest');

subplot(2,3,5);
imshow(I_nearest);
title('Agrandada 2x (vecino más cercano)');

% 5. Comparación con bicúbica
I_bicubic = imresize(I, 2, 'bicubic');

subplot(2,3,6);
imshow(I_bicubic);
title('Agrandada 2x (bicúbica)');
