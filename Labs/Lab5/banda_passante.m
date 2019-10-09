close all;
clear all;

% Variaveis
Nb = 1000;
alfa = 0.5;
fim=5;
Ts=1;
Fs=20;
fc=6;
s=[];

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
    janela = bin2dec(int2str(janela)); % Valor num�rico
    
    % Criando Simbolo
    index = tradutoraQAM(janela+1);
    c = const16qam(index)*g; % simbolo complexo
    t = linspace(0,1,length(c));
    s = [s real(c.*exp(j*2*pi*(2*fim)*fc.*t))];
end

S = fft(s);
S = fftshift(S)/(Fs);
f_plot = linspace(-Fs/2,Fs/2,length(s));
plot(f_plot,abs(S));
figure;
semilogy(f_plot,abs(S));

%TODO: plot do Banda-Base