clear;
close all;

% Variables
fim=5;
T=1;
f=10;
delta=T/f;
color = 'rgb';

%% RAIZ COSSENO LEVANTADO
for alfa = 0:0.5:1
    f=10;
    fprintf('alfa = %i\n',alfa); 
    
    % Resposta ao impulso - Raiz Cosseno Levantado
    h = rcosfir(alfa,fim,f,T,'sqrt');
    
    % Plot
    figure(1);
    eixo=-fim*T:delta:fim*T;
    plot(eixo,h,color((2*alfa+1)))
    hold on;
    xlabel('tempo (intervalo de símbolo)')
    title('Raiz cosseno levantado')
    grid

    % Bits transmitidos
    bits=[1 0 0 1 0];
    s=2*bits-1;
    s_up=upsample(s,f);
    x=conv(s_up,h);
    
    % Plot
    figure(2)
    eixo=-fim*T:delta:(fim+(length(bits)-1)+(1-1/f))*T;
    plot(eixo,x,color((2*alfa+1)));
    hold on;
    grid
    xlabel('tempo (intervalo de símbolo)')
    title('Sinal transmitido - Raiz cosseno levantado')
    xlim([-3 8])


    %% Resposta em Frequencia Usando a Expressão Exata da Transformada de Fourier (pode ser feito via FFT a partir do pulso no tempo também)
    
    W=1;
    H = fftshift(fft(h,1001));

    % Plot
    figure(3)
    f_plot = linspace(-4,4,1001);
    plot(f_plot,2*W*abs(H)/f,color((2*alfa+1)))
    hold on;
    axis([-2 2 0 0.8])
    grid
    title('Resposta em Frequência - Raiz cosseno levantado')
    xlabel('\times R/2 (Hz)');
    ylabel('H(f)');

end
H = 0;

%% COSSENO LEVANTADO
for alfa = 0:0.5:1
    f=10;
    fprintf('alfa = %i\n',alfa); 
    
    % Resposta ao impulso - Cosseno Levantado
    h=rcosfir(alfa,fim,f,T);
    
    % Plot
    figure(4);
    eixo=-fim*T:delta:fim*T;
    plot(eixo,h,color((2*alfa+1)))
    hold on;
    xlabel('tempo (intervalo de símbolo)')
    title('Cosseno levantado')
    ylim([-0.3 1.2])
    grid

    % Bits transmitidos
    bits=[1 0 0 1 0];
    s=2*bits-1;
    s_up=upsample(s,f);
    x=conv(s_up,h);
    
    % Plot
    figure(5)
    eixo=-fim*T:delta:(fim+(length(bits)-1)+(1-1/f))*T;
    plot(eixo,x,color((2*alfa+1)));
    hold on;
    grid
    xlabel('tempo (intervalo de símbolo)')
    title('Sinal transmitido - Cosseno levantado')
    xlim([-3 8])
    ylim([-2 2])


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
    
    % Plot
    figure(6)
    plot(f,2*W*H,color((2*alfa+1)))
    hold on;
    axis([-3 3 0 1.1])
    grid
    title('Resposta em Frequência - Cosseno levantado')
    xlabel('\times R/2 (Hz)');
    ylabel('H(f)');

end

% Plots' legends
figure(6);
legend('\alpha=0','\alpha=0.5','\alpha=1');
figure(5);
legend('\alpha=0','\alpha=0.5','\alpha=1');
figure(4);
legend('\alpha=0','\alpha=0.5','\alpha=1');
figure(3);
legend('\alpha=0','\alpha=0.5','\alpha=1');
figure(2);
legend('\alpha=0','\alpha=0.5','\alpha=1');
figure(1);
legend('\alpha=0','\alpha=0.5','\alpha=1');

% Save figures
% saveas(figure(1),'Pulso_Raiz_Cosseno.bmp')
% saveas(figure(2),'Sinal_Transmitido_Raiz_Cosseno.bmp')
 saveas(figure(3),'Frequencia_Raiz_Cosseno.bmp')
% saveas(figure(4),'Pulso_Cosseno.bmp')
% saveas(figure(5),'Sinal_Transmitido_Cosseno.bmp')
% saveas(figure(6),'Frequencia_Cosseno.bmp')


