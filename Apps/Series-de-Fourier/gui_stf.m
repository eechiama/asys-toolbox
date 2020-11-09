function varargout = gui_stf(varargin)
% GUI_STF MATLAB code for gui_stf.fig
%      GUI_STF, by itself, creates a new GUI_STF or raises the existing
%      singleton*.
%
%      H = GUI_STF returns the handle to a new GUI_STF or the handle to
%      the existing singleton*.
%
%      GUI_STF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_STF.M with the given input arguments.
%
%      GUI_STF('Property','Value',...) creates a new GUI_STF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_stf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_stf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_stf

% Last Modified by GUIDE v2.5 09-Nov-2020 13:24:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_stf_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_stf_OutputFcn, ...
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


% --- Executes just before gui_stf is made visible.
function gui_stf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_stf (see VARARGIN)

% Choose default command line output for gui_stf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
value = str2double(get(handles.edit_n,'String'));
set(handles.slider1,'Value',value/20);
handles.rb_a0 = get(handles.radiobutton_a0,'Value');
handles.rb_an = get(handles.radiobutton_an,'Value');
handles.rb_bn = get(handles.radiobutton_bn,'Value');

% handles.N = str2double(get(handles.edit_n,'String'));;
% handles.T0 = eval(get(handles.edit_T0,'String'));
% handles.a0 = 0;
% handles.an = 0;
% handles.bn = 0;
    
guidata(hObject, handles);


% UIWAIT makes gui_stf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_stf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_dt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dt as text
%        str2double(get(hObject,'String')) returns contents of edit_dt as a double


% --- Executes during object creation, after setting all properties.
function edit_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ti_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ti as text
%        str2double(get(hObject,'String')) returns contents of edit_ti as a double


% --- Executes during object creation, after setting all properties.
function edit_ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tf as text
%        str2double(get(hObject,'String')) returns contents of edit_tf as a double


% --- Executes during object creation, after setting all properties.
function edit_tf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
value = get(hObject,'Value')*20;
set(handles.edit_n,'String',num2str(value));
processing(handles);




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_n_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n as text
%        str2double(get(hObject,'String')) returns contents of edit_n as a double
value = str2double(get(hObject,'String'));
set(handles.slider1,'Value',value/20);


% --- Executes during object creation, after setting all properties.
function edit_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_func_Callback(hObject, eventdata, handles)
% hObject    handle to edit_func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_func as text
%        str2double(get(hObject,'String')) returns contents of edit_func as a double


% --- Executes during object creation, after setting all properties.
function edit_func_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T0 as text
%        str2double(get(hObject,'String')) returns contents of edit_T0 as a double


% --- Executes during object creation, after setting all properties.
function edit_T0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_run.
function button_run_Callback(hObject, eventdata, handles)
% hObject    handle to button_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
processing(handles);



function processing(handles)
    dt = eval(get(handles.edit_dt,'String'));
    ti = eval(get(handles.edit_ti,'String'));
    tf = eval(get(handles.edit_tf,'String'));
    t = ti:dt:tf;

    T0 = eval(get(handles.edit_T0,'String'));
    ti_p = eval(get(handles.edit_ti_p,'String'));
    t2 = ti_p:dt:ti_p+T0;

    x = eval(get(handles.edit_func,'String'));
    x_1p = eval(replace_t_to_t2(get(handles.edit_func,'String')));

    x_p = [];
    for i = 1:(tf-ti)/T0+1
        x_p = [x_p x_1p];
    end
    x_p = x_p(1:length(t));

    N = str2double(get(handles.edit_n,'String'));
    a0 = STF_a0(t2,x_1p);
    an = STF_an(N,t2,x_1p);
    bn = STF_bn(N,t2,x_1p);

    x_rec = a0/2;
    for n=1:N
        x_rec = x_rec + an(n)*cos(n*2*pi/T0*t) + bn(n)*sin(n*2*pi/T0*t);
    end
    
    axes(handles.axes_func);
    plot(t,x_p,'--b',t,x_rec,'r','linewidth',2), grid, axis tight;
    xlabel('Tiempo [s]'), ylabel('Amplitud'), legend('Analítica','Reconstrucción')


    
    plot_stf(handles, N, T0, a0, an, bn)
    


function b = replace_t_to_t2(a)
    count = 0;
    for i=1:length(a)
        if a(i) == 't'
            count = count + 1;
        end
    end

    for i=1:length(a)+count-1
        if a(i) == 't'
            aux = a(i+1:end);
            a(i+1)='2';
            a = [a(1:i+1) aux];
            i = i-1;
        end
    end
    b = a;


function plot_stf(handles, N, T0, a0, an, bn)
    axes(handles.axes_fourier);
    
    an = abs(an);
    bn = abs(bn);
    
    if handles.rb_a0 & handles.rb_an & handles.rb_bn
        stem([0:N]*1/T0, [a0 an],'linewidth',2); hold; grid;
        stem([0:N]*1/T0, [0 bn],'--','linewidth',2); hold off,axis tight;
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('An','Bn');
    elseif handles.rb_a0==1 & handles.rb_an==1 & handles.rb_bn==0
        stem([0:N]*1/T0, [a0 an],'linewidth',2); grid;
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('An');
    elseif handles.rb_a0==1 & handles.rb_an==0 & handles.rb_bn==0
        stem([0:N]*1/T0, [a0 zeros(1,N)],'linewidth',2); axis tight;, grid
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('A0');
    elseif handles.rb_a0==1 & handles.rb_an==0 & handles.rb_bn==1
        stem([0:N]*1/T0, [0 bn],'linewidth',2); axis tight; grid
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('A0','Bn');
    elseif handles.rb_a0==0 & handles.rb_an==1 & handles.rb_bn==1
        stem([0:N]*1/T0, [0 an],'linewidth',2); hold; grid;
        stem([0:N]*1/T0, [0 bn],'--','linewidth',2); hold off,axis tight;
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('An','Bn');
    elseif handles.rb_a0==0 & handles.rb_an==1 & handles.rb_bn==0
        stem([0:N]*1/T0, [0 an],'linewidth',2); grid;
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('An');
    elseif handles.rb_a0==0 & handles.rb_an==0 & handles.rb_bn==1
        stem([0:N]*1/T0, [0 bn],'linewidth',2); axis tight; grid
        xlabel('Frecuencia [Hz]'), ylabel('Amplitud'), legend('Bn');
    else
        stem([0:N]*1/T0, zeros(1,N+1)); grid
    end
        


function edit_ti_p_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ti_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ti_p as text
%        str2double(get(hObject,'String')) returns contents of edit_ti_p as a double


% --- Executes during object creation, after setting all properties.
function edit_ti_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ti_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_a0.
function radiobutton_a0_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_a0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_a0
handles.rb_a0 = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes on button press in radiobutton_an.
function radiobutton_an_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_an (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_an
handles.rb_an = get(hObject,'Value');
guidata(hObject, handles);



% --- Executes on button press in radiobutton_bn.
function radiobutton_bn_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_bn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_bn
handles.rb_bn = get(hObject,'Value');
guidata(hObject, handles);
