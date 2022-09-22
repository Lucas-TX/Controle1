% Equações do Circuto em (s):
% M1: (R2 + sL + R1) * I1 - R1*R2 = V
% M2: R1*I2 - R1*I1 + Vc = 0 
% I1 = Vc/R1 + C * s * Vc  
% F(s)=  (R1^2) / (s^2 + s*((L + R1*R2*C)/(R1*L*C)) + ((R1 + R2)/(R1*L*C)))
  
% Modelo Sistemas de 2° ordem:
% Considerando: Y(s)/X(s) = (Ka*Wn^2) / (s^2 + s*2*z*Wn + Wn^2)
% Tp = pi/(Wn * sqrt(1 - z^2)) 

%Valores Hardcoded:
% R1 = 3300 ohms
% L = 0.100 H
% z = 0.69
%Tp = 0.009 s

clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comandos

%Declara variáves simbólicas usadas no projeto:
syms s Ka;

%Declara parâmetros hardcoded:
R1 = 3300;
L = 0.100;
z = 0.69;
Tp = 0.009;

%Calcula Wn com base no valor de tempo de pico
Wn = pi / (Tp * sqrt(1 - z^2));

%Calcula costante Ka
Ka = (R1^2) / (Wn^2);

%Calcula R2:
R2 = (((-1)*2*L*z*Wn + R1) + sqrt(4*(L^2)*(z^2)*(Wn^2) + 4*R1*L*z*Wn + (R1^2) - 4*(L^2)*(Wn^2))) / 2;

%Calcula C:
CapacitorC = (R1 + R2) / (R1*L*(Wn^2));

%Com base no modelo de 2° ordem, função de transferência F(s) simbólica:
F_sym = (Ka * Wn^2) / (s^2 + (2*z*Wn*s) + Wn^2);

%declara função de transferência com transfer Function
F_tf = sym2tf(F_sym);
step(F_tf);

degrau = tf(1,[1 0]); %declara a função degrau em s
C = tf2sym(F_tf*degrau); %multiplica função de transferência F e a função degrau em s e converte para simbólico
c = ilaplace(C);

%Plota Vc(t)
figure
fplot(c)
title ('Vc(t)');
xlabel('tempo (s)');


%Informa a função de transferência F(s)
fprintf('A equação de transferência é: %s',char(F_sym));










