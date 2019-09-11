clear;
close all;

%Veja o help da função rcosfir para compreender os parâmetros a seguir
fim=5;
T=1;
f=10;
delta=T/f;
color = 'rgb'

%% RAIZ COSSENO LEVANTADO
for alfa = 0:0.5:1
    f=10;
    fprintf('alfa = %i\n',alfa); 
    h=rcosfir(alfa,fim,f,T,'sqrt');
    figure(1);
    eixo=-fim*T:delta:fim*T;
    plot(eixo,h,color((2*alfa+1)))
    hold on;
    xlabel('tempo (intervalo de símbolo)')
    title('Raiz cosseno levantado')
    legend('\alpha=0.5');
    grid

    bits=[1 0 0 1 0];
    s=2*bits-1;
    s_up=upsample(s,f);
    x=conv(s_up,h);
    figure(2)
    eixo=-fim*T:delta:(fim+(length(bits)-1)+(1-1/f))*T;
    plot(eixo,x,color((2*alfa+1)));
    hold on;
    grid
    xlabel('tempo (intervalo de símbolo)')
    title('Sinal transmitido - Raiz cosseno levantado')
    xlim([-3 8])


    %% Resposta em Frequencia Usando a Expressão Exata da Transformada de Fourier (pode ser feito via FFT a partir do pulso no tempo também)
    conta=0;
    W=1;
    f1=(1-alfa)*W;

    for ff=-2*(2*W-f1):0.01:-(2*W-f1)-0.01
        conta=conta+1;
        H(conta)=0;
        f(conta)=ff;
    end 
    for ff=-(2*W-f1):0.01:-f1-0.01
        conta=conta+1;
        H(conta)=(1/(4*W))*(1+cos(pi/(2*W*alfa)*(abs(ff)-W*(1-alfa))));
        f(conta)=ff;
    end    
    for ff=-f1:0.01:f1
        conta=conta+1;
        H(conta)=1/(2*W);
        f(conta)=ff;
    end
    for ff=f1+0.01:0.01:(2*W-f1)
        conta=conta+1;
        H(conta)=(1/(4*W))*(1+cos(pi/(2*W*alfa)*(abs(ff)-W*(1-alfa))));
        f(conta)=ff;
    end    
    for ff=(2*W-f1)+0.01:0.01:2*(2*W-f1)
        conta=conta+1;
        H(conta)=0;
        f(conta)=ff;
    end 

    figure(3)
    plot(f,2*W*H,color((2*alfa+1)))
    hold on;
    axis([-3 3 0 1.1])
    grid
    title('Resposta em Frequência - Raiz cosseno levantado')
%    legend('\alpha=0.5');
    xlabel('\times R/2 (Hz)');
    ylabel('H(f)');

end
H = 0;
%% COSSENO LEVANTADO
for alfa = 0:0.5:1
    f=10;
    fprintf('alfa = %i\n',alfa); 
    h=rcosfir(alfa,fim,f,T);
    figure(4);
    eixo=-fim*T:delta:fim*T;
    plot(eixo,h,color((2*alfa+1)))
    hold on;
    xlabel('tempo (intervalo de símbolo)')
    title('Cosseno levantado')
    legend('\alpha=0.5');
    ylim([-0.3 1.2])
    grid

    bits=[1 0 0 1 0];
    s=2*bits-1;
    s_up=upsample(s,f);
    x=conv(s_up,h);
    figure(5)
    eixo=-fim*T:delta:(fim+(length(bits)-1)+(1-1/f))*T;
    plot(eixo,x,color((2*alfa+1)));
    grid
    xlabel('tempo (intervalo de símbolo)')
    title('Sinal transmitido - Cosseno levantado')
    xlim([-3 8])
    ylim([-1.2 1.2])


    %% Resposta em Frequencia Usando a Expressão Exata da Transformada de Fourier (pode ser feito via FFT a partir do pulso no tempo também)
    conta=0;
    W=1;
    f1=(1-alfa)*W;

    for ff=-2*(2*W-f1):0.01:-(2*W-f1)-0.01
        conta=conta+1;
        H(conta)=0;
        f(conta)=ff;
    end 
    for ff=-(2*W-f1):0.01:-f1-0.01
        conta=conta+1;
        H(conta)=(1/(4*W))*(1+cos(pi/(2*W*alfa)*(abs(ff)-W*(1-alfa))));
        f(conta)=ff;
    end    
    for ff=-f1:0.01:f1
        conta=conta+1;
        H(conta)=1/(2*W);
        f(conta)=ff;
    end
    for ff=f1+0.01:0.01:(2*W-f1)
        conta=conta+1;
        H(conta)=(1/(4*W))*(1+cos(pi/(2*W*alfa)*(abs(ff)-W*(1-alfa))));
        f(conta)=ff;
    end    
    for ff=(2*W-f1)+0.01:0.01:2*(2*W-f1)
        conta=conta+1;
        H(conta)=0;
        f(conta)=ff;
    end 

    figure(6)
    plot(f,2*W*H,color((2*alfa+1)))
    hold on;
    axis([-3 3 0 1.1])
    grid
    title('Resposta em Frequência - Cosseno levantado')
%    legend('\alpha=0.5');
    xlabel('\times R/2 (Hz)');
    ylabel('H(f)');

end

