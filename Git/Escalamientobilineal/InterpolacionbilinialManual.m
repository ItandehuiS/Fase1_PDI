function [ImgEscalda] = InterpolacionbilinialManual(img,Sx,Sy)

% Convertir la imagen a double para cálculos
I = double(img);

% Dimensiones originales
[h, w] = size(I);

% Padding para evitar salir de la imagen
I(1:h+1,w+1) = 0;

%Dimensiones nuevas 
hN = round(h * Sx);
wN = round(w * Sy);
newM=zeros(hN,wN);

for i = 1:hN
    for j = 1:wN
        xp = (i)/Sx;
        x = floor(xp);
        yp = (j)/Sy;
        y = floor(yp);
        vec_der= y+1;
        vec_inf= x+1;
        d1=abs(x-xp);
        d3=abs(x-xp);
        d4=abs(vec_der-yp);
        d2=abs(y-yp);
        d6=abs(y-yp);
        d8=abs(vec_der-yp);
        d5=abs(vec_inf-xp);
        d7=abs(vec_inf-xp);
        w1=1-d1;
        w2=1-d2;
        w4=1-d4;
        w5=1-d5;
        Bv=abs(w1);
        Bh=abs(w2);
        Alfh=abs(w4);
        Alfv=abs(w5);
        % Evita indices fuera de rango
        if x==0 || y==0
            inten=0;
        else
            inten=Bh*Bv*I(x,y)+Alfh*Bv*I(x,vec_der)+Alfv*Bh*I(vec_inf,y)+Alfv*Alfh*I(vec_inf,vec_der);
        end
        
        %Se rellena la imagen nueva 
        newM(i,j)=floor(inten);
        
        %Posicion de los pixeles a trabajar en la imagen original 
        %fprintf('xp = %f, yp = %f, x = %d, y = %d, x = %d,yp = %f,xp = %f,y = %d,xp = %f,yp = %f,d1 = %f,d2 = %f,d3 = %f,d4 = %f,d5 = %f,d6 = %f,d7 = %f,d8 = %f,bv = %f,bh = %f,Alfh = %f,Alfv = %f\n',  xp,  yp, x, y, x, vec_der, vec_inf, y, vec_inf, vec_der, d1,d2,d3,d4,d5,d6,d7,d8,Bv,Bh,Alfh,Alfv );
       
    end
end
ImgEscalda=uint8(newM);
end



