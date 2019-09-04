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
tic

Pb = zeros(1,12);
ber = zeros(1,12);

rand('state',0);
randn('state',0);

d=1;

for i=0:12
    bits=1e6; %Número de bits a serem simulados.
    
    M=4; %4-PAM, dois símbolos possíveis na modulação.

    b=randint(1,bits,4); %Geração de bits 0 e 1 equiprováveis.
    s=(2*b-3); %Eb a princípio seria 1, já que as amplitudes são +1 e -1. Es também seria 1, já que a modulação é binária (1 bit -> 1 símbolo)
    N0=1; %N0 será fixa em 1.
    n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.
    %n=0;
    
    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simulação.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a razão Eb/N0 de interesse.
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modulação é binária Es=Eb.
    y=sqrt(Es/5)*s+n; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.
    
    d = sqrt(Es/5);
    
    b_est3=3*(y>=2*d); %Decisor.
    b_est2=2*(y>0 & y<2*d); %Decisor.
    b_est1=1*(y<0 & y>-2*d); %Decisor.
    b_est0=0*(y<=-2*d); %Decisor.
    b_est=b_est0+b_est1+b_est2+b_est3;
    erros=sum(b~=b_est); %Contagem de erros.
    ber(i+1)=erros/bits; %Cálculo da BER.
    Pb(i+1)=(3/2)*qfunc(sqrt((4/5)*EbN0)); %BER teórica.
 %   if sum(b_est == 2)==0
 %       error('%i',i);
 %   end

    %fprintf('Para %d [dB]: Simulado: %g | Teórico: %g\n',i, ber(i+1), Pb(i+1))
        
end
i = 0:1:12;
figure;
semilogy(i,Pb,'b-',i,ber,'ro');
grid on
toc

