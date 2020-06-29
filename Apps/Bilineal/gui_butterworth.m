function varargout = gui_butterworth(varargin)
% GUI_BUTTERWORTH MATLAB code for gui_butterworth.fig
%      GUI_BUTTERWORTH, by itself, creates a new GUI_BUTTERWORTH or raises the existing
%      singleton*.
%
%      H = GUI_BUTTERWORTH returns the handle to a new GUI_BUTTERWORTH or the handle to
%      the existing singleton*.
%
%      GUI_BUTTERWORTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BUTTERWORTH.M with the given input arguments.
%
%      GUI_BUTTERWORTH('Property','Value',...) creates a new GUI_BUTTERWORTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_butterworth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_butterworth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_butterworth

% Last Modified by GUIDE v2.5 29-Jun-2020 19:07:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_butterworth_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_butterworth_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_butterworth is made visible.
function gui_butterworth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_butterworth (see VARARGIN)

% Choose default command line output for gui_butterworth

handles.output = hObject;
save_name = 'turn.mp3';             % Turn the page - Metallica
[x, fs] = audioread(save_name);     % Carga el audio: x es el audio, fs la frecuencia de muestreo
handles.x = x;
handles.fs = fs;
handles.fc = 1000;
handles.wc = 2*pi*handles.fc;
handles.num = handles.wc^2;
handles.den = [1 sqrt(2)*handles.wc (handles.wc)^2];

handles.xw = fft(x)/length(x);
handles.N = floor(length(handles.xw)/2);            
N = handles.N;
handles.f = (0:N-1)*fs/2/N;              

axes(handles.axes1);
plot(handles.f, abs(handles.xw(1:handles.N))), grid on;
xlim([0 fs/2]); title('FFT'), xlabel('Frecuencia [kHz]');
ax1 = gca;
ax1.XTick = [0 2500 5000 7500 10000 12500 15000 17500 20000]
ax1.XTickLabel = [0 2.5 5 7.5 10 12.5 15 17.5 20]

[HHs, ws] = freqs(handles.wc^2, handles.den);                   % Rta en frecuencia del filtro analógico
[numz,denz] = bilinear(handles.wc^2, handles.den, fs);
[HHz, wz] = freqz(numz,denz);                 % Rta en frecuencia del filtro digital

axes(handles.axes3);
plot(ws/2/pi, abs(HHs), '--b', wz*fs/2/pi, abs(HHz),'r','linewidth',2),  grid
legend('Filtro analógico','Filtro digital'), xlabel('Frecuencia [Hz]')
xlabel('Frecuencia [kHz]'); xlim([0 fs/2]); ylim([0 1])
title('Rta en frecuencia del Filtro')
ax2 = gca;
ax2.XTick = [0 2500 5000 7500 10000 12500 15000 17500 20000]
ax2.XTickLabel = [0 2.5 5 7.5 10 12.5 15 17.5 20]
ax2.YTick = [0 0.25 0.5 0.707 1]




% Update handles structure
guidata(hObject, handles);
set(handles.fs_disp,'string',num2str(fs))

% UIWAIT makes gui_butterworth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_butterworth_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;
sound(handles.x, handles.fs)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[numz, denz] = bilinear(handles.num,handles.den,handles.fs);          
y = filter(numz,denz,handles.x);        
yw = fft(y)/length(y);

clear sound;
sound(y, handles.fs)      
axes(handles.axes1);
plot(handles.f, abs(handles.xw(1:handles.N))), hold on
plot(handles.f, abs(yw(1:handles.N)),'r')
grid on;
legend('Espectro original','Espectro filtrado')
xlabel('Frecuencia [kHz]'); xlim([0 handles.fs/2])
ax = gca;
ax.XTick = [0 2500 5000 7500 10000 12500 15000 17500 20000]
ax.XTickLabel = [0 2.5 5 7.5 10 12.5 15 17.5 20]
hold off;

[HHs, ws] = freqs(handles.num, handles.den);                
[HHz, wz] = freqz(numz,denz);                 
fs = handles.fs;

axes(handles.axes3);
plot(ws/2/pi, abs(HHs), '--b', wz*fs/2/pi, abs(HHz),'r','linewidth',2),  grid
legend('Filtro analógico','Filtro digital'), xlabel('Frecuencia [Hz]')
xlabel('Frecuencia [kHz]'); xlim([0 fs/2]); ylim([0 1])
title('Rta en frecuencia del Filtro')
ax2 = gca;
ax2.XTick = [0 2500 5000 7500 10000 12500 15000 17500 20000]
ax2.XTickLabel = [0 2.5 5 7.5 10 12.5 15 17.5 20]
ax2.YTick = [0 0.25 0.5 0.707 1]


function frec_c_Callback(hObject, eventdata, handles)
% hObject    handle to frec_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec_c as text
%        str2double(get(hObject,'String')) returns contents of frec_c as a double
handles.fc = str2double(get(hObject,'String'));
handles.wc = handles.fc * 2 * pi;
handles.den = [1 sqrt(2)*handles.wc (handles.wc)^2]
if handles.HPF.Value == 1
    handles.num = [1 0 0];
    disp('hpf')
else
    handles.num = [handles.wc^2];
    disp('lpf')
end
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function frec_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if hObject == handles.LPF
    handles.num = [handles.wc^2];
else
    handles.num = [1 0 0];
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fs_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object deletion, before destroying properties.
function fs_disp_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fs_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;
