%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 27
fprintf('=================\nExercicio 27:\n');
%Variaveis
Pt_max_dbm = 10;
Pt_max = 1e-3*db2lin(Pt_max_dbm);
Pt_min_dbm = -30;
Pt_min = 1e-3*db2lin(Pt_min_dbm);
Rb_max = 500e3;
Rb_min = 1.2e3;
n = 4;
freq = [315e6 433e6 868e6 915e6];
sens_dbm = [-111 -88; -110 -88; -111 -88; -111 -87];
sens = 1e-3*db2lin_matrix(sens_dbm);
d_max = [];
d_min = [];
d_max_ld = [];
d_min_ld = [];
for i=1:4
    fprintf('Freq = %d[Hz]:\n',freq(i));
    lambda = 3e8/freq(i);
    d_max(i) = sqrt(Pt_max*lambda^2/(16*pi^2*sens(i,1)));
    d_min(i) = sqrt(Pt_min*lambda^2/(16*pi^2*sens(i,2)));
    d_max_ld(i) = (Pt_max*lambda^2/(16*pi^2*sens(i,1)))^(1/n);
    d_min_ld(i) = (Pt_min*lambda^2/(16*pi^2*sens(i,2)))^(1/n);
    
    fprintf('> d max espaço-livre: %.2f[m]:\n',d_max(i));
    fprintf('> d min espaço-livre: %.2f[m]:\n',d_min(i));
    fprintf('> d max log-distância: %.2f[m]:\n',d_max_ld(i));
    fprintf('> d min log-distância: %.2f[m]:\n',d_min_ld(i));
end
fprintf('=================\n');


