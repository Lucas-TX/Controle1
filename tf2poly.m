function [x,y] = tf2poly(x)
[num,den] = tfdata(x);
%se o denominador existir, faz a fra��o, caso contr�rio n�o
if  ~isempty(den)
    x = cell2mat(num);
    y = cell2mat(den);
else
    x = cell2mat(num);
    y = [];
end
end