%% Ejercicio Butter
clc, clear, close all

%% Cargo un .mpr
save_name = 'turn.mp3';             % Turn the page - Metallica
[x, fs] = audioread(save_name);     % Carga el audio: x es el audio, fs la frecuencia de muestreo
%sound(x, fs);                      % Reproduce el audio original
%pause;

% Creación de vector de tiempo para graficar
Ts = 1/fs;                        % Intervalo de tiempo de muestreo
t = 0:Ts:(length(x)-1)/fs;        % Vector de tiempo


fw = fft(x)/length(x);              % Espectro de la canción original

% Creación del vector de frecuencias
N = floor(length(fw)/2);            % Cantidad de muestras de medio espectro
f = (0:N-1)*fs/2/N;                 % Vector de frecuencias

figure, plot(f,abs(fw(1:N))), grid
title('Espectro del audio original'), xlabel('Frecuencia [Hz]')

disp(['Frecuencia de muestreo (fs) = ',num2str(fs)]);


%% Creo Sistema ANALOGICO
fc = 1e3;                       % Frecuencia de corte
wc = fc*2*pi;                   % Omega de corte

% Seleccionando uno de los 2 numeradores se consigue un pasa-bajos o un
% pasa-altos. Jugar también con la frecuencia de corte fc definida antes
% num = [1 0 0];                  % Pasa-Altos;  fc recomendada 5kHz
num = (wc)^2;                   % Pasa-Bajos;  fc recomendada 1kHz
den = [1 sqrt(2)*wc wc^2];      % Denominador de un butterworth 2do orden
Hs = tf(num,den)                % Función transferencia de Butterworth de 2do orden

% Bode
options = bodeoptions; options.FreqUnits = 'Hz';
figure, bode(Hs, options), grid

% Respuesta al Impulso
figure, impulse(num,den), title('h(t)'), grid

% Diagrama de polos y ceros
figure, pzmap(Hs), title('Diagrama de polos y ceros H(s)'), grid, axis([-10000 0 -10000 10000])
a=findobj(gca,'type','line'); set(a(2:end),'linewidth',3), set(a(2:end),'markersize',10),


%% Calculo Bilineal -> Paso de H(s) ->H(z)
[numz, denz] = bilinear(num,den,fs);            % Transformada bilineal
Hz = tf(numz,denz,1/fs)                         % Sistema digital

% Respuesta al Impulso
[hn, nn] = impulse(Hz);
figure(6);  stem(nn*fs, hn); title('h[n]'), xlabel('Muestras')

% Diagrama Polos y Ceros
figure ,pzmap(Hz), title('Diagrama de polos y ceros H(z)')
a = findobj(gca,'type','line'); set(a(2:end),'linewidth',3), set(a(2:end),'markersize',10),


%% Obtengo Wc DIGITAL;
Omegac = wc/fs;                               % Omega de corte "esperada"
Omegac_bil = 2*atan(Omegac/2);                % Omega de corte real bilineal
fc_bil = Omegac_bil *fs/2/pi;                 % Frecuencia de corte obtenida al aplicar Bilineal

disp (['Frecuencia de corte ideal/esperada: ' num2str(fc)])
disp (['Frecuencia de corte bilineal: ' num2str(fc_bil)])


%% Grafico y Filtro digital

[HHs, ws] = freqs(num,den);                   % Rta en frecuencia del filtro analógico
[HHz, wz] = freqz(numz,denz);                 % Rta en frecuencia del filtro digital

figure
plot(ws/2/pi, abs(HHs), '--b', wz*fs/2/pi, abs(HHz),'r','linewidth',2),  grid
legend('Filtro analógico','Filtro digital'), xlabel('Frecuencia [Hz]')

%%
% Filtro el audio
y = filter(numz,denz,x);                  % Audio filtrado con filtro digital
fy = fft(y)/length(y);                    % Espectro del audio filtrado

figure,
ax2 = subplot(211), plot(f,abs(fw(1:length(y)/2))), grid
title('Espectro original'), xlabel('Frecuencia [Hz]')
ax1 = subplot(212), plot(f,abs(fw(1:length(fw)/2)),f,abs(fy(1:length(y)/2))), grid
title('Espectro original y filtrado'), xlabel('Frecuencia [Hz]')
linkaxes([ax1 ax2]);

%% Audio Original
sound(x,fs),        % Prestar atención al crush y hi-hat

%% Audio Filtrado
sound(y, fs)        % No hay hi-hat, crush apenas suena
                    % Con pasa altos en 5k solo se escucha la voz y los
                    % platos









%% Short version
fc = 5e3;                       % Frecuencia de corte
wc = fc*2*pi;                   % Omega de corte

num = [1 0 0];                  % Pasa-Altos;  fc recomendada 5kHz
% num = (wc)^2;                   % Pasa-Bajos;  fc recomendada 1kHz
den = [1 sqrt(2)*wc wc^2];      % Denominador de un butterworth 2do orden
[numz, denz] = bilinear(num,den,fs);            % Transformada bilineal
y = filter(numz,denz,x);                  % Audio filtrado con filtro digital
sound(y, fs)        
