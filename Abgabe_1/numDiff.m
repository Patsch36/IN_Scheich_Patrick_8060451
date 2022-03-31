function y = numDiff(func,x)
    y = (func(x + 1e-10) -func(x)) / 1e-10;
end