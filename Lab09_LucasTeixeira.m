%Estratégia:

clear all; %apaga todas as variáveis
close all; %fecha todas as figuras
clc; %Limpa a janela de comandos

%Dados Hardcoded
numG = [10^7 5*10^7];
denG = [1 620 62000 10^6];

%Declara função G
G = tf(numG,denG);
bode(G);
%Caso seja necessário definir o espaço em que deseja-se plotar o gráfico
%w = logspace (-1,4,1e4);
%[mag,phase] = bode()
%margin (phase)
