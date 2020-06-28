%% Ejercicio Butter
clc, clear, close all

%% Cargo un .mpr
save_name = 'turn.mp3';             % Turn the page - Metallica
[x, fs]=audioread(save_name);       % Carga el audio: x es el audio, fs la frecuencia de muestreo
%sound(ft, Fs);                     % Reproduce el audio original
%pause;

% Creación de vector de tiempo para graficar
t=0:1/fs:(length(x)-1)/fs;          % Vector de tiempo
T = 1/fs;                           % Intervalo de tiempo de muestreo

fw=fft(x)/length(x);                % Espectro de la canción original

% Creación del vector de frecuencias
N = floor(length(fw)/2);            % Cantidad de muestras de medio espectro
f=(0:N-1)*fs/2/N;                   % Vector de frecuencias

figure, plot(f,abs(fw(1:N))), grid
title('Espectro del audio original'), xlabel('Frecuencia [Hz]')


%% Creo Sistema ANALOGICO
fc = 1e3;                       % Frecuencia de corte
wc = fc*2*pi;                   % Omega de corte

% Seleccionando uno de los 2 numeradores se consigue un pasa-bajos o un
% pasa-altos. Jugar también con la frecuencia de corte fc definida antes

%num = [1 0 0];                   % Pasa-Altos;  fc recomendada 5kHz
num = (wc)^2;                  % Pasa-Bajos;  fc recomendada 1kHz
den = [1 2*cos(pi/4)*wc wc^2];
Hs = tf(num,den);                 % Función transferencia de Butterworth de 2do orden

% Diagrama de polos y ceros
figure,pzmap(Hs), title('PZMAP, H(s)'), grid, axis([-10000 0 -10000 10000])
a=findobj(gca,'type','line'); set(a(2:end),'linewidth',3), set(a(2:end),'markersize',10),

% Bode
options = bodeoptions; options.FreqUnits = 'Hz';
figure, bode(Hs, options)

% Rta en frecuencia (lineal)
[HH, w]=freqs(num,den);
figure, title('|H(s)| y \phi(H(s))')
subplot(211),plot(w/2/pi,abs(HH)),axis tight,xlabel('Frecuencia [Hz]'), ylabel('|H(w)|')
subplot(212),plot(w/2/pi,angle(HH)),axis tight,xlabel('Frecuencia [Hz]'), ylabel('\phi\{H(w)\}')

% Respuesta al Impulso
figure, impulse(num,den), title('h(t)')


%%
% %% 1) Obtengo Wc DIGITAL;
omegac = wc/fs;
wc_d = 2*fs*tan(omegac/2);                  % Omega de corte digital
disp (['\varomega_c: ' num2str(omegac)])
disp (['\varomega_c: ' num2str(wc)])

%% Calculo Bilinear -> Paso de H(s) ->H(z)
[numz, denz] = bilinear(num,den,fs);        % Transformada bilineal
Hz = tf(numz,denz,fs);                      % Sistema digital
%% Grafico y Filtro digital
% Diagrama Polos y Ceros
figure,pzmap(Hz), title('PZ H(z)')
a=findobj(gca,'type','line'); set(a(2:end),'linewidth',3), set(a(2:end),'markersize',10),

% Respuesta en frecuencia
[HH, w]=freqz(numz,denz);
figure(5), title('|H(z)| y \phi\{H(z)\}')
subplot(211),plot(w,abs(HH)),axis tight,xlabel('Frecuencia angular [1/s]'), ylabel('|H(w)|'), grid
subplot(212),plot(w,angle(HH)),axis tight,xlabel('Frecuencia angular [1/s]'), ylabel('\phi\{H(z)\}'), grid

% Respuesta al Impulso
figure(6),impz(num,den,fs), title('h[n]')

%%
% Filtro el audio
y=filter(numz,denz,x);                  % Audio filtrado con filtro digital
fy = fft(y)/length(y);                  % Espectro del audio filtrado

figure,
ax2 = subplot(211), plot(f,abs(fw(1:length(y)/2))), grid
title('Espectro original'), xlabel('Frecuencia [Hz]')
ax1 = subplot(212), plot(f,abs(fw(1:length(fw)/2)),f,abs(fy(1:length(y)/2))), grid
title('Espectro original y filtrado'), xlabel('Frecuencia [Hz]')
linkaxes([ax1 ax2])

pause()
sound(x,fs),
pause()
sound(y, fs)
