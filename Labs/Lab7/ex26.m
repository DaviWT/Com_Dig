%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 26

% Variaveis
Pt_C = 1e-3;
Pr_C_dbm = -95;
Pr_C = 1e-3*db2lin(Pr_C_dbm);
Rb_C = 250e3;
Pt_A_dbm = 3;
Pt_A = 1e-3*db2lin(Pt_A_dbm);
Pr_A_dbm = -101;
Pr_A = 1e-3*db2lin(Pr_A_dbm);
Rb_A = 250e3;
n = 4;
fc = 2.4e9;

% Calculo
lambda = 3e8/fc;
d_el = sqrt(Pr_A*16*pi^2/(Pt_A*lambda^2));  %corrigir!!!


