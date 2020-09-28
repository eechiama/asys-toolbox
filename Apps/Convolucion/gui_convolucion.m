function varargout = gui_convolucion(varargin)
% GUI_CONVOLUCION MATLAB code for gui_convolucion.fig
%      GUI_CONVOLUCION, by itself, creates a new GUI_CONVOLUCION or raises the existing
%      singleton*.
%
%      H = GUI_CONVOLUCION returns the handle to a new GUI_CONVOLUCION or the handle to
%      the existing singleton*.
%
%      GUI_CONVOLUCION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CONVOLUCION.M with the given input arguments.
%
%      GUI_CONVOLUCION('Property','Value',...) creates a new GUI_CONVOLUCION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_convolucion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_convolucion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_convolucion

% Last Modified by GUIDE v2.5 25-Sep-2020 21:38:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_convolucion_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_convolucion_OutputFcn, ...
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


% --- Executes just before gui_convolucion is made visible.
function gui_convolucion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_convolucion (see VARARGIN)

% Choose default command line output for gui_convolucion
handles.output = hObject;
handles.dt = 0.01;
handles.tmax = 3;
handles.tmin = -1;
handles.t = handles.tmin : handles.dt : handles.tmax;
handles.xt = escalon(handles.t);
handles.ht = exp(-2*handles.t).*escalon(handles.t);
handles.to = handles.tmin;
handles.ht_conv = escalon(handles.to-handles.t);

graficar_axes1(handles);
graficar(handles);

% Update handles structure
set(handles.text9,'String','x(t) = u(t)')
set(handles.text11,'String','h(t) = e^(-2t) * u(t)')
guidata(hObject, handles);

% UIWAIT makes gui_convolucion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_convolucion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
xt_list = get(hObject,'String');
xt_opt = get(hObject,'Value');

if strcmp(xt_list(xt_opt),'Escalón')
    handles.xt = escalon(handles.t);
    set(handles.text9,'String','x(t) = u(t)')
elseif strcmp(xt_list(xt_opt),'Rampa')
    handles.xt = rampa(handles.t)-rampa(handles.t-1);
    set(handles.text9,'String','x(t) = rho(t) - rho(t-1)')
else
    handles.xt = exp(-handles.t).*escalon(handles.t);
    set(handles.text9,'String','x(t) = e^(-t) * u(t)')
end

set(handles.slider1,'Value',0);
handles.to = handles.tmin;
guidata(hObject, handles);
graficar_axes1(handles);
graficar(handles)



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
ht_list = get(hObject,'String');
ht_opt = get(hObject,'Value');

set(handles.slider1,'Value',0);
handles.to = handles.tmin;
set(handles.text8,'String',num2str(handles.to,'%.2f'));

if strcmp(ht_list(ht_opt),'Primer orden')
    handles.ht = exp(-2*handles.t).*escalon(handles.t);
    handles.ht_conv = exp(-2*(handles.to-handles.t)).*escalon(handles.to-handles.t);
    set(handles.text11,'String','h(t) = e^(-2t) * u(t)')
elseif strcmp(ht_list(ht_opt),'Segundo orden sobreamortiguado')
    handles.ht = 4*(-exp(-4*handles.t) + exp(-2*handles.t)).*escalon(handles.t);
    handles.ht_conv = 4*(-exp(-4*(handles.to-handles.t)) + exp(-2*(handles.to-handles.t))).*escalon((handles.to-handles.t));
    set(handles.text11,'String','h(t) = 4 * [e^(-2t) - e^(-4t)] * u(t)')
elseif strcmp(ht_list(ht_opt),'Segundo orden crítico')
    handles.ht = 9*exp(-3*handles.t) .* handles.t .*escalon(handles.t);
    handles.ht_conv = 9*exp(-3*(handles.to-handles.t)) .* (handles.to-handles.t) .* escalon((handles.to-handles.t));
    set(handles.text11,'String','h(t) = 9 * t * e^(-3t) * u(t)')
else
    handles.ht = 9*exp(-3*handles.t) .* sin(3*handles.t).* handles.t .*escalon(handles.t);
    handles.ht_conv = 9*exp(-3*(handles.to-handles.t)) .* sin(3*(handles.to-handles.t)) .* escalon(handles.to-handles.t);
    set(handles.text11,'String','h(t) = 9 * e^(-3t) * sin(3t) * escalon(t)')
end

guidata(hObject, handles);
graficar_axes1(handles);
graficar(handles)

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'Value');
handles.to = handles.tmin + val*(handles.tmax - handles.tmin);
set(handles.text8,'String',num2str(handles.to,'%.2f'));

if get(handles.popupmenu2,'Value')==1
    handles.ht_conv = exp(-2*(handles.to-handles.t)).*escalon(handles.to-handles.t);
elseif get(handles.popupmenu2,'Value')==2
    handles.ht_conv = 4*(-exp(-4*(handles.to-handles.t)) + exp(-2*(handles.to-handles.t))).*escalon((handles.to-handles.t));
elseif get(handles.popupmenu2,'Value')==3
    handles.ht_conv = 9*exp(-3*(handles.to-handles.t)) .* (handles.to-handles.t) .* escalon((handles.to-handles.t));
else
    handles.ht_conv = 9*exp(-3*(handles.to-handles.t)) .* sin(3*(handles.to-handles.t)) .* (handles.to-handles.t) .* escalon((handles.to-handles.t));
end
graficar(handles)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function graficar_axes1(handles)
axes(handles.axes1);
plot(handles.t,handles.xt,'linewidth',2), grid on, hold on
plot(handles.t,handles.ht,'--r','linewidth',2), 
axis([handles.tmin handles.tmax -0.5 1.5]),
title('x(t) y h(t)'); xlabel('Tiempo (t)');
legend('x(t)','h(t');
hold off

function graficar(handles)

axes(handles.axes2);
plot(handles.t,handles.xt,'linewidth',2), grid on, hold on
axis([handles.tmin handles.tmax -0.5 1.5]),
plot(handles.t,handles.ht_conv,'--g','linewidth',2), 
title('x(\tau) y h(t-\tau)'); xlabel('Tiempo paramétrico (\tau)');
hold off

axes(handles.axes3);
aux = handles.xt.*handles.ht_conv;
plot(handles.t,aux,'m','linewidth',2);
title('x(\tau) \cdot h(t-\tau)'); xlabel('Tiempo paramétrico (\tau)');
axis([handles.tmin handles.tmax -0.5 1.5]); grid on

axes(handles.axes4);
c = conv(handles.xt,handles.ht)*handles.dt;
taux = -1:handles.dt:handles.to;
index = length(taux);
% length(taux)
plot(taux,c(101:index+100),'k','linewidth',3), grid on 
title('\int x(\tau)\cdot h(t-\tau) d\tau'); xlabel('Tiempo (t)');
axis([handles.tmin handles.tmax -0.5 1.5]),
