%Neste exemplo N0 é mantido fixo e a amplitude dos símbolos varia em função de
%Eb/N0. Outra alternativa é manter a amplitude dos símbolos fixa e variar
%N0 em função de Eb/N0.

%A resposta ao impulso do filtro casado é considerada de energia unitária
%(EMF=1)
%Os símbolos 's' são gerados originalmente como +1 e -1, com energia
%unitária portanto, e sua amplitude é variada de acordo com o valor de Eb necessário para obter a razão Eb/N0 pretendida.

%A simulação é discreta, a partir dos símbolos a serem transmitidos (s)
%geramos a saída amostrada do filtro casado (y).

close all;
clear all;

Pb = zeros(1,10);
ber = zeros(1,10);

rand('state',0);
randn('state',0);

for i=0:10
    bits=1e6; %Número de bits a serem simulados.

    M=2; %2-PAM, dois símbolos possíveis na modulação.

    b=rand(1,bits)>0.5; %Geração de bits 0 e 1 equiprováveis.
    s=2*b-1; %Eb a princípio seria 1, já que as amplitudes são +1 e -1. Es também seria 1, já que a modulação é binária (1 bit -> 1 símbolo).
    N0=1; %N0 será fixa em 1.
    n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.

    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simulação.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a razão Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modulação é binária Es=Eb.

    y=sqrt(Es)*s+n; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.

    b_est=y>0; %Decisor.
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %Cálculo da BER.
    Pb(i+1)=qfunc(sqrt(2*EbN0)); %BER teórica.

    %fprintf('Para %d [dB]: Simulado: %g | Teórico: %g\n',i, ber, Pb)
        
end
i = 0:1:10;
figure;
semilogy(i,Pb,'b-',i,ber,'ro');
grid on
hold on

%% ORT

Pb = zeros(1,12);
ber = zeros(1,12);

rand('state',0);
randn('state',0);

for i=0:12
    bits=1e6; %Número de bits a serem simulados.

    M=2; %2-PAM, dois símbolos possíveis na modulação.

    b=rand(1,bits)>0.5; %Geração de bits 0 e 1 equiprováveis.
    s0=double(b); %Eb a princípio seria 1, já que as amplitudes são +1 e -1. Es também seria 1, já que a modulação é binária (1 bit -> 1 símbolo).
    s1=double(~b);
    N0=1; %N0 será fixa em 1.
    n0=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.
    n1=randn(1,bits)*sqrt(N0/2);
    
    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simulação.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a razão Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modulação é binária Es=Eb.

    y0=sqrt(Es)*s0+n0; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.
    y1=sqrt(Es)*s1+n1;
    
    b_est=y1<y0; %Decisor.
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %Cálculo da BER.
    Pb(i+1)=qfunc(sqrt(EbN0)); %BER teórica.

    %fprintf('Para %d [dB]: Simulado: %g | Teórico: %g\n',i, ber, Pb)
        
end
i = 0:1:12;
semilogy(i,Pb,'b-',i,ber,'ro');

