%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
%% Exercício 19 - a)
clear all;
close all;
clc;

fc = 2e9; %2GHz
d = 1000; %1km
fs = 44.1e3; %44.1kHz ou amostras/s
N0 = 1e-20; %dens espec pot W/Hz
B = 8.528e6; %8.528MHz
BER = 1e-5; %10^-5
Q = 16; %bits/amostra
lambda = 3e8/fc;
n = 3; % Do enunciado

Rb_canal_audio = fs*Q;
Rb_canal_dados = 1e6;

Rb_total = 10*Rb_canal_audio + 10*Rb_canal_dados;

for M=[2 4 8 16 32]
    Rs = Rb_total/log2(M);
    if(Rs > B)
        fprintf('%d-PSK: B < Rs = %d\n',M,Rs);
        continue;
    end
    EbN0 = (1/(2*log2(M)))*(qfuncinv(BER*log2(M)/2)/(sin(pi/M)))^2;
    Pr = EbN0*Rb_total*N0;
    Pt = (16*pi^2*d^2/lambda^2)*Pr; %sem ganhos
    Pt_ld = Pr*(16*pi^2/lambda^2)*d^n; % Transformando a fórmula para linear
    Pt_dBm = 10*log10(Pt/1e-3);
    Pt_ld_dBm = 10*log10(Pt_ld/1e-3);
    fprintf('%d-PSK: Pt = %f dBm | Pt_ld = %f dBm\n',M,Pt_dBm,Pt_ld_dBm);
end

fprintf('==========\n');
%% Exercício 19 - b)

fc = 2e9; %2GHz
d = 1000; %1km
fs = 44.1e3; %44.1kHz ou amostras/s
N0 = 1e-20; %dens espec pot W/Hz
B = 8.528e6; %8.528MHz
BER = 1e-5; %10^-5
Q = 16; %bits/amostra
lambda = 3e8/fc;
n = 3; % Do enunciado

Rb_canal_audio = fs*Q;
Rb_canal_dados = 1e6;

Rb_total = 10*Rb_canal_audio + 10*Rb_canal_dados;

for M=[2 4 8 16 32]
    Rs = Rb_total/log2(M);
    if(Rs > B)
        fprintf('%d-QAM: B < Rs = %d\n',M,Rs);
        continue;
    end
    EbN0 = ((M-1)/(3*log2(M)))*(qfuncinv(BER*log2(M)/(4*(1-1/sqrt(M)))))^2;
    Pr = EbN0*Rb_total*N0;
    Pt = (16*pi^2*d^2/lambda^2)*Pr; %sem ganhos
    Pt_ld = Pr*(16*pi^2/lambda^2)*d^n; % Transformando a fórmula para linear
    Pt_dBm = 10*log10(Pt/1e-3);
    Pt_ld_dBm = 10*log10(Pt_ld/1e-3);
    fprintf('%d-QAM: Pt = %f dBm | Pt_ld = %f dBm\n',M,Pt_dBm,Pt_ld_dBm);
end





