clear all
clc
close all


[X,map]=imread('Sega-Rally.bmp');
figure
colormap(map)
image(X);
title(['Imagem original'])
pause

b=reshape(X,1,size(X,1)*size(X,2));
bits=length(b);


s0=double(b); %Eb a princípio seria 1, já que as amplitudes são +1 e -1. Es também seria 1, já que a modulação é binária (1 bit -> 1 símbolo).
s1=double(~b);
N0=1;
M=2;

randn('seed',123456789);
n0=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.
n1=randn(1,bits)*sqrt(N0/2);


EbN0dBini=0;
passo=2;
EbN0dBfim=10;

for EbN0dB=EbN0dBini:passo:EbN0dBfim
    % Energia
    EbN0=10^(EbN0dB/10); 
    Eb=EbN0*N0;
    Es=Eb*log2(M);
    y0=sqrt(Es)*s0+n0; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.
    y1=sqrt(Es)*s1+n1;
    
    %Decisor
    b_est=y1<y0; %Decisor.
    
    % Erro
    erros=sum(b~=b_est); 
    ber=erros/bits; 
    
    % Plot da imagem
    imagem_recebida=reshape(b_est,size(X,1),size(X,2));
    figure
    colormap(map)
    image(imagem_recebida);
    title(['E_b/N_0= ' num2str(EbN0dB) 'dB - BER= ' num2str(ber)])
    pause
end

