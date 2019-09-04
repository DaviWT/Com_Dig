clear all
clc
close all


[X,map]=imread('Sega-Rally.bmp');
figure
colormap(map)
image(X);
title(['Imagem original'])

b=reshape(X,size(X,1)*size(X,2)/2,2);
b(:,[1 2])=b(:,[2 1]);
b=bi2de(b);

%while(1)
%    %LÓGICA AQUI
%end

bits=length(b);


s=(2*b-3)';
N0=1;
M=2;

randn('seed',777);
n=randn(1,length(s))*sqrt(N0/2);


EbN0dBini=0;
passo=2;
EbN0dBfim=10;

for EbN0dB=EbN0dBini:passo:EbN0dBfim
    % Energia
    EbN0=10^(EbN0dB/10); 
    Eb=EbN0*N0;
    Es=Eb*log2(M);
    y=sqrt(Es/5)*s+n;
    
    %Decisor
    d = sqrt(Es/5);
    b_est3=3*(y>=2*d); %Decisor.
    b_est2=2*(y>0 & y<2*d); %Decisor.
    b_est1=1*(y<0 & y>-2*d); %Decisor.
    b_est0=0*(y<=-2*d); %Decisor.
    b_est=b_est0+b_est1+b_est2+b_est3;
    
    % Erro
    erros=sum(b~=b_est'); 
    ber=erros/bits; 
    
    % Plot da imagem
    b_est=de2bi(b_est');
    b_est(:,[1 2]) = b_est(:,[2 1]);
    imagem_recebida=reshape(b_est,size(X,1),size(X,2));
    figure
    colormap(map)
    imagesc(imagem_recebida);
    title(['E_b/N_0= ' num2str(EbN0dB) 'dB - BER= ' num2str(ber)])
end

