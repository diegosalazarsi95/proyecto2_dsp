%======================================================================================   
%                                   funci´on de transferencia                                                                          
%                       H = ( (1 - z .^ (-M)) ./ (1 - z .^ (-1))) ;
%======================================================================================
function [pasa_bajas_decimada,pasa_altas_decimada] = filter_decimator(xn);
pkg load signal;
D=2;
A_1=[1 -1];
B_1=[1 0 0 0 -1];

%===============================================================================================
%                                    Calculo de coeficientes
%===============================================================================================

%la convoluci´on se hace para que solo quede la parte de frecuencias bajas
A=  conv(A_1,conv(A_1, conv(A_1,conv(A_1, conv(A_1,A_1))))) ;
B=(1/3300).*(conv(B_1,conv(B_1, conv(B_1,conv(B_1, conv(B_1,B_1))))));

%figure
%freqz(B,A,2000)

%===============================================================================================
%                                     Filtro pasa bajas
%===============================================================================================
bl =B;              %Coeficientes denominador
al = A;             %Coeficientes numerador en HP deben ser positivos

%figure
%freqz(bl,al,2000)
%===============================================================================================
%                                     Filtro pasa altas
%===============================================================================================
bh = B;	            %Coeficientes denominador
ah = abs(A);        %Coeficientes numerador en HP deben ser positivos

%figure
%freqz(bh,ah,2000)

N = 110;
wc = 0.5;

b  = fir1(N, wc, "high");
b2 = fir1(N, wc, "low");


yn_l = filter(b2,1,xn);
yn_h = filter(b,1,xn);

%==================================== esta es la salida de cada decimacion =====================
pasa_bajas_decimada = D*downsample(yn_l,D);		%Decimación para el pasa bajas;  
pasa_altas_decimada = D*downsample(yn_h,D);   %Decimación para el pasa altas
endfunction