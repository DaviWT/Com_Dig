%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;
%% Exercício 20
fprintf('=================\nExercicio 20:\n');

% Variaveis do Exercicio
Fdb = 5;
fc = 2*10^9;
Pt = 1;
Gtdb = 2;
Gt = 10^(Gtdb/10);
Grdb = 2 - Fdb;
Gr = 10^(Grdb/10);
T = 290;
M = 8;
d = 1000;
BER = 1*10^-5;
lambda = 3e8/fc;
n = 3;

% Calculo
EbN0 = (1/(2*log2(M)))*(qfuncinv(BER*log2(M)/2)/(sin(pi/M)))^2;
Pr = Pt*Gt*Gr*(lambda^2/(16*pi^2*d^2));
N0 = 1.38e-23*T;
Rb = Pr/(N0*EbN0);

fprintf('Rb Espaço Livre = %d\n',Rb);

Pl_el_d0 = (16*pi^2/lambda^2);
Pl_el_d0_db = 10*log10(Pl_el_d0);
Pl_ld_db = Pl_el_d0_db + 10*n*log10(d);
Pl_ld = 10^(Pl_ld_db/10);
Pr_ld = Pt*Gt*Gr/Pl_ld;
Rb_ld = Pr_ld/(N0*EbN0);

fprintf('Rb Log-Distância = %d\n',Rb_ld);

%% Exercício 21
fprintf('=================\nExercicio 21:\n');
desempenho = 3;
EbN0_novo = EbN0 / 10^(desempenho/10);
Rb = Pr/(N0*EbN0_novo);
Rb_ld = Pr_ld/(N0*EbN0_novo);

fprintf('Rb Espaço Livre = %d\n',Rb);
fprintf('Rb Log-Distância = %d\n',Rb_ld);

%% Exercício 22
fprintf('=================\nExercicio 22:\n');
desempenho = 3 - 10;
EbN0_novo = EbN0 / 10^(desempenho/10);
Rb = Pr/(N0*EbN0_novo);
Rb_ld = Pr_ld/(N0*EbN0_novo);

fprintf('Rb Espaço Livre = %d\n',Rb);
fprintf('Rb Log-Distância = %d\n',Rb_ld);

