function y = tf2sym(x)
syms s
[num,den] = tfdata(x);
%se o denominador existir, faz a fração, caso contrário não
if  ~isempty(den)
    y = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s);
else
    y = poly2sym(cell2mat(num),s);
end
end