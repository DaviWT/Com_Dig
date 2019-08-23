%Exemplo Antipodal
close all
clear all

for AMP=1:10:100
    Fs=100;
    Ts=1;
    N = 1e5;

    bit1=ones(1,Fs);
    bit0=-ones(1,Fs);
    y=[];
    inBit1=[];
    for i=1:N
        num=randint;
        if num==1
            y = cat(2,y,bit1);
        else
            y = cat(2,y,bit0);
        end
        inBit1 = cat(2, inBit1, num);
    end
    y=AMP.*y;
    rec = y;
    t=0:1/Fs:N-1/Fs;

    figure
    plot(t,y)
    xlabel('tempo (s)');
    axis([0 N -2*AMP 2*AMP])

    figure;
    plot(abs(fft(y)));

    figure
    fim=length(y);
    ruido=randn(1,fim)*sqrt(100);%Potencia do ruido=100
    y=y+ruido;

    t=0:1/Fs:N-1/Fs;
    plot(t,y)
    xlabel('tempo (s)');
    axis([0 N -10 10])

    %% Detecção do sinal antipodal
    figure;
    plot(abs(fft(y)));

    fc = 10;
    [B,A] = butter(10,fc/(Fs/2));
    out = filter(B,A,y);
    plot(t,rec);
    hold on;
    plot(t,out,'r');

    outBits=[];
    for i = 1:N
        bitX = out(1+((i-1)*100):i*100);
        if bitX(50)>=0
            outBits=cat(2, outBits, 1);
        else
            outBits=cat(2, outBits, 0);
        end
    end
    
    xBits = (inBit1==outBit1);
    xBits = xBits==0;
    xBits = sum(xBits);
    BER_ap=cat(2,BER_ap,xBits/N);
    %% Exemplo Ortogonal

    bit1=ones(1,Fs);
    bit0=[ones(1,Fs/2) -ones(1,Fs/2)];
    y=[];
    inBit2=[];
    for i=1:N
        num=randint;
        if num==1
            y = cat(2,y,bit1);
        else
            y = cat(2,y,bit0);
        end
        inBit2 = cat(2, inBit2, num);
    end
    y=AMP.*y;
    t=0:1/Fs:N-1/Fs;
    rec = y;

    figure
    plot(t,y)
    xlabel('tempo (s)');
    axis([0 N -2*AMP 2*AMP])

    figure
    fim=length(y);
    ruido=randn(1,fim)*sqrt(100); %Potencia do ruido=100
    y=y+ruido;

    t=0:1/Fs:N-1/Fs;
    plot(t,y)
    xlabel('tempo (s)');
    axis([0 N -10 10])

    %% Detecção do sinal ortogonal
    figure;
    plot(abs(fft(y)));

    fc = 20;
    [B,A] = butter(10,fc/(Fs/2));
    out = filter(B,A,y);
    plot(t,rec);
    hold on;
    plot(t,out,'r');

    outBits2=[];
    for i = 1:N
        bitX = out(1+((i-1)*100):i*100);
        if bitX(25)>0 && bitX(75)>0
            outBits2=cat(2, outBits2, 1);
        else
            outBits2=cat(2, outBits2, 0);
        end
    end
    
    xBits = (inBit2==outBit2);
    xBits = xBits==0;
    xBits = sum(xBits);
    BER_ort=cat(2,BER_ort,xBits/N);
end

en = [1:10:100];

figure;
plot(en,BER_ap);
hold on;
plot(en,BER_ort,'r');

pause;
close all;