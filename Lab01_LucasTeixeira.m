clear all;                                                                  %apaga todas as variáveis
close all;                                                                  %fecha todas as figuras
clc;                                                                        %limpa a janela de comandos

aleatorias = rand (1,1000);                                                 %gera vetor "aleatorias"
arcoseno = linspace (0,1,1000);                                             %gera vetor "arcoseno"
arcoseno = asin(arcoseno);                                                  %calcula o valor do arcoseno da variavel "arcorseno"
multiplicacao = aleatorias .* arcoseno;                                     %multiplica os vetores por posição

figure;                                                                     %cria nova figura
subplot (2,2,1);                                                            %escreve no index 1 da figura
plot(aleatorias,'y');                                                       %plota vetor aleatórias em verde
title ('Aleatórias');                                                       % Atribui 'Aleatórias' no título do plot 

subplot (2,2,2);                                                            %Escreve no index 2 da figura
plot(arcoseno,'--g','MarkerIndices',1:5:length(arcoseno));                  %plota o vetor Arcoseno em amarelo
title ('Arcoseno');                                                         %atribui 'Arcoseno' no título do plot
ylabel('radianos');                                                         %altera o ylabel para 'radianos'


subplot(2,2,3);                                                             %Escreve no index 3 da figura
plot(multiplicacao,'c');                                                    %plota o vetor multiplicacao em ciano
title ('Multiplicação');                                                    %atribui 'multiplicação' no título do plot
ylabel('aleatorias X Arcoseno');                                            %altera o ylabel para 'Aleatórias X Arcoseno'

subplot(2,2,4);                                                             %Escreve no index 3 da figura
plot(multiplicacao(find(multiplicacao,length(multiplicacao)/4,'last')),'r');%plota 1/4 do vetor Multiplicacao em vermelho
title ('Último 1/4 da multiplicação');                                      %atribui 'Último 1/4 da multiplicação' no título do plot
ylabel('aleatorias X Arcoseno');                                            %altera o ylabel para 'Aleatórias X Arcoseno'

figure;                                                                     %cria nova figura
primeiroUltimoQuarto = [arcoseno(find(arcoseno,length(arcoseno)/4)) arcoseno(find(arcoseno,length(arcoseno)/4,'last'))]; %cria o vetor que contém o primeiro e último quarto do vetor 'Arcoseno'
plot(primeiroUltimoQuarto,'--mo');                                          %plota o primeiro e o último 1/4 do vetor Arcoseno em Magenta
ylabel('radianos');                                                         %altera o ylabel para 'radianos'
title ('1° e último quarto do Arcoseno');                                   %atribui '1° e último quarto do Arcoseno' no título do plot














