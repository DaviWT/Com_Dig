close all;
clear all;
fprintf('Executando...\n');

% Folder to save the images
pathImagens = strcat(fileparts(mfilename('fullpath')),'\Imagens\');

% Verify if exis imagens folder
if ~exist('Imagens','dir')
    mkdir(fileparts(mfilename('fullpath')),'Imagens');
end

%% Plot BER M-FSK
load lab6.mat
semilogy(ebno0,ber0,'k');
grid on;
hold on;
semilogy(ebno1,ber1,'r');
hold on;
semilogy(ebno2,ber2,'g');
hold on;
semilogy(ebno3,ber3,'b');
hold on;
axis([0 16 1e-5 1]);
legend('BFSK','4-FSK','8-FSK','16-FSK');
title('BER M-FSK');
xlabel('Eb/N0');
ylabel('BER');
saveas(gcf,strcat(pathImagens,'BER_M-FSK.bmp'));

%% Comparativo Detecção Coerente e Não-Coerente (BFSK)
figure;
semilogy(ebno0,ber0,'r');
grid on;
hold on;
semilogy(ebno4_NC,ber4_NC,'b');
hold on;
axis([0 16 1e-5 1]);
legend('COERENTE','NÃO COERENTE');
title('COMPARAÇÃO BER BFSK');
xlabel('Eb/N0');
ylabel('BER');
saveas(gcf,strcat(pathImagens,'BFSK_Coerente.bmp'));

%% SINAL E ESPECTRO BFSK
Nb = 100;
Rs = 2000;
M = 2;
f0 = 1000;
Fs = 4*ceil(f0 + 3*Rs/2 + 0.1*(f0 + 3*Rs/2));
Ts = 1/Rs;
Eb = 1;
Es = Eb*log2(M);
f = (f0:Rs/2:f0 + (Rs/2)*(M-1));

%Vetor random
bitStream = randint(1,Nb);

% Gerando vetor de simbolos
t = 0:1/Fs:(2*Nb-1)*1/Fs;

s = [];
for k = bitStream
    si = sqrt((2*Es)/Ts)*cos(2*pi*f(k+1)*t + 0);
    s = cat(2,s,si);
end 

%Plot do sinal no tempo
t_plot = 0:1/Fs:2*(Nb-1)*1/Fs*(Nb+1)+1/Fs;
figure;
plot(t_plot,s);
xlim([0 50e-3]);
title('Sinal do BFSK no Tempo');
xlabel('Tempo');
ylabel('Amplitude');
saveas(gcf,strcat(pathImagens,'BFSK_tempo.bmp'));

%Plot do espectro
S = fftshift(fft(s))/Fs;
f_plot = linspace(-Fs/2,Fs/2,length(S));
figure;
plot(f_plot,abs(S));
title('Espectro do BFSK na Frequência');
xlabel('Frequência');
ylabel('Amplitude');
saveas(gcf,strcat(pathImagens,'BFSK_freq.bmp'));

%% PLOT E ESPECTRO 4-FSK
M = 4;
Es = Eb*log2(M);
f = (f0:Rs/2:f0 + (Rs/2)*(M-1));

% Gerando vetor de simbolos
t = 0:1/Fs:(2*Nb-1)*1/Fs;
bitStream = randint(1,2*Nb);

s = [];
for k=1:2:2*Nb
    % Criando janela com 2 bits
    janela = bitStream(k:k+1);
    janela = bin2dec(int2str(janela)); % Valor numérico
    
    % Criando Simbolo
    si = sqrt((2*Es)/Ts)*cos(2*pi*f(janela+1)*t + 0);
    s = cat(2,s,si);
end

%Plot do sinal no tempo
t_plot = 0:1/Fs:2*(Nb-1)*1/Fs*(Nb+1)+1/Fs;
figure;
plot(t_plot,s);
xlim([0 50e-3]);
title('Sinal do 4-FSK no Tempo');
xlabel('Tempo');
ylabel('Amplitude');
saveas(gcf,strcat(pathImagens,'4-FSK_tempo.bmp'));

%Plot do espectro
S = fftshift(fft(s))/Fs;
f_plot = linspace(-Fs/2,Fs/2,length(S));
figure;
plot(f_plot,abs(S));
title('Espectro do 4-FSK na Frequência');
xlabel('Frequência');
ylabel('Amplitude');
saveas(gcf,strcat(pathImagens,'4-FSK_freq.bmp'));

fprintf('FIM\n');
