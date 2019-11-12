%Lab7 - Comunica��es Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exerc�cio 26
fprintf('=================\nExercicio 26:\n');
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
d_el_A = sqrt(Pt_A*lambda^2/(16*pi^2*Pr_A));
d_el_C = sqrt(Pt_C*lambda^2/(16*pi^2*Pr_C));

d_ld_A = (Pt_A*lambda^2/(16*pi^2*Pr_A))^(1/n);
d_ld_C = (Pt_C*lambda^2/(16*pi^2*Pr_C))^(1/n);

fprintf('>CC2420:\n');
fprintf('Dist. m�n. Espa�o Livre = %d\n',d_el_C);
fprintf('Dist. m�n. Log-Dist�ncia = %d\n',d_ld_C);
fprintf('>AT86RF231:\n');
fprintf('Dist. m�n. Espa�o Livre = %d\n',d_el_A);
fprintf('Dist. m�n. Log-Dist�ncia = %d\n',d_ld_A);
fprintf('=================\n');
fprintf('>Espa�o Livre:\n');
fprintf('AT86RF231 ser� %.4f maior que CC2420:\n',d_el_A/d_el_C);
fprintf('>Log-Dist�ncia:\n');
fprintf('AT86RF231 ser� %.4f maior que CC2420:\n',d_ld_A/d_ld_C);
fprintf('=================\n');

% DISCLAIMER! Lembrar de fazer parte te�rica!!!!!!!!!




