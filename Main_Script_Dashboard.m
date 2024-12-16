%% Main Script - Rvk Cardona

clear all
clc

% Load data 
dpqFilePath = 'D:\PSYC233_Final_Project\NHANES_Data\DPQ_L.XPT';
slqFilePath = 'D:\PSYC233_Final_Project\NHANES_Data\SLQ_L.XPT';

dpqData = xptread(dpqFilePath);
slqData = xptread(slqFilePath);

expectedNames = {'SEQN', 'SLQ300', 'SLQ310', 'SLD012', 'SLQ320', 'SLQ330', 'SLD013'};
slqData.Properties.VariableNames(1:numel(expectedNames)) = expectedNames;

expectedNames = {'SEQN', 'DPQ010', 'DPQ020', 'DPQ030', 'DPQ040', ...
                 'DPQ050', 'DPQ060', 'DPQ070', 'DPQ080', 'DPQ090', 'DPQ100'};
dpqData.Properties.VariableNames(1:numel(expectedNames)) = expectedNames;

dpqData.Properties.VariableNames{'DPQ020'} = 'FeelingDown';
dpqData.Properties.VariableNames{'DPQ050'} = 'AppetiteIssues';
slqData.Properties.VariableNames{'SLD012'} = 'SleepHrsNight';

% Display the updated column names
disp(slqData.Properties.VariableNames);
disp(dpqData.Properties.VariableNames);

% Create Dashboard
uifig = uifigure('Name', 'NHANES Analysis Dashboard', 'Position', [100, 100, 1200, 800]);
ax = uiaxes(uifig, 'Position', [300, 200, 700, 500]);

label = uilabel(uifig, ...
    'Text', 'Choose Mental Health Variable:', ...
    'Position', [50, 430, 200, 30], ... 
    'FontSize', 14, ...
    'HorizontalAlignment', 'left');

% Dropdown for mental health variable selection
mentalHealthDropdown = uidropdown(uifig, ...
    'Items', {'Feeling Down', 'Appetite Issues'}, ...  
    'Position', [50, 400, 200, 30], ...
    'ValueChangedFcn', @(src, event) updatePlot(dpqData, slqData, src.Value, 'mentalHealth', ax));

% Dropdown for sleep variable selection
sleepDropdown = uidropdown(uifig, ...
    'Items', {'Sleep Hours'}, ...  
    'Position', [50, 350, 200, 30], ...
    'ValueChangedFcn', @(src, event) updatePlot(dpqData, slqData, src.Value, 'sleep'));

% Plotting

title(ax, 'Select variables to analyze');
xlabel(ax, 'X-Axis');
ylabel(ax, 'Y-Axis');

updatePlot(dpqData, slqData, 'Feeling Down', 'mentalHealth', ax);  % Initial plot for mental health
