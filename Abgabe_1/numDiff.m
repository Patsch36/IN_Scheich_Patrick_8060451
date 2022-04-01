function y = numDiff(func,x, mode)

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