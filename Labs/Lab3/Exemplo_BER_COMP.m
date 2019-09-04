%Neste exemplo N0 � mantido fixo e a amplitude dos s�mbolos varia em fun��o de
%Eb/N0. Outra alternativa � manter a amplitude dos s�mbolos fixa e variar
%N0 em fun��o de Eb/N0.

%A resposta ao impulso do filtro casado � considerada de energia unit�ria
%(EMF=1)
%Os s�mbolos 's' s�o gerados originalmente como +1 e -1, com energia
%unit�ria portanto, e sua amplitude � variada de acordo com o valor de Eb necess�rio para obter a raz�o Eb/N0 pretendida.

%A simula��o � discreta, a partir dos s�mbolos a serem transmitidos (s)
%geramos a sa�da amostrada do filtro casado (y).

close all;
clear all;

Pb = zeros(1,10);
ber = zeros(1,10);

rand('state',0);
randn('state',0);

for i=0:10
    bits=1e6; %N�mero de bits a serem simulados.

    M=2; %2-PAM, dois s�mbolos poss�veis na modula��o.

    b=rand(1,bits)>0.5; %Gera��o de bits 0 e 1 equiprov�veis.
    s=2*b-1; %Eb a princ�pio seria 1, j� que as amplitudes s�o +1 e -1. Es tamb�m seria 1, j� que a modula��o � bin�ria (1 bit -> 1 s�mbolo).
    N0=1; %N0 ser� fixa em 1.
    n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a vari�ncia do ru�do ap�s o filtro casado � N0/2 apenas.

    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simula��o.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a raz�o Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modula��o � bin�ria Es=Eb.

    y=sqrt(Es)*s+n; %A amplitude dos s�mbolos transmitidos � alterada de modo que a energia m�dia seja Es, e consequentemente Eb seja aquela desejada.

    b_est=y>0; %Decisor.
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %C�lculo da BER.
    Pb(i+1)=qfunc(sqrt(2*EbN0)); %BER te�rica.

    %fprintf('Para %d [dB]: Simulado: %g | Te�rico: %g\n',i, ber, Pb)
        
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
    bits=1e6; %N�mero de bits a serem simulados.

    M=2; %2-PAM, dois s�mbolos poss�veis na modula��o.

    b=rand(1,bits)>0.5; %Gera��o de bits 0 e 1 equiprov�veis.
    s0=double(b); %Eb a princ�pio seria 1, j� que as amplitudes s�o +1 e -1. Es tamb�m seria 1, j� que a modula��o � bin�ria (1 bit -> 1 s�mbolo).
    s1=double(~b);
    N0=1; %N0 ser� fixa em 1.
    n0=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a vari�ncia do ru�do ap�s o filtro casado � N0/2 apenas.
    n1=randn(1,bits)*sqrt(N0/2);
    
    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simula��o.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a raz�o Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modula��o � bin�ria Es=Eb.

    y0=sqrt(Es)*s0+n0; %A amplitude dos s�mbolos transmitidos � alterada de modo que a energia m�dia seja Es, e consequentemente Eb seja aquela desejada.
    y1=sqrt(Es)*s1+n1;
    
    b_est=y1<y0; %Decisor.
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %C�lculo da BER.
    Pb(i+1)=qfunc(sqrt(EbN0)); %BER te�rica.

    %fprintf('Para %d [dB]: Simulado: %g | Te�rico: %g\n',i, ber, Pb)
        
end
i = 0:1:12;
semilogy(i,Pb,'b-',i,ber,'ro');

