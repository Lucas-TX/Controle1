%Estratégia - Prob1:
%Verifica estabilidade
%Calcular constantes de erro: Kp,Kv,Ka
%Para cada entrada, obter erros esperados
%Usar lsim para plotar resposta a cada um dos sistemas

%Estratégia-Prob2
%Verificar Estabilidade

clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comando

%%%%%%%%    Problema 1

%%%%% Dados hardcoded %%%%%
numg=15 * poly([-6]); %Declara numerador de G(s)
deng = poly([-2 -14 -135]); % Define o denominador de G(s).
syms t;
%%%%% Dados hardcoded %%%%%

G=tf(numg,deng); % Cria G(s)
T=feedback(G,1); %Verifica Estabilidade
polos = pole(T); % Exibe os polos em malha fechada.
Kp=dcgain(G); % Calcula Kp=numg/deng para s=0.
erroP = 1/(1+Kp);

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


%Declara e plota ...:
subplot (2,2,4);
plot(polos)




%%%%%%%%Problema 2


%%%%%%%%Exemplo 1

% '(ch7p1) Exemplo 7.4, sistema b'
% % Exibe o título.
% numg=500*poly ([−2 −5 −6]); % Define o numerador de G(s).
% deng=poly ([0 −8 −10 −12]); % Define o denominador de G(s).
% G=tf (numg,deng); % Cria G(s).
% 'Verifica a Estabilidade' % Exibe o título.
% T=feedback (G,1); % Cria T(s).
% polos=pole(T) % Exibe os polos em malha fechada.
% 'Entrada em Degrau' % Exibe o título.
% Kp=dcgain(G) % Calcula Kp=numg/deng para s=0.
% erp=1/(1+Kp) % Calcula erp para entrada em degrau.
% 'Entrada em Rampa' % Exibe o título.
% numsg=conv ([1 0],numg); % Define o numerador de sG(s).
% densg=poly ([0 −8 −10 −12]); % Define o denominador de sG(s).
% sG=tf (numsg,densg); % Cria sG(s).
% sG=minreal (sG); % Cancela 's' em comum no numerador
% % (numsg) e no denominador (densg).
% Kv=dcgain(sG) % Calcula Kv=sG(s) para s=0.
% erp=1/Kv % Calcula o erro em regime permanente
% % para uma entrada em rampa.
% 'Entrada em Parábola' % Exibe o título.
% nums2g=conv ([1 0 0],numg); % Define o numerador de s^2G(s).
% dens2g=poly([−8 −10 −12]); % Define o denominador de s^2G(s).
% s2G=tf (nums2g,dens2g); % Cria s^2G(s).
% s2G=minreal (s2G); % Cancela 's' em comum no numerador
% % (nums2g) e no denominador (dens2g).
% Ka=dcgain(s2G) % Calcula Ka=s^2G(s) para s=0.
% erp=1/Ka % Calcula o erro em regime permanente
% % para uma entrada em parábola.