clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comandos


numeradorG = [1 16]; %declarando o numerador da função de transferência G(s)
denominadorG = [1 17 92 160]; %declarando o denominador da função de transferência G(s)
G = tf(numeradorG,denominadorG); %declarando a função de transferência G(s)
step(G,'k'); %gera função degrau

polos = pole(G); %pólos de G (s)
zeros = zero(G); %Zeros de G (s)

[r,p,k] = residue (numeradorG,denominadorG); %expande a função G(s) em frações parciais

syms s 
degrau = tf(1,[1 0]); %declara a função degrau em s
F = tf2sym(G*degrau); %multiplica função de transferência e a função degrau em s e converte para simbólico

degrau = tf2sym(degrau); % converte a função degrau para simbólico
F_comExpansao = (r(1)/(s+p(1))) + (r(2)/(s+p(2))) + (r(3)/(s+p(3)))*degrau;

%calcula a inversa c(t) da função de transfência F(s) expandidade em frações parciais no modo simbólico
c_comExpansao = ilaplace(F_comExpansao); %calcula a transformada inversa de laplace com usando F expandido em frações parciais
%calcula a inversa c(t) da função de transfência F(s) no modo simbólico
c = ilaplace(F);

figure
fplot(c)
title ('C(t)');
figure
fplot(c_comExpansao)
title ('C(t) com frações parciais');




%Limite de (s*F(s)/s) valor final da resposta ao degrau 








