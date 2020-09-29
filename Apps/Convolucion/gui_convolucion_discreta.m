function varargout = gui_convolucion_discreta(varargin)
% GUI_CONVOLUCION_DISCRETA MATLAB code for gui_convolucion_discreta.fig
%      GUI_CONVOLUCION_DISCRETA, by itself, creates a new GUI_CONVOLUCION_DISCRETA or raises the existing
%      singleton*.
%
%      H = GUI_CONVOLUCION_DISCRETA returns the handle to a new GUI_CONVOLUCION_DISCRETA or the handle to
%      the existing singleton*.
%
%      GUI_CONVOLUCION_DISCRETA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CONVOLUCION_DISCRETA.M with the given input arguments.
%
%      GUI_CONVOLUCION_DISCRETA('Property','Value',...) creates a new GUI_CONVOLUCION_DISCRETA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_convolucion_discreta_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_convolucion_discreta_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_convolucion_discreta

% Last Modified by GUIDE v2.5 26-Sep-2020 17:05:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_convolucion_discreta_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_convolucion_discreta_OutputFcn, ...
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


% --- Executes just before gui_convolucion_discreta is made visible.
function gui_convolucion_discreta_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_convolucion_discreta (see VARARGIN)

% Choose default command line output for gui_convolucion_discreta
handles.output = hObject;
handles.nmax = 8;
handles.nmin = -2;
handles.n = handles.nmin : handles.nmax;
handles.xn = escalon(handles.n);
handles.hn = 1/3*(delta(handles.n)+delta(handles.n-1)+delta(handles.n-2));
handles.no = handles.nmin;
handles.hn_conv = 1/3*(delta(handles.no-handles.n)+delta(handles.no-handles.n-1)+delta(handles.no-handles.n-2));

graficar_axes1(handles);
graficar(handles);

% Update handles structure
set(handles.text9,'String','x[n] = u[n]')
set(handles.text11,'String','h[n] = 1/3 * (d[n] + d[n-1] d[n-2])')
guidata(hObject, handles);

% UIWAIT makes gui_convolucion_discreta wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_convolucion_discreta_OutputFcn(hObject, eventdata, handles) 
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
xn_list = get(hObject,'String');
xn_opt = get(hObject,'Value');

if strcmp(xn_list(xn_opt),'Escalón')
    handles.xn = escalon(handles.n);
    set(handles.text9,'String','x[n] = u[n]')
elseif strcmp(xn_list(xn_opt),'Opción A')
    handles.xn = (-1).^handles.n .* (handles.n+1) .* escalon(handles.n);
    set(handles.text9,'String','x[n] = [1 -2 3 -4 5 -6]')
elseif strcmp(xn_list(xn_opt),'Rampa')
    handles.xn = rampa(handles.n)-rampa(handles.n-3);
    set(handles.text9,'String','x[n] = rho[n]-rho[n-3]')
else
    handles.xn = cos(pi/4*handles.n) .* escalon(handles.n);
    set(handles.text9,'String','x[n] = cos[pi/4 n] * u[n]')
end

set(handles.slider1,'Value',0);
handles.no = handles.nmin;
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
hn_list = get(hObject,'String');
hn_opt = get(hObject,'Value');

set(handles.slider1,'Value',0);
handles.no = handles.nmin;
set(handles.text8,'String',num2str(handles.no,'%d'));

if strcmp(hn_list(hn_opt),'Media móvil')
    handles.hn = 1/3*(delta(handles.n)+delta(handles.n-1)+delta(handles.n-2));
    handles.hn_conv =  1/3*(delta(handles.no-handles.n)+delta(handles.no-handles.n-1)+delta(handles.no-handles.n-2));
    set(handles.text11,'String','h[n] = 1/3 * ((d[n] + d[n-1] d[n-2]')
else
    handles.hn = (1/2).^handles.n .* escalon(handles.n);
    handles.hn_conv = (1/2).^(handles.no-handles.n) .* escalon(handles.no-handles.n);
    set(handles.text11,'String','h[n] = (1/2)^n * u[n]')
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
handles.no = floor(handles.nmin + val*(handles.nmax - handles.nmin));
set(handles.text8,'String',num2str(handles.no,'%d'));

if get(handles.popupmenu2,'Value')==1
    handles.hn_conv = 1/3*(delta(handles.no-handles.n)+delta(handles.no-handles.n-1)+delta(handles.no-handles.n-2));
elseif get(handles.popupmenu2,'Value')==2
    handles.hn_conv = (1/2).^(handles.no-handles.n) .* escalon(handles.no-handles.n);
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
stem(handles.n,handles.xn,'linewidth',2), grid on, hold on
stem(handles.n,handles.hn,'--r','linewidth',2), 
%axis([handles.nmin handles.nmax -2 2]),
xlim([handles.nmin handles.nmax])
title('x[n] y h[n]'); xlabel('Muestras (n)');
legend('x[n]','h[n]');
hold off

function graficar(handles)

axes(handles.axes2);
stem(handles.n,handles.xn,'linewidth',2), grid on, hold on
stem(handles.n,handles.hn_conv,'g--','linewidth',2),
%axis([handles.nmin handles.nmax -2 2]),
xlim([handles.nmin handles.nmax])
title('x[k] y h[n-k]'); xlabel('Muestras paramétricas [k]');
hold off

axes(handles.axes3);
aux = handles.xn.*handles.hn_conv;
stem(handles.n,aux,'m','linewidth',2);
title('x[k] \cdot h[n-k'); xlabel('Muestras paramétricas [k]');
%axis([handles.nmin handles.nmax -2 2]),
xlim([handles.nmin handles.nmax]), grid on

axes(handles.axes4);
c = conv(handles.xn,handles.hn);
taux = -1:handles.no;
index = length(taux);
% length(taux)
stem(taux,c(4:index+3),'k','linewidth',3), grid on 
title('y[n] = \Sigma x[k] \cdot h[n-k]'); xlabel('Muestras [n]');
%axis([handles.nmin handles.nmax -2 2]),
xlim([handles.nmin handles.nmax])
