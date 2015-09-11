function varargout = gui_mainform(varargin)
% GUI_MAINFORM M-file for gui_mainform.fig
%      GUI_MAINFORM, by itself, creates a new GUI_MAINFORM or raises the existing
%      singleton*.
%
%      H = GUI_MAINFORM returns the handle to a new GUI_MAINFORM or the handle to
%      the existing singleton*.
%
%      GUI_MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAINFORM.M with the given input arguments.
%
%      GUI_MAINFORM('Property','Value',...) creates a new GUI_MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_mainform_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_mainform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_mainform

% Last Modified by GUIDE v2.5 22-Jul-2008 08:21:43

%--- Fitria Nur Andini 5104100155

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_mainform_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_mainform_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_mainform is made visible.
function gui_mainform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_mainform (see VARARGIN)

% Choose default command line output for gui_mainform
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

set(hObject, 'Name', 'Rekonstruksi Permukaan 3D dengan Neural Network Berbasis Photometric Stereo'); 

% start code
if nargin < 4
    dname = [pwd, '\database\synthetic\sphere1'];
    files = dir(fullfile(dname, '*.pgm'));
    im1 = imread([dname,'\',files(1).name]);  
    im2 = imread([dname,'\',files(2).name]);
    im3 = imread([dname,'\',files(3).name]);
%     sp = [1 5 3];
%     [im1, im2, im3] = create_sphere(sp(1), sp(2), sp(3));
    % result filename
    fname_res = ['sphere1'];
    handles.im1 = im1;
    handles.im2 = im2;
    handles.im3 = im3;
    handles.fname_res = fname_res;
    guidata(hObject,handles);
    
    axes(handles.axes_img1);imshow(im1);title('Cahaya Kiri');
    axes(handles.axes_img2);imshow(im2);title('Cahaya Depan');
    axes(handles.axes_img3);imshow(im3);title('Cahaya Kanan');
    
    %show Ground Truth Button
    set(handles.pushbutton_gt, 'Visible', 'on');
    % set method to 'avg'
    set(handles.radiobutton_avg, 'Value', 1);
    handles.method = 'avg';
    guidata(hObject,handles);
else
    errordlg('File Not Found','File Load Error')
end

% UIWAIT makes gui_mainform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_mainform_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Face_Callback(hObject, eventdata, handles)
% hObject    handle to Face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

curr_dir = pwd;
% Show Open Directory Dialog
dname = uigetdir([curr_dir, '\database\face\face1'], 'Browse Directory Citra Wajah');
if isequal(dname,0)
    return
end
% get all pgm files in the selected directory
files = dir(fullfile(dname, '*.pgm'));

if isempty(files)
    errordlg('File Not Found','File Load Error');
else
    % load eyes coordinate from eyes.mat
    load ([dname,'\','eyes.mat']);
   
    % read the pgm images and display them on the axes
    im1 = cropimg([dname,'\',files(1).name], left(:,:,1), right(:,:,1));
    im2 = cropimg([dname,'\',files(2).name], left(:,:,2), right(:,:,2));
    im3 = cropimg([dname,'\',files(3).name], left(:,:,3), right(:,:,3));
    % get face directory 
    fname_res = strrep(dname, [pwd, '\database\face\'], '');
    % add handles for matrix images
    handles.im1 = im1;
    handles.im2 = im2;
    handles.im3 = im3;
    handles.fname_res = fname_res;
    guidata(hObject,handles);
    
    axes(handles.axes_img1); imshow(im1);title('Cahaya Kiri');
    axes(handles.axes_img2); imshow(im2);title('Cahaya Depan');    
    axes(handles.axes_img3); imshow(im3);title('Cahaya Kanan');
    %clear axes result
    axes(handles.axes_albedo);imshow([]);
    axes(handles.axes_normal1);imshow([]);
    axes(handles.axes_normal2);imshow([]);
    axes(handles.axes_normal3);imshow([]);
    % hide Ground Truth Button
    set(handles.pushbutton_gt, 'Visible', 'off');
    set(handles.edit_NE, 'Visible', 'off');
    set(handles.text_Error, 'Visible', 'off');
    % clear elapsed time textBox
    set(handles.edit_ElapsedTime, 'String', '');
end

% --------------------------------------------------------------------
function Sphere_Callback(hObject, eventdata, handles)
% hObject    handle to Sphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Show Open Directory Dialog Box
dname = uigetdir([pwd, '\database\synthetic\sphere1'], 'Browse Directory Citra Sintetis');
if isequal(dname,0)
    return
end
% get all pgm files in the selected directory
files = dir(fullfile(dname, '*.pgm'));
if isempty(files)
    errordlg('File Not Found','File Load Error');
else
    im1 = imread([dname,'\',files(1).name]);  
    im2 = imread([dname,'\',files(2).name]);
    im3 = imread([dname,'\',files(3).name]);
    % get face directory 
    fname_res = strrep(dname, [pwd, '\database\synthetic\'], '');
    % set handles for images data
    handles.im1 = im1;
    handles.im2 = im2;
    handles.im3 = im3;
    handles.fname_res = fname_res;
    guidata(hObject,handles);
    % Show sphere into axes 
    axes(handles.axes_img1);imshow(im1);title('Cahaya Kiri');
    axes(handles.axes_img2);imshow(im2);title('Cahaya Depan');
    axes(handles.axes_img3);imshow(im3);title('Cahaya Kanan');
    %clear axes result
    axes(handles.axes_albedo);imshow([]);
    axes(handles.axes_normal1);imshow([]);
    axes(handles.axes_normal2);imshow([]);
    axes(handles.axes_normal3);imshow([]);
    % show Ground Truth Button
    set(handles.pushbutton_gt, 'Visible', 'on');
    % clear elapsed time textBox
    set(handles.edit_ElapsedTime, 'String', '');
    % hide error text box
    set(handles.edit_NE, 'Visible', 'off');
    set(handles.text_Error, 'Visible', 'off');
end
%---------------------------------------

% %---------SHOW gui_sphere
% sp = gui_sphere('Title', 'Synthetic Sphere');
% if ~isequal(sp, [0 0 0])
%     [im1, im2, im3] = create_sphere(sp(1), sp(2), sp(3));    
%     % result filename
%     fname_res = ['sphere',num2str(sp(1)), num2str(sp(2)), num2str(sp(3))];
%     % set handles for images data
%     handles.im1 = im1;
%     handles.im2 = im2;
%     handles.im3 = im3;
%     handles.fname_res = fname_res;
%     guidata(hObject,handles);
%     % Show sphere into axes 
%     axes(handles.axes_img1);imshow(im1);title('Cahaya Kiri');
%     axes(handles.axes_img2);imshow(im2);title('Cahaya Depan');
%     axes(handles.axes_img3);imshow(im3);title('Cahaya Kanan');
% end
% %-----------------------

% --- Executes during object creation, after setting all properties.
function lr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function lr_Callback(hObject, eventdata, handles)
% hObject    handle to lr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lr as text
%        str2double(get(hObject,'String')) returns contents of lr as a double


% --- Executes during object creation, after setting all properties.
function maxIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function maxIter_Callback(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIter as text
%        str2double(get(hObject,'String')) returns contents of maxIter as a double


% --- Executes during object creation, after setting all properties.
function minError_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function minError_Callback(hObject, eventdata, handles)
% hObject    handle to minError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minError as text
%        str2double(get(hObject,'String')) returns contents of minError as a double


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lr, 'String', '');
set(handles.maxIter, 'String', '');
set(handles.minError, 'String', '');
set(handles.edit_ElapsedTime, 'String', '');
axes(handles.axes_img1);imshow([]);
axes(handles.axes_img2);imshow([]);
axes(handles.axes_img3);imshow([]);
axes(handles.axes_albedo);imshow([]);
axes(handles.axes_normal1);imshow([]);
axes(handles.axes_normal2);imshow([]);
axes(handles.axes_normal3);imshow([]);


% --- Executes on button press in pushbutton_runNN.
function pushbutton_runNN_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_runNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lr = str2num(get(handles.lr, 'String'));
maxIter = str2num(get(handles.maxIter, 'String'));
minError = str2num(get(handles.minError,'String'));
% if isempty(lr) | isempty(maxIter) | isempty(minError)
%     errordlg('isi Parameter Neural Network');
%     return;
% end;

width = size(handles.im1,2);
height = size(handles.im1,1);

% get images from handles
im1 = handles.im1;
im2 = handles.im2;
im3 = handles.im3;

% reshape images into M x 1
I1 = reshape(handles.im1, height * width, 1);
I2 = reshape(handles.im2, height * width, 1);
I3 = reshape(handles.im3, height * width, 1);
tic,
% Execute NN
[N, A, p1, p2, p3] = symnn(I1, I2, I3, lr, maxIter, minError, handles.method);
% Reconstruct
z = recon3D(N); 
t = toc;
set(handles.edit_ElapsedTime, 'String', num2str(t));

handles.z = z;
handles.A = double(reshape(mean([I1 I2 I3]'), height, width));
guidata(hObject,handles);

set(handles.pushbutton_3DsurfaceAlbedo, 'Enable', 'on');
set(handles.pushbutton_3Dsurface, 'Enable', 'on');

% reshape image results into their original matrix form
albedo = reshape(A, height, width);
nx = reshape(N(1,:), height, width);
ny = reshape(N(2,:), height, width);
nz = reshape(N(3,:), height, width);

% Draw Result into axes
axes(handles.axes_albedo);imshow(albedo, []);title('Albedo');
axes(handles.axes_normal1);imshow(nx, []);title('surface normal 1');
axes(handles.axes_normal2);imshow(ny, []);title('surface normal 2');
axes(handles.axes_normal3);imshow(nz, []);title('surface normal 3');

% show reconstructed surface
fHandle = figure('HandleVisibility','off','IntegerHandle','off','Visible','off');
aHandle = axes('Parent',fHandle);
pHandles = surf(z,'Parent',aHandle);
set(fHandle,'Visible','on', 'Name', 'Rekonstruksi Permukaan 3D', 'NumberTitle', 'off');


% save result to file in the result directory
fname = [pwd, '\result\', handles.fname_res, '_', handles.method];
save(fname, 't', 'z', 'N', 'A', 'im1', 'im2', 'im3', 'p1', 'p2', 'p3');
clear ('t', 'z', 'N', 'A', 'im1', 'im2', 'im3', 'p1', 'p2', 'p3');

% --- Executes during object creation, after setting all properties.
function edit_ElapsedTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ElapsedTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_ElapsedTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ElapsedTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ElapsedTime as text
%        str2double(get(hObject,'String')) returns contents of edit_ElapsedTime as a double


% --- Executes on button press in pushbutton_3Dsurface.
function pushbutton_3Dsurface_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_3Dsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% show reconstructed surface
fHandle = figure('HandleVisibility','off','IntegerHandle','off','Visible','off');
aHandle = axes('Parent',fHandle);
pHandles = surf(handles.z,'Parent',aHandle);
set(fHandle,'Visible','on', 'Name', 'Rekonstruksi Permukaan 3D', 'NumberTitle', 'off');


% --- Executes on button press in pushbutton_3DsurfaceAlbedo.
function pushbutton_3DsurfaceAlbedo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_3DsurfaceAlbedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[X,Y] = meshgrid([1:1:size(handles.z,1)]);

% show reconstructed surface
fHandle = figure('HandleVisibility','off','IntegerHandle','off','Visible','off', 'colormap', colormap(gray));
aHandle = axes('Parent',fHandle);
pHandles = surf(X, Y, handles.z, handles.A, 'Parent',aHandle, 'lineStyle', 'none'); 
set(fHandle,'Visible','on', 'Name', 'Rekonstruksi Permukaan 3D', 'NumberTitle', 'off');



% --- Executes on button press in pushbutton_gt.
function pushbutton_gt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_gt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
width = size(handles.im1,2);
height = size(handles.im1,1);
k = findstr('sphere', handles.fname_res);
C = 51;
stat = 0;
if ~isempty(k)
    rad = 48;
    [X, Y, Z] = depth_map_sphere(width, height, C, rad);
    stat = 1;
    clear ('X', 'Y');
else
    k = findstr('sombrero', handles.fname_res);
    if ~isempty(k)
        [X, Y, Z] = depth_map_sombrero(width, height, C);
        stat = 1;
        clear ('X', 'Y');
    end
end
e = calc_error(handles.z, Z);
set(handles.text_Error, 'Visible', 'on');
set(handles.edit_NE, 'Visible', 'on', 'String', num2str(e));
% show Ground Truth
fHandle = figure('HandleVisibility','off','IntegerHandle','off','Visible','off');
aHandle = axes('Parent',fHandle);
pHandles = surf(Z,'Parent',aHandle);
set(fHandle,'Visible','on', 'Name', 'Ground Truth Objek Sintetis', 'NumberTitle', 'off');


% --- Executes on button press in radiobutton_PCA.
function radiobutton_PCA_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_PCA
off = [handles.radiobutton_sum, handles.radiobutton_avg];
mutual_exclude(off);

if(get(hObject,'Value') == get(hObject,'Max'))
    handles.method = 'pca';
    guidata(hObject,handles);
end

% --- Executes on button press in radiobutton_sum.
function radiobutton_sum_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_sum
off = [handles.radiobutton_PCA, handles.radiobutton_avg];
mutual_exclude(off);

if(get(hObject,'Value') == get(hObject,'Max'))
    handles.method = 'sum';
    guidata(hObject,handles);
end
% --- Executes on button press in radiobutton_avg.
function radiobutton_avg_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_avg
off = [handles.radiobutton_PCA, handles.radiobutton_sum];
mutual_exclude(off);

if(get(hObject,'Value') == get(hObject,'Max'))
    handles.method = 'avg';
    guidata(hObject,handles);
end
function mutual_exclude(off)
set(off, 'Value', 0);


% --- Executes during object creation, after setting all properties.
function edit_NE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_NE_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NE as text
%        str2double(get(hObject,'String')) returns contents of edit_NE as a double


