% ----------------------------------------- 
% Nome: Matheus Reis de Lima
% RA: 2018.1.08.052
% Trabalho 01 + COMPLEMENTAR ARVORE.PL
% Disciplina: Propramacao Logica
% Executado em: https://swish.swi-prolog.org/
% ----------------------------------------- 

% Predicado para inserir um nó na árvore
inserir(X, [], no(X, [], [])).
inserir(X, no(Info, Esq, Dir), no(Info, Esq1, Dir)) :-
    X < Info,
    inserir(X, Esq, Esq1).
inserir(X, no(Info, Esq, Dir), no(Info, Esq, Dir1)) :-
    X > Info,
    inserir(X, Dir, Dir1).
inserir(X, no(X, Esq, Dir), no(X, Esq, Dir)).

% Predicado para apagar um nó da árvore
apagar(_, [], []).
apagar(X, no(X, [], Dir), Dir).
apagar(X, no(X, Esq, []), Esq).
apagar(X, no(X, Esq, Dir), no(Sucessor, Esq, Dir1)) :-
    sucessor(Dir, Sucessor),
    apagar(Sucessor, Dir, Dir1).
apagar(X, no(Info, Esq, Dir), no(Info, Esq1, Dir)) :-
    X < Info,
    apagar(X, Esq, Esq1).
apagar(X, no(Info, Esq, Dir), no(Info, Esq, Dir1)) :-
    X > Info,
    apagar(X, Dir, Dir1).

% Predicado para encontrar o sucessor
sucessor(no(Info, [], _), Info).
sucessor(no(_, Esq, _), Sucessor) :-
    sucessor(Esq, Sucessor).

% Predicados para as ordens
preordem([]).
preordem(no(Info, Esq, Dir)) :-
    write(Info), write(' '),
    preordem(Esq),
    preordem(Dir).

emordem([]).
emordem(no(Info, Esq, Dir)) :-
    emordem(Esq),
    write(Info), write(' '),
    emordem(Dir).

posordem([]).
posordem(no(Info, Esq, Dir)) :-
    posordem(Esq),
    posordem(Dir),
    write(Info), write(' ').

% TRABALHO COMPLEMENTAR:

% Calcula a altura da árvore
altura([], 0).
altura(no(_, Esq, Dir), Altura) :-
    altura(Esq, AlturaEsq),
    altura(Dir, AlturaDir),
    Altura is max(AlturaEsq, AlturaDir) + 1.

% Verifica se a árvore é completa
arvore_completa(Arvore) :-
    altura(Arvore, Altura),
    nivel_completo(Arvore, Altura).

% Verifica se os níveis 1 a Altura-1 são completos
nivel_completo(_, 0).
nivel_completo(Arvore, Altura) :-
    Altura > 0,
    nivel_completo_aux(Arvore, 1, Altura).

% Verifica se todos os níveis de 1 a NivelMax-1 são completos
nivel_completo_aux(_, NivelAtual, Altura) :-
    NivelAtual >= Altura.
nivel_completo_aux(no(_, Esq, Dir), NivelAtual, Altura) :-
    NivelAtual < Altura,
    NivelProximo is NivelAtual + 1,
    no_valido(Esq),
    no_valido(Dir),
    nivel_completo_aux(Esq, NivelProximo, Altura),
    nivel_completo_aux(Dir, NivelProximo, Altura).
nivel_completo_aux(no(_, Esq, Dir), Altura, Altura) :-
    ultimo_nivel(Esq, 1, 0),
    ultimo_nivel(Dir, 1, 1).

% Verifica se um nó é válido (não é um nó vazio)
no_valido([]).
no_valido(no(_, _, _)).

% Verifica se os nós no último nível estão preenchidos da esquerda para a direita
ultimo_nivel([], _, _).
ultimo_nivel(no(_, Esq, Dir), Indice, Esperado) :-
    Indice =:= Esperado,
    Proximo is Indice + 1,
    ultimo_nivel(Esq, Proximo, 2 * Esperado + 1),
    ultimo_nivel(Dir, Proximo, 2 * Esperado + 2).

% ArvorePL original comentado

/*% Principal
main :-
    main([]).

main(Arvore) :-
    write('Escolha uma opcao:\n'),
    write('1 - Inserir\n'),
    write('2 - Apagar\n'),
    write('3 - Pre-ordem\n'),
    write('4 - Em-ordem\n'),
    write('5 - Pos-ordem\n'),
    write('6 - Fim\n'),
    read(Opcao),
    processa_opcao(Opcao, Arvore, NovaArvore),
    ( Opcao == 6 -> true ; main(NovaArvore) ).

processa_opcao(1, Arvore, NovaArvore) :-
    write('Digite o valor a inserir: '),
    read(Valor),
    inserir(Valor, Arvore, NovaArvore),
    write('Valor inserido.\n').
processa_opcao(2, Arvore, NovaArvore) :-
    write('Digite o valor a apagar: '),
    read(Valor),
    apagar(Valor, Arvore, NovaArvore),
    write('Valor apagado.\n').
processa_opcao(3, Arvore, Arvore) :-
    write('Travessia em pre-ordem: '),
    preordem(Arvore),
    nl.
processa_opcao(4, Arvore, Arvore) :-
    write('Travessia em em-ordem: '),
    emordem(Arvore),
    nl.
processa_opcao(5, Arvore, Arvore) :-
    write('Travessia em pos-ordem: '),
    posordem(Arvore),
    nl.
processa_opcao(6, Arvore, Arvore) :-
    write('Fim do programa.\n').
processa_opcao(_, Arvore, Arvore) :-
    write('Opcao invalida.\n').
*/

% Função principal modificada para trabalho complementar

main :-
    main([]).

main(Arvore) :-
    write('Escolha uma opcao:\n'),
    write('1 - Inserir\n'),
    write('2 - Apagar\n'),
    write('3 - Pre-ordem\n'),
    write('4 - Em-ordem\n'),
    write('5 - Pos-ordem\n'),
    write('6 - Verificar se a arvore é completa\n'),
    write('7 - Fim\n'),
    read(Opcao),
    processa_opcao(Opcao, Arvore, NovaArvore),
    ( Opcao == 7 -> true ; main(NovaArvore) ).

processa_opcao(1, Arvore, NovaArvore) :-
    write('Digite o valor a inserir: '),
    read(Valor),
    inserir(Valor, Arvore, NovaArvore),
    write('Valor inserido.\n').
processa_opcao(2, Arvore, NovaArvore) :-
    write('Digite o valor a apagar: '),
    read(Valor),
    apagar(Valor, Arvore, NovaArvore),
    write('Valor apagado.\n').
processa_opcao(3, Arvore, Arvore) :-
    write('Travessia em pre-ordem: '),
    preordem(Arvore),
    nl.
processa_opcao(4, Arvore, Arvore) :-
    write('Travessia em em-ordem: '),
    emordem(Arvore),
    nl.
processa_opcao(5, Arvore, Arvore) :-
    write('Travessia em pos-ordem: '),
    posordem(Arvore),
    nl.
processa_opcao(6, Arvore, Arvore) :-
    (   arvore_completa(Arvore)
    ->  write('A arvore é completa.\n')
    ;   write('A arvore não é completa.\n')
    ).
processa_opcao(7, Arvore, Arvore) :-
    write('Fim do programa.\n').
processa_opcao(_, Arvore, Arvore) :-
    write('Opcao invalida.\n').