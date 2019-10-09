close all;
clear;

% Variaveis
Nb = 1000;
alfa = 0.5;
fim=5;
Ts=1;
Fs=20;
fc=6;
s=[];
s0=[];

% Criacao dos sinais
bitStream = randint(1,Nb);

const8psk=[-1 1 j -j (1+j)/sqrt(2) (1-j)/sqrt(2) (-1+j)/sqrt(2) (-1-j)/sqrt(2)];
const16qam=[ (-3+3*j) (-1+3*j) (1+3*j) (3+3*j)...
            (-3+j) (-1+j) (1+j) (3+j)...
            (-3-j) (-1-j) (1-j) (3-j)...
            (-3-3*j) (-1-3*j) (1-3*j) (3-3*j)   ];

% Matriz de equivalencia Gray - QAM
tradutoraQAM = [1 2 4 3 5 6 8 7 13 14 16 15 9 10 12 11];
        
% Ajuste da amplitude para garantir mesma Eb entre 8-PSK e 16-QAM     
const16qam = sqrt(4/3)*const16qam;

% Cosseno levantado
g=rcosfir(alfa,fim,Fs,Ts,'sqrt');

% Percorrendo bits e gerando sinal transmitido
for k=1:4:Nb
    % Criando janela com 4 bits
    janela = bitStream(k:k+3);
    janela = bin2dec(int2str(janela)); % Valor numérico
    
    % Criando Simbolo para o dado fc
    index = tradutoraQAM(janela+1);
    c = const16qam(index)*g; % simbolo complexo
    t = linspace(0,1,length(c));
    s = [s real(c.*exp(j*2*pi*(2*fim)*fc.*t))];
    
    % Criando Simbolo para fc = 0
    index0 = tradutoraQAM(janela+1);
    c0 = const16qam(index0)*g; % simbolo complexo
    t0 = linspace(0,1,length(c0));
    s0 = [s0 real(c0.*exp(0))];
end

% Plot do sinal com o dado fc
S = fft(s);
S = fftshift(S)/(Fs);
f_plot = linspace(-Fs/2,Fs/2,length(s));
figure
plot(f_plot,abs(S));
figure;
semilogy(f_plot,abs(S));

% Plot do sinal com fc = 0
S0 = fft(s0);
S0 = fftshift(S0)/(Fs);
f_plot0 = linspace(-Fs/2,Fs/2,length(s0));
figure
plot(f_plot0,abs(S0));
figure;
semilogy(f_plot0,abs(S0));

% Plot dos sinais juntos (em db)
figure;
dB = mag2db(abs(S0));
plot(f_plot0,dB);
hold on
dB = mag2db(abs(S));
plot(f_plot,dB);
title('Sinais na Frequência');
xlabel('Frequência (Hz)'); ylabel('Magnitude (dB)');
axis([-10 10 -150 50]);
legend('Sinal BB','Sinal BP');
