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

%% Parte te�rica

%
% Como dois r�dios que seguem o mesmo padr��o podem ter alcances t��o diferentes?
% 
% Escolhas de projeto da arquitetura de cada r�dio pode fazer com que
% esses alcances m�ximos variem, dada a pot�ncia de tranmiss�o e a 
% sensibilidade de cada modelo. Como o padr�o IEEE 802.15.4 estabelece
% um enlace de 10m, ambos os r�dios est�o de acordo com a norma, por�m
% pelo fato do AT86RF231 possuir um alcance m�ximo maior h� mais chances
% que ele seja utilizado para aplica��es em casos espec�ficos onde se
% requer uma dist�ncia maior entre os pontos.
%
% Procure folhear os datasheets dos dois r�dios em busca de outras diferen�as.
%
% Al�m das diferen�as j� levantadas pelo professor, foi observado que o r�dio 
% da Atmel AT86RF231 possui um hardware para True Random Number Generator (TRNG),
% para aplica��es que necessitam de seguran�a. Outra diferen�a foi que a interface
% SPI do r�dio da Texas Instruments CC2420 funciona com clock de at� 10MHz,
% enquanto para o da Atmel seria at� 8MHz.
% Links:
% http://ww1.microchip.com/downloads/en/DeviceDoc/doc8111.pdf
% http://www.ti.com/lit/ds/symlink/cc2420.pdf
%
% Como escolher o r�dio mais apropriado?
%
% Cada aplica��o necessita de um r�dio que se encaixe melhor nas condi��es em que
% a transmiss�o ser� feita. Pode depender da dist�ncia entre os n�s, da taxa de 
% transmiss�o necess�ria, consumo energ�tico, e at� de funcionalidades secund�rias
% como a gera��o de n�meros aleat�rios segura ou par�metros do bararramento de interface.
%



