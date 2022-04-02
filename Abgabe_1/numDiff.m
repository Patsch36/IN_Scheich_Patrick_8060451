function y = numDiff(func,x, mode)
% numDiff - differentiates a function after numerical principal
%
% Syntax:  y = numDiff(func,x, mode)
%
% Inputs:
%    func - function of which zeroes should be calculated (Matlab function)
%    x - x-value for getting y value from derivate (Integer value)
%    mode - differentiation mode ('forward', 'backwards', 'central')
%
% Outputs:
%    y = y Value from derivate of given x- value
%
% Example: 
%    numDiff(myPoly, 0, 'central')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: Patrick Scheich- dual student Information Technology
% email address: inf20126@lehre.dhbw-stuttgart.de
% March 2022; Last revision: 1-April-2022

%------------- BEGIN CODE --------------
    % Forward Differentation
    if strcmp(mode, 'forward')
        y = (func(x + 1e-10) -func(x)) / 1e-10;
    % Backward Differentation
    elseif strcmp(mode, 'backwards')
        y = (func(x) -func(x + 1e-10)) / 1e-10;
    % Central Differentation
    elseif strcmp(mode, 'central')
        y = (func(x + 1e-10) -func(x - 1e-10)) /( 2 * (1e-10));
    else
        error('No valid differentation method selected')
    end
end

%------------- END OF CODE --------------
