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
tic

Pb = zeros(1,12);
ber = zeros(1,12);

rand('state',0);
randn('state',0);

d=1;

for i=0:12
    bits=1e6; %N�mero de bits a serem simulados.
    
    M=4; %4-PAM, dois s�mbolos poss�veis na modula��o.

    b=randint(1,bits,4); %Gera��o de bits 0 e 1 equiprov�veis.
    s=(2*b-3); %Eb a princ�pio seria 1, j� que as amplitudes s�o +1 e -1. Es tamb�m seria 1, j� que a modula��o � bin�ria (1 bit -> 1 s�mbolo)
    N0=1; %N0 ser� fixa em 1.
    n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a vari�ncia do ru�do ap�s o filtro casado � N0/2 apenas.
    %n=0;
    
    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simula��o.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a raz�o Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modula��o � bin�ria Es=Eb.
    y=sqrt(Es/5)*s+n; %A amplitude dos s�mbolos transmitidos � alterada de modo que a energia m�dia seja Es, e consequentemente Eb seja aquela desejada.
    
    d = sqrt(Es/5);
    
    b_est3=3*(y>=2*d); %Decisor.
    b_est2=2*(y>0 & y<2*d); %Decisor.
    b_est1=1*(y<0 & y>-2*d); %Decisor.
    b_est0=0*(y<=-2*d); %Decisor.
    b_est=b_est0+b_est1+b_est2+b_est3;
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %C�lculo da BER.
    Pb(i+1)=(3/2)*qfunc(sqrt((4/5)*EbN0)); %BER te�rica.
 %   if sum(b_est == 2)==0
 %       error('%i',i);
 %   end

    %fprintf('Para %d [dB]: Simulado: %g | Te�rico: %g\n',i, ber(i+1), Pb(i+1))
        
end
i = 0:1:12;
figure;
semilogy(i,Pb,'b-',i,ber,'ro');
grid on
toc

