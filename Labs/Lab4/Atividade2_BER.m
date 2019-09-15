%% 2-PAM c/ COSSENO LEVANTADO

close all
clear
clc

% VARIAVEIS
alfa = 1;
T=1;
f=10;
AMP = 3;
delta=T/f;
randn('seed',0); %seed para randn

BER_ap = [];
energy = [];

bits=0.5e1; %N�mero de bits a serem simulados.
rand('state',0);
randn('state',0);

for AMP=0:0.01:15
    fprintf('Doing for Antipodal and AMP = %i\n',AMP);
    energy = cat(2, energy, AMP^2/T);
    
    % SINAL DE ENTRADA
    y=rand(1,bits)>0.5; %Gera��o de bits 0 e 1 equiprov�veis.
    s=AMP*(2*y-1);
    s_up=upsample(s,f);

    % FILTRO DE TRANSMISSAO
    h=rcosfir(alfa,bits,f,T,'sqrt');
    x=conv(s_up,h);

%     % PLOT PR�-RU�DO
%     figure
%     eixo=-fim*T:delta:(fim+(length(y)-1)+(1-1/f))*T;
%     plot(eixo,x,'r');
%     xlim([-1 5])
%     grid
%     xlabel('tempo (intervalo de s�mbolo)')
%     title('Sinal transmitido - Raiz cosseno levantado')

    % CANAL
    ruido=randn(1,length(x))*sqrt(10);
    x=x+ruido;

    % FILTRO CASADO
    r=conv(x,h); %mesmo pulso base
    t_amostra = linspace(length(h),length(h)+4*(length(h)-1)/10,bits);
    r_amostra=r(round(t_amostra));

    % DECISAO
    amostra_AP = double(r_amostra>0);

    % %PLOT DA AMOSTRAGEM E A SAIDA DO MF
    % figure;
    % t = linspace(-(length(h))/f,length(x)/f,length(r));
    % plot(t,r);
    % xlim([-1 5])
    % hold on;
    % stem(0:1:4,r_amostra);
    % xlabel('tempo (intervalo de s�mbolo)')
    % title('Sinal recebido - P�s Filtro Casado e Amostragem')

    % Compares the messages before and after the system and then registers
    % the calculated BER in order to generate a BER array with the values
    % generated by different amplitudes
    xBits = (y==amostra_AP);
    xBits = (xBits==0);
    xBits = sum(xBits); % Get number of error bits
    BER_ap = cat(2,BER_ap,xBits/bits); % Register the BER values
end
figure;
plot(energy,BER_ap);
hold on

% a=1:length(BER_ap);
% BER_FIT=fit(BER_ap',a','exp2')
% plot(BER_FIT);
