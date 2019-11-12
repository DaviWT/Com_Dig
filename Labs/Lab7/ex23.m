%Lab7 - Comunicações Digitais
%Alunos: Adriano e Davi
clear all;
close all;
clc;

%% Exercício 23

Gt1 = 1;
Gt2 = 1;
Pl1_db = 110;
Pl2_db = 110;
Rb1 = 10e3;
Rb2 = 1e6;
Gr1_db = 2.3;
Gr2_db = 2.3;
N01_db = -195;
N02_db = -195;
M1 = 8;
M2 = 4;
BER1 = 1e-3;
BER2 = 10e-3;
margem1_db = -10;
margem2_db = -10;

EbN01 = (1/(2*log2(M1)))*(qfuncinv(BER1*log2(M1)/2)/(sin(pi/M1)))^2;
EbN01_novo = EbN01 / 10^(margem1_db/10);
Pr1 = EbN01_novo*Rb1*db2lin(N01_db);
Pt1 = db2lin(Pl1_db)*Pr1/(Gt1*db2lin(Gr1_db));

EbN02 = (1/(2*log2(M2)))*(qfuncinv(BER2*log2(M2)/2)/(sin(pi/M2)))^2;
EbN02_novo = EbN02 / 10^(margem2_db/10);
Pr2 = EbN02_novo*Rb2*db2lin(N02_db);
Pt2 = db2lin(Pl2_db)*Pr2/(Gt2*db2lin(Gr2_db));

Pt1 = lin2db(Pt1);
Pt2 = lin2db(Pt2);

if Pt1 > Pt2
    fprintf('PtA = %2.2fdbW > PtB = %2.2fdbW\n',Pt1,Pt2);
else
    fprintf('PtA = %2.2fdbW < PtB = %2.2fdbW\n',Pt1,Pt2);
end

