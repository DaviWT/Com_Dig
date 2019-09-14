%% Exemplo Antipodal

tic
close all
clear all
clc
warning off
BER_ap = [];
BER_ort = [];
energy = [];
Fs=100;
Ts=1;
M = 4;
Tb = Ts/log2(M);
fprintf('Begin!\n');

% Doing the process to different values of amplitude
for AMP=0:0.05:1.5 
    fprintf('Doing for Antipodal and AMP = %i\n',AMP);
    energy = cat(2, energy, AMP^2/Tb);
    N = 100000;

    bit00=-3*ones(1,Fs);
    bit01=-ones(1,Fs);
    bit10=ones(1,Fs);
    bit11=3*ones(1,Fs);
    %y=[bit1 bit0 bit1 bit0 bit1];
    %t=0:1/Fs:5-1/Fs;

    % Generating random symbols
    y = zeros(1,N*Fs);   % Holds the random generated symbols
    inBits1 = zeros(1,N); % Holds the initial code message
    for i=1:N
        num1 = randint;
        num2 = randint;
        num = [num1 num2];
        inBits1(i) = bin2dec(num2str(num));
        if isequal(num,[0 0])
            y((1+(i-1)*100):100*i) = bit00;
        elseif isequal(num,[0 1])
            y((1+(i-1)*100):100*i) = bit01;
        elseif isequal(num,[1 0])
            y((1+(i-1)*100):100*i) = bit10;
        else
            y((1+(i-1)*100):100*i) = bit11;
        end
    end
    y=AMP.*y;
    rec = y;
    %t=0:1/Fs:N-1/Fs;

    %plot(t,y)
    %xlabel('tempo (s)');
    %axis([0 N -2 2])

    %figure

    h=[ones(1,Fs)];
    %t=0:1/Fs:1-1/Fs;
    %plot(t,h);
    %xlabel('tempo (s)');
    %ylabel('h(t)');
    %axis([0 1 0 1.2])

    %figure

    %r=conv(y,h)/Fs;
    %fim=length(r);
    %t=0:1/Fs:fim/Fs-1/Fs;
    %plot(t,r);
    %t_amostra=[Fs:Fs:N*Fs];
    %r_amostra=r(t_amostra);
    %t_amostra=t_amostra/Fs-1/Fs;
    %hold
    %stem(t_amostra,r_amostra,'r')
    %xlabel('tempo (s)');
    %legend('Sa?da do Filtro','Sa?da Amostrada');
    %axis([0 N -2 2])


    %figure
    fim=length(y);
    ruido=randn(1,fim)*sqrt(20);
    y=y+ruido;

    %t=0:1/Fs:N-1/Fs;
    %plot(t,y)
    %xlabel('tempo (s)');
    %axis([0 N -12 12])

    %figure
    r=conv(y,h)/Fs;
    fim=length(r);
    t=0:1/Fs:fim/Fs-1/Fs;
    %plot(t,r);
    t_amostra=[Fs:Fs:N*Fs];
    r_amostra=r(t_amostra);
    %t_amostra=t_amostra/Fs-1/Fs;
    %hold
    %stem(t_amostra,r_amostra,'r')
    %xlabel('tempo (s)');
    %legend('Sa?da do Filtro','Sa?da Amostrada');

    %DECISAO
    amostra_AP=[];
    for i=1:N
        if (r_amostra(i)<-2*AMP)
            amostra_AP = cat(2,amostra_AP,0);
        elseif (r_amostra(i)<0 && r_amostra(i)>-2*AMP)
            amostra_AP = cat(2,amostra_AP,1);
        elseif (r_amostra(i)>0 && r_amostra(i)<2*AMP)
            amostra_AP = cat(2,amostra_AP,2);
        elseif (r_amostra(i)>2*AMP)
            amostra_AP = cat(2,amostra_AP,3);
        end 
    end
    
    
    % Compares the messages before and after the system and then registers
    % the calculated BER in order to generate a BER array with the values
    % generated by different amplitudes
    xBits = (inBits1==amostra_AP);
    xBits = (xBits==0);
    xBits = sum(xBits); % Get number of error bits
    BER_ap = cat(2,BER_ap,xBits/N); % Register the BER values
    
end
% Generating plot with the energy and the BER values
figure;
plot(energy,BER_ap);
xlabel('Energy'); ylabel('BER');
title('4-PAM')
toc
