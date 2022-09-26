%Estratégia - Prob1: 520
%Verifica estabilidade
%Calcular constantes de erro: Kp,Kv,Ka
%Para cada entrada, obter erros esperados
%Usar lsim para plotar resposta a cada um dos sistemas

%Estratégia-Prob2
%Verificar Estabilidade

clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comando

%Declara e plota o degrau:
degrau = ones(1,1000);
figure
subplot (2,2,1);                                                            
plot(degrau);
title ('Degrau');

%Declara e plota a Rampa:
t = linspace ( 0 , 5,1000);
rampa = t;
subplot (2,2,2);
plot(rampa);
title ('Rampa');

%Declara e plota parábola:
parabola = (t.^2)/2;
subplot (2,2,3);
plot(parabola);
title ('Parábola');


%%%%%%%%       Problema 1

%Declaração da G(s)
numg=15 * poly([-6]); %Declara numerador de G(s)
deng = poly([-2 -14 -135]); % Define o denominador de G(s).
G=tf(numg,deng);
%Análise Estabilidade
T=feedback(G,1); %Verifica Estabilidade
polos = pole(T); % Calcula os polos em malha fechada.

%Exibe os pólos em malha fechada
for i = 1: size(polos,1) %para cada linha do vetor
    fprintf('Os pólos em malha fechada são: %.2f.\n',polos(i));
end

%Análise Degrau
Kp=dcgain(G); % Calcula Kp
erroP = 1/(1+Kp);
figure
subplot (2,2,1); 
lsim(G,degrau,t)

%Análise Rampa

numSg=conv ([1 0],numg); % Define o numerador de sG(s).
denSg=deng; % Define o denominador de sG(s).
sG=tf (numSg,denSg); % Cria sG(s).
sG=minreal (sG); % Cancela 's' em comum no numerador
Kv=dcgain(sG); % Calcula Kv=sG(s)
erp=1/Kv; % Calcula o erro em regime permanente Kv
subplot (2,2,2); 
lsim(sG,rampa,t)

%Análise Parabola

nums2g=conv ([1 0 0],numg); % Define o numerador de s^2G(s).
dens2g=poly([-8 -10 -12]); % Define o denominador de s^2G(s).
s2G=tf (nums2g,dens2g); % Cria s^2G(s).
s2G=minreal (s2G); % Cancela 's' em comum no numerador
Ka=dcgain(s2G); % Calcula Ka=s^2G(s) para s=0.
erp=1/Ka; % Calcula o erro em regime permanente
subplot (2,2,3); 
lsim(s2G,parabola,t)

% fprintf('Kp = %.2f Kv = %.2f Ka = %.2f \n',kp,kv,ka);

%%%%%%%%       Problema 2

numg= 1; %Declara numerador de G(s)
deng = poly([-2 -14 -135]); % Define o denominador de G(s).
G=tf(numg,deng);
T=feedback(G,1); %Verifica Estabilidade
polos = pole(T); % Calcula os polos em malha fechada.

