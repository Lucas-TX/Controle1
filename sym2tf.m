function y = sym2tf(x)
syms s
[num,den] = numden(x);
%se o denominador existir, faz a fra��o, caso contr�rio n�o
if  ~isempty(den)
    y = tf(sym2poly(num),sym2poly(den));
else
    y = tf(sym2poly(num));
end
end