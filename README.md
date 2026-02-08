# Image Augmentation and Scaling Toolbox

Este repositorio contiene implementaciones en MATLAB para **procesamiento y aumento de imágenes**, incluyendo:

## Funcionalidades principales
1. **Interpolación Bilineal Manual**
   - Redimensiona imágenes conservando suavidad.
   - Función propia que permite entender cómo funciona la interpolación bilineal.

2. **Borrado Aleatorio (Random Erase)**
   - Aumenta la robustez de modelos de visión por computadora.
   - Borra regiones aleatorias de las imágenes con píxeles negros o aleatorios.
   
3. **Mezcla de Imágenes**
   - **MixUp**: combina dos imágenes con un factor de mezcla `alpha`.
   - **CutMix**: mezcla regiones de dos imágenes para generar nuevas muestras de entrenamiento.

## Ejemplos de uso
- Redimensionar imágenes con interpolación bilineal:
```matlab
ImgEscalada = InterpolacionBilinealManual(I, 0.5, 0.75);
imgCutMix = cutmix_image_only(imgA, imgB, alpha);
