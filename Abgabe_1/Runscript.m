
% Runscript for testinf Newton Algorithm using myPoly function and no derivate function

% myNewton('function', @myPoly, 'derivative', @dmyPoly, 'startValue', 4, ...
% 'maxIter', 100, 'feps', 10e-10, 'livePlot', 'on')

myNewton('function', @myPoly, 'startValue', 4, ...
    'maxIter', 100, 'feps', 1e-10, 'livePlot', 'on')
