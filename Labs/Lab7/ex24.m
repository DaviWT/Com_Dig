%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 24

% Variaveis
Pt = 4e-3;
Gt_db = 5;
Gt = db2lin(Gt_db);
Gr_db = 8;
Gr = db2lin(Gr_db);
Pl_db = 100;
Pl = db2lin(Pl_db);
margem_db = -5;
margem = db2lin(margem_db);
N0_db = -196;
N0 = db2lin(N0_db);
BER = 1e-3;
B = 5e6;
alfa = 0.25;

% Calculo

for M = [ 2 4 8 16 32]
    % Pulso Cosseno levantado
    Rs1 = B/(1+alfa);
    Rb1 = Rs1*log2(M);
    
    % Do exercicio
    EbN0 = (1/(2*log2(M)))*(qfuncinv(BER*log2(M)/2)/(sin(pi/M)))^2;
    EbN0 = EbN0/margem;
    Pr = Pt*Gt*Gr/Pl;
    Rb2 = Pr/(N0*EbN0);
    
    fprintf('M = %2i | Rb(max) = %2.2f\n', M, min([Rb1 Rb2]));
end

