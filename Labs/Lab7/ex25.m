%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 25

% Variaveis
fc = 1e9;
Gt = 1;
Gr = 1;
F_db = 4;
F = db2lin(F_db);
N0_dbm = -174;
N0 = 1e-3*db2lin(N0_dbm);
B = 1e6;
EsN0_db = 10;
EsN0 = db2lin(EsN0_db);

% Calculo

% a)
Pl = 0; % Pois é o melhor caso. Não considera-se perda de percurso
Rs = B;
Pr_min = EsN0*Rs*N0*F;
Pr_min_db = lin2db(Pr_min);
fprintf('a) Sensibilidade = %f\n',Pr_min_db);

% b)
Pt = 1;
Pt_db = lin2db(Pt);
Pl_db = Pt_db - Pr_min_db;
d = 10^((Pl_db + 50 -10*log10(fc))/30);
fprintf('b) d = %f\n',d);

% c)
d = 2000;
Pl_db = -50 + 10*log10(fc) + 30*log10(d);
Pt_db = Pr_min_db + Pl_db;
fprintf('c) Pt_db = %f\n',Pt_db);

% d)
Rs = 100e3;
Pt = 1;
Pr_min = EsN0*Rs*N0*F;
Pr_min_db = lin2db(Pr_min);
Pt_db = lin2db(Pt);
Pl_db = Pt_db - Pr_min_db;
d = 10^((Pl_db + 50 -10*log10(fc))/30);
fprintf('d) d = %f\n',d);




