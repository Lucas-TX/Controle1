%Estratégia:
%Usar diagrma de blocos para reduzir as 3 equações em 1
%Criar tabela segundo o critério de Routh-Hurwitz
%Verificar se há números positivos e negativos na primeira coluna
%Verificar se o ganho maior ou menor
%usar a função rlocus com um vetor que permita a visualização do momento em
%que o sistema fica instável

% Plotar root locus com vetor de ganho prédefinido
% para qu seeja possível visualizar,com maior precisão, o momento em que o
% sistema torna-se instável

%Equações do sistema
% G = 1/(s^2+10s+35)
% H = (s+20)/(s+4)
% Y = (K * G * X) / (1 + (K*G*H))
% F = Y/X = (k*G)/(1+(k*G*H))

clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comandos

%Declara funções hardcoded
G  = tf ([1],[1 10 35]);
H  = tf ([1 20],[1 4]);

%Declara variáves simbólicas usadas no projeto:
syms s;
syms k;


%converte funções para simbólico
G_sim = tf2sym(G);
H_sim = tf2sym(H);

%captura os coeficientes do denominador de F(s) simbólico 
F_sim = (k*G_sim) / (1 + (k*G_sim*H_sim));
F_sim = simplify(F_sim);
[numF,denF] = numden(F_sim);
coeficientesDenominadorF = fliplr(coeffs(denF,s));

%%%%Inicia tabela de routh com os coeficientes da equação característica

lengthCoeficientesDenominadorF = size(coeficientesDenominadorF,2); %captura o tamanho do vetor de coeficientes
highestDegree = lengthCoeficientesDenominadorF - 1; %identifica a potência mais alta
firstRowValue = coeficientesDenominadorF(1,1:2:lengthCoeficientesDenominadorF); %captura os valores começando da potência mais alta
secondRowValue = coeficientesDenominadorF(1,2:2:lengthCoeficientesDenominadorF); %captura os valores começando da 2° potência mais alta
if mod(highestDegree,2) == 0  %Verifica se a potência mais alta é PAR.
    evenDegreeValue(1,ceil(lengthCoeficientesDenominadorF/2)) = 0; %Se for PAR, adiciona 0 no final do vetor referente a 2° linha
end
routh_table(1,:) = firstRowValue; %Escreve primeira linha da tabela de routh
routh_table(2,:) = secondRowValue; %escreve segunda linha da tabela de routh

len = size(routh_table, 1); %captura tamanho da primeira coluna
bre = size(routh_table, 2); %captura tamanho da segunda coluna coluna
divisor = routh_table(len,1); %captura a última posição da primiera coluna
upperRow = routh_table(len-1,:); %captura todos os dados da primeira linha
downRow = routh_table(len,:); %captura todos os dados da segunda coluna linha
resultRow = zeros(1,bre,'like',routh_table); % gera vetor de zeros do mesmo tamanho e tipo do que a segunda coluna
j = 1; % declara index que indica em qual nova linha estamos inserindo dados

%%%%%Completa tabela de routh
%Lógica:
%Faz os cálculos necessários enquanto a soma das 2 primeiras colunas + j for <= ao
%número de coeficientes do denominador da equação característica.
%

while (len+j)<= lengthCoeficientesDenominadorF 
    for i = 1:bre-1
        a0 = upperRow(1);
        a2 = upperRow(1+i);
        a1 = downRow(1);
        a3 = downRow(1+i);
        c = (a1*a2 - a3*a0)/divisor; % calcula valor a ser inserido
        resultRow(1,i) = c; %insere novo valor no array de zeros
    end
    routh_table(len+j,:) = resultRow; %Insere novo array de zeros na tabela de routh
    %Atualiza a linhas usadas nos cálculos e o divisor
    upperRow = downRow;
    downRow = resultRow; 
    divisor = downRow(1,1);
    j = j+1;
end

%%%%%Verifica Estabilidade

% %Verifica o sinal do primeiro element não genérico

for i = 1: size(routh_table,1)
    %Resolve uma equação para a variável de ganho k
    resultSolucaoParaGanhoK = solve(routh_table(i,1),k);

    %Verifica se o resultado está vazio
    if isempty(resultSolucaoParaGanhoK)
        primeiroSinalEncontrado = sign(routh_table(i,1));
        %Captura o sinal que deve ser igual para todos os elementos da coluna
        break
    end
end

%declara flags usados na análise de sinais
flagNegativo = 0;
flagPostivo = 0;
ganhoK = 0;

%Para cada linha na primeira coluna
for i = 1: size(routh_table,1) %Percorre todas linhas da tabela de routh
    %Resolve uma equação para a variável de ganho k
    resultSolucaoParaGanhoK = solve(routh_table(i,1),k);     

    %Verifica se a variável está vazia
    if isempty(resultSolucaoParaGanhoK)
           %Se vazia, quer dizer que não há variável k na célula analisada
           %Nenhuma ação é necessária
           %Verifica sinal da célula atual
    
           if sign(routh_table(i,1)) < 0
                %Se o valor for negativo, aciona o flag negativo
                flagNegativo = 1;
           else
                %Se o valor for positivo, aciona o flag Positivo
                flagPostivo = 1;        
           end
    else
        %O resutado indica a solução da equação para 0, ou seja, o
        %resultado "k" zera o ganho
        if resultSolucaoParaGanhoK >= ganhoK
            ganhoK = resultSolucaoParaGanhoK;
        end  
        
    end
    
end


%%%%Verifica estado dos Flags e informa sobre a estabilidade

if flagPostivo==1 && flagNegativo==1
    %Informa mudanças de sinais
    fprintf('Houve mudança de sinal. Logo, o sistema é instável');
else
    %Verifica o ganho
    %Se não houver mudanças de sinal, existem 2 pólos complexos. Logo, a
    %faixa de estabilidade é entre +ganhoK e -ganhoK
    fprintf('A faixa de estabilidade está entre: %.2f e %.2f.\n',ganhoK,-ganhoK);
 
end

%Informa a função de transferência F(s)
fprintf('A equação de transferência é: %s \n',char(F_sim));

%Informa a tabela de routh
fprintf('A tabela de routh é:\n');
disp(routh_table)


%%%Usando a função rlocous
rlocus(G*H);
array_ganhoK = [-ganhoK-10:0.1:ganhoK+10];
figure
rlocus(G*H,array_ganhoK);

%%%Resposta ao degrau de F

k = ganhoK;
F_simComK = subs(F_sim);
F = sym2tf(F_simComK);
figure
step(F);
title ('Resposta ao degrau de F(s)');

%%%Pole-Zero map para alguns valores de k
array_SetganhoK = [-ganhoK-10 -ganhoK -ganhoK+10 0 ganhoK-10 ganhoK ganhoK+10];

for i =1 : size(array_SetganhoK,2)
    figure    
    k = array_SetganhoK(i);
    F_simComK = subs(F_sim);
    F = sym2tf(F_simComK);
    pzmap(F);
    title(sprintf('Pole-Zero map para k = %.2f', array_SetganhoK(i)))
    sym2tf
end







