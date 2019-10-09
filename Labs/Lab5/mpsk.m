close all;
clear all;


%bertool
%% Plot BER M-PSK
load mpsk.mat
semilogy(ebno0,ber0,'-kp');
grid on;
hold on;
semilogy(ebno1,ber1,'r');
hold on;
semilogy(ebno2,ber2,'g');
hold on;
semilogy(ebno3,ber3,'b');
hold on;
axis([0 20 1e-5 1]);
legend('BPSK','QPSK','8-PSK','16-PSK');
title('PLOT BER M-PSK');
xlabel('Eb/N0');
ylabel('BER');

%% Plot BER M-QAM
figure;
load mqam.mat
semilogy(ebnoA,berA,'-kp');
grid on;
hold on;
semilogy(ebno1,ber1,'b');
hold on;
semilogy(ebno2,ber2,'r');
hold on;
axis([0 20 1e-5 1]);
legend('4-QAM','16-QAM','64-QAM');
title('PLOT BER M-QAM');
xlabel('Eb/N0');
ylabel('BER');

%% CONSTELAÇÃO
Nb = 1000;

% Plots sem ruido
const8psk=[-1 1 j -j (1+j)/sqrt(2) (1-j)/sqrt(2) (-1+j)/sqrt(2) (-1-j)/sqrt(2)];
const16qam=[ (-3+3*j) (-1+3*j) (1+3*j) (3+3*j)...
            (-3+j) (-1+j) (1+j) (3+j)...
            (-3-j) (-1-j) (1-j) (3-j)...
            (-3-3*j) (-1-3*j) (1-3*j) (3-3*j)   ];
        
%Ajuste da amplitude para garantir mesma Eb entre 8-PSK e 16-QAM     
const16qam = sqrt(4/3)*const16qam;

scatterplot(const8psk);
scatterplot(const16qam);

% Plots com ruido
for ruido = [0.02 0.05 0.1 0.15 0.2]
    % 8-PSK
    u=ceil(rand(1,Nb)*8);
    x=const8psk(u)+ruido*randn(1,length(u))+j*ruido*randn(1,length(u));
    scatterplot(x);
    titulo = sprintf('8-PSK - ruido = %.2d',ruido);
    title(titulo);
    
    % 16-QAM
    u=ceil(rand(1,Nb)*16);
    x=const16qam(u)+ruido*randn(1,length(u))+j*ruido*randn(1,length(u));
    scatterplot(x);
    titulo = sprintf('16-QAM - ruido = %.2d',ruido);
    title(titulo);
end