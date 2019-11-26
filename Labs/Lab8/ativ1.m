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
clc;
fprintf('Executando...\n');

rand('state',0);
randn('state',0);

for i=0:12
    bits=1e6; %Número de bits a serem simulados.

    M=2; %2-PSK = 2-PAM, dois símbolos possíveis na modulação.
    
    b = 1*(rand(1,bits)>0.5);
    b_4_7=1*(rand(4,bits)>0.5)'; %Geração de bits 0 e 1 equiprováveis.
    b_11_15=1*(rand(11,bits)>0.5)';
    frames_original = bi2de(b_11_15)';
    code_4_7 = encode(b_4_7,7,4,'hamming');
    code_11_15 = encode(b_11_15,15,11,'hamming');
    s=2*b-1; 
    s2=(2*(code_4_7)-1)';
    s3=(2*(code_11_15)-1)';
    N0=1; %N0 será fixa em 1.
    n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.
    n2=randn(7,bits)*sqrt(N0/2);
    n3=randn(15,bits)*sqrt(N0/2);
    
    EbN0dB=i; %Valor de Eb/N0 a ser considerado na simulação.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    EbN02 = EbN0 * (4/7);
    EbN03 = EbN0 * (11/15);
    Eb=EbN0*N0; %Eb requerido para atingir a razão Eb/N0 de interesse.
    Eb2=EbN02*N0;
    Eb3=EbN03*N0;
    Es=Eb*log2(M); %Es calculado a partir de Eb. Como a modulação é binária Es=Eb.
    Es2=Eb2*log2(M);
    Es3=Eb3*log2(M);
    
    y=sqrt(Es)*s+n; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.
    y2=sqrt(Es2)*s2+n2;
    y3=sqrt(Es3)*s3+n3;
    
    b_est=y>0; %Decisor.
    b_est2=1*(y2>0)'; %Decisor.
    b_est3=1*(y3>0)'; %Decisor.
    
    msg2 = decode(b_est2,7,4,'hamming');
    msg3 = decode(b_est3,15,11,'hamming');
    frames_decoded = bi2de(msg3)';
    
    erros=sum(b~=b_est); %Contagem de erros.
    erros2=sum(sum(b_4_7~=msg2))/4; %Contagem de erros.
    erros3=sum(sum(b_11_15~=msg3))/11; %Contagem de erros.
    erros_frames = sum(frames_original~=frames_decoded); %Contagem de erros.
    ber(i+1)=erros/bits; %Cálculo da BER.
    ber2(i+1)=(erros2/bits); %Cálculo da BER.
    ber3(i+1)=(erros3/bits); %Cálculo da BER.
    fer_sim(i+1) = erros_frames/length(frames_original);  
    fer_calc(i+1) = calcFER_decoded(15,ber3(i+1));  %PROVAVELMENTE ERRADO!
    fer_not_coded(i+1) = 1-(1-ber(i+1))^11;
end
i = 0:1:12;
figure;
semilogy(i,ber,'ko-',i,ber2,'bo-',i,ber3,'ro-');
axis([0 11 1e-5 1])
grid on

  
figure;
semilogy(i,fer_sim,'ro-',i,fer_calc,'bo-',i,fer_not_coded,'go-');
axis([0 11 1e-6 1])
grid on
