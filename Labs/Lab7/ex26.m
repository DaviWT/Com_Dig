%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 26
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
fprintf('Dist. mín. Espaço Livre = %d\n',d_el_C);
fprintf('Dist. mín. Log-Distância = %d\n',d_ld_C);
fprintf('>AT86RF231:\n');
fprintf('Dist. mín. Espaço Livre = %d\n',d_el_A);
fprintf('Dist. mín. Log-Distância = %d\n',d_ld_A);
fprintf('=================\n');
fprintf('>Espaço Livre:\n');
fprintf('AT86RF231 será %.4f maior que CC2420:\n',d_el_A/d_el_C);
fprintf('>Log-Distância:\n');
fprintf('AT86RF231 será %.4f maior que CC2420:\n',d_ld_A/d_ld_C);
fprintf('=================\n');

%% Parte teórica

%
% Como dois rádios que seguem o mesmo padr˜ão podem ter alcances t˜ão diferentes?
% 
% Escolhas de projeto da arquitetura de cada rádio pode fazer com que
% esses alcances máximos variem, dada a potência de tranmissão e a 
% sensibilidade de cada modelo. Como o padrão IEEE 802.15.4 estabelece
% um enlace de 10m, ambos os rádios estão de acordo com a norma, porém
% pelo fato do AT86RF231 possuir um alcance máximo maior há mais chances
% que ele seja utilizado para aplicações em casos específicos onde se
% requer uma distância maior entre os pontos.
%
% Procure folhear os datasheets dos dois rádios em busca de outras diferenças.
%
% Além das diferenças já levantadas pelo professor, foi observado que o rádio 
% da Atmel AT86RF231 possui um hardware para True Random Number Generator (TRNG),
% para aplicações que necessitam de segurança. Outra diferença foi que a interface
% SPI do rádio da Texas Instruments CC2420 funciona com clock de até 10MHz,
% enquanto para o da Atmel seria até 8MHz.
% Links:
% http://ww1.microchip.com/downloads/en/DeviceDoc/doc8111.pdf
% http://www.ti.com/lit/ds/symlink/cc2420.pdf
%
% Como escolher o rádio mais apropriado?
%
% Cada aplicação necessita de um rádio que se encaixe melhor nas condições em que
% a transmissão será feita. Pode depender da distância entre os nós, da taxa de 
% transmissão necessária, consumo energético, e até de funcionalidades secundárias
% como a geração de números aleatórios segura ou parâmetros do bararramento de interface.
%



