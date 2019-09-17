%% 2-PAM c/ COSSENO LEVANTADO

close all
clear
clc

% VARIAVEIS
alfa = 1;
fim=5;
T=1;
f=10;
AMP = 3;
delta=T/f;
randn('state',0); %seed para randn

% SINAL DE ENTRADA
y=[1 0 0 1 0];
s=AMP*(2*y-1);
s_up=upsample(s,f);

% FILTRO DE TRANSMISSAO
h=rcosfir(alfa,fim,f,T,'sqrt');
x=conv(s_up,h);

% PLOT PRÉ-RUÍDO
figure
eixo=-fim*T:delta:(fim+(length(y)-1)+(1-1/f))*T;
plot(eixo,x,'r');
xlim([-1 5])
grid
xlabel('tempo (intervalo de símbolo)')
title('Sinal transmitido - Raiz cosseno levantado')

% CANAL
ruido=randn(1,length(x))*sqrt(0);
x=x+ruido;

% FILTRO CASADO
r=conv(x,h); %mesmo pulso base
t_amostra = linspace(length(h),length(h)+4*(length(h)-1)/10,5);
r_amostra=r(t_amostra);

% DECISAO
amostra_AP = double(r_amostra>0);

%PLOT DA AMOSTRAGEM E A SAIDA DO MF
figure;
t = linspace(-(length(h))/f,length(x)/f,length(r));
plot(t,r);
xlim([-1 5])
hold on;
stem(0:1:4,r_amostra);
xlabel('tempo (intervalo de símbolo)')
title('Sinal recebido - Pós Filtro Casado e Amostragem')

