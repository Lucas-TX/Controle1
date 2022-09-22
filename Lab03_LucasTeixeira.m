%Equações diferenciais do sistema.
%MALHA 1: v(t) = L*d(i1)/dt + R1*i1(t) + R2*i1(t) - R2*i2(t)
%MALHA 2: 0    = R2*i2(t) - R2*i1(t) + (1/C)*Integral(i2) dt
%
%vC(t) = vL(t) + vR(t) + v(t)
%(1/C)*Integral(iC) dt = L*d(i1)/dt + R1*i1(t) + v(t)

%Aplicando Laplace nas equações acima e considerando condições iniciais nulas:
%MALHA 1: V(s) = L*s*I1(s) + R1*I1(s) + R2*I1(s) - R2*I2(s)
%MALHA 2: 0 = R2*I2(s) - R2*I1(s) + (1/C*s)*I2(s)
%


clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comandos