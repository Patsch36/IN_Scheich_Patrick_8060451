function [xZero, abortFlag, iters] = myNewton(varargin)
% myNewton - Calculates zeros of any function
%
% Syntax:  [xZero, abortFlag, iters] = myNewton('function', @myPoly, 'startValue', 4, ...
%    'maxIter', 100, 'feps', 1e-10, 'livePlot', 'on')
%
% Inputs:
%    function - function of which zeroes should be calculated (Matlab function)
%    derivative - derivation of function (Matlab function)                              Not necessary
%    startValue - iteration start value for function (integer value)                    Not necessary
%    maxIter - max amount of iteration (Break criteria for algorithm) (integer value)   Not necessary
%    feps - difference between last two calculation (break criteria) (integer value)    Not necessary
%    xeps - difference between last two zeroes (break criteria)  (integer value)        Not necessary
%    livePlot - live plotting of values ('on', 'off')                                Not necessary
%
% Outputs:
%    xZero - zero-point
%    abortFlag - break criteria
%    iters - needed iterations
%
% Example: 
%    myNewton('function', @myPoly, 'startValue', 4, 'maxIter', 100, 'feps', 1e-10, 'livePlot', 'on')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: Patrick Scheich- dual student Information Technology
% email address: inf20126@lehre.dhbw-stuttgart.de
% March 2022; Last revision: 1-April-2022

%------------- BEGIN CODE --------------
    %% do the varargin
    for i = 1:nargin
        if strcmp(varargin{i},'function')
            func = varargin{i+1};
        elseif strcmp(varargin{i},'derivative')
            derivateFlag = 0;
            dfunc = varargin{i+1};
        elseif strcmp(varargin{i},'startValue')
            x0 = varargin{i+1};
        elseif strcmp(varargin{i},'maxIter')
            maxIter = varargin{i+1};
        elseif strcmp(varargin{i},'feps')
            feps = varargin{i+1};
        elseif strcmp(varargin{i},'xeps')
            xeps = varargin{i+1};
        elseif strcmp(varargin{i},'livePlot')
            livePlot = varargin{i+1};   
        end
    end
    
    %% check for necessary parameters
    if ~exist('func','var')
        error('No valid function');
    end

    if ~exist('derivative','var')
        dfunc = @numDiff;
        derivateFlag = 1;

        % Question dialog with central differentation as default options
        differentationMethod = questdlg('Which Method schould be used for differentation?', ...
            'Choose your differentation-method of your choice', ...
            'Forward Differentation', 'Backward- Differentation', 'Central- Differentation', 'Central- Differentation');
        disp(['Using ', differentationMethod, ' for getting a derivate Function']);

        % Convert long answers from question- dialog to parameter for diff- Method
        if strcmp(differentationMethod, 'Forward Differentation')
            differentationMethod = 'forward';
        elseif strcmp(differentationMethod, 'Backward- Differentation')
            differentationMethod = 'backwards';
        else
            differentationMethod = 'central';
        end


        disp('No dervative function given. Using integrated algorithme for derivating value.')
    end
        
    if ~exist('x0','var')
        x0 = 0;
        disp(['Using default startvalue: x0 = ',num2str(x0)]);
    end
    
    if ~exist('maxIter','var')
        maxIter = 50;
        disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
    end
    
    if ~exist('feps','var')
        feps = 1e-6;
        disp(['Using default Feps: feps = ',num2str(feps)]);
    end
    
    if ~exist('xeps','var')
        xeps = 1e-6;
        disp(['Using default Xeps: xeps = ',num2str(xeps)]);
    end
    
    if ~exist('livePlot','var')
        livePlot = 'off';
        disp(['Using default live Plot: livePlot = ','off']);
    end
    
    %% start of algorithm
    if strcmp(livePlot,'on')
       h = figure('Name','Newton visualization');
       ax1 = subplot(2,1,1);
       plot(ax1,0,x0,'bo');
       ylabel('xValue');
       hold on;
       grid on;
       xlim('auto')
       ylim('auto')
       ax2 = subplot(2,1,2);
       semilogy(ax2,0,func(x0),'rx');
       xlabel('Number of iterations')
       ylabel('Function value');
       hold on;
       grid on;
       xlim('auto')
       ylim('auto')
    end
    xOld = x0;
    abortFlag = 'maxIter';
    
    
    for i = 1:maxIter

        f = func(xOld);

        if f < feps
            abortFlag = 'feps';
            break;
        end

        df = 0;
        if derivateFlag == 1
            df = dfunc(func, xOld, differentationMethod);
        else
            df = dfunc(xOld);
        end

        if df == 0
            abortFlag = 'df = 0';
            break;
        end

        xNew = xOld - f/df; 
        if abs(xNew-xOld) < xeps
            abortFlag = 'xeps';
            break;
        end

        xOld = xNew;
        if strcmp(livePlot,'on')
           plot(ax1,i,xNew,'bo');
           semilogy(ax2,i,func(xNew),'rx');
           pause(0.05);
        end

    end
    
    
    iters = i;
    xZero = xNew;
end

%------------- END OF CODE --------------
