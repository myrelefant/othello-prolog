appartient(X,[X|_]).
appartient(X,[_|Queue]) :- appartient(X,Queue).

append([],L1,L1).
append([A|L1],L2,[A|L3]):-append(L1,L2,L3).

inv(E,S):- nonvar(E), inv(E,[],S) ; var(E) , inv(S,[],E).
inv([T|Q],Accumulateur,Resultat):- inv(Q,[T|Accumulateur],Resultat).
inv([],ResultatFinal,ResultatFinal).

%marche pas encore
extract([],R).
extract([T1|Q1],[T1|Q2]):-extract(Q1,[T1|Q2]);extract(Q1,Q2).
extract([T1|Q1],R):-extract(Q1,[T1|R]);extract(Q1,R).

%ancienne version
%suppression(Lettre,Chaine,Resultat) :- suppression(Lettre,Chaine,[],Resultat).
%suppression(Lettre,[Lettre|Queue],Accumulateur,Resultat) :- suppression(Lettre,Queue,Accumulateur,Resultat),!.
%suppression(Lettre,[Tete|Queue],[Tete|Accumulateur],Resultat) :- suppression(Lettre,Queue,Accumulateur,Resultat).
%suppression(Lettre,[],ResultatFinal,ResultatFinal).

suppr(Lettre,[Lettre],[]). %point d'arret si la liste finit par Lettre
suppr(Lettre,[B|[]],[B|[]]). %point d'arret si la liste finit par autre chose
suppr(Lettre,[Lettre|Q1],Q2):-suppr(Lettre,Q1,Q2). %on efface les Lettre
suppr(Lettre,[T1|Q1],[T1|Q2]):-suppr(Lettre,Q1,Q2). %si la lettre analysée n'est pas Lettre on la garde

%donné par alexis
subsAll(A,X,[A],[X]). % point d'arret si la liste fini par "A"
subsAll(A,X,[MH|[]],[MH|[]]). % point d'arret si la liste fini par autre chose
subsAll(A,X,[A|LT],[X|RT]):-subsAll(A,X,LT,RT). % on remplace les "A" par des "X"
subsAll(A,X,[LH|LT],[LH|RT]):-not(LH == A), subsAll(A,X,LT,RT). % Si ce n'est pas un "A" on continue en gardant la meme valeur

%donné dans le cours
len([],0).
len([T|Q],N):-len(Q,N1),N is N1+1.

element(Position,Lettre,[Lettre|Q]):-Position is 1.
element(Position,Lettre,[T|Q]):-nonvar(Position),Position2 is Position-1,element(Position2,Lettre,Q).%si Position a une valeur
element(Position,Lettre,[T|Q]):-var(Position),element(Position2,Lettre,Q),Position is Position2+1. %si Position est a trouver

estEnsemble(Liste):-estEnsemble(Liste,[]).
estEnsemble([],_).
estEnsemble([T|Q],ElementsPresents):- not(appartient(T,ElementsPresents)), estEnsemble(Q,[T|ElementsPresents]).

%encore un ptit bug, ex de resultat :  X = [b, c, d, e, f|_G710] 
list2Ens([],_).
list2Ens([T|Q],[T|Q2]):-not(appartient(T,Q2)), list2Ens(Q,Q2).
list2Ens([T|Q],L2):-appartient(T,L2), list2Ens(Q,L2).

avant(Nom1,Nom2):-name(Nom1,N1), name(Nom2,N2), avant(N1,N2,[]).
avant([T1,Q1],[T2,Q2],_):-T1 < T2 ; T1 == T2, avant(Q1,Q2,[]).
avant(N1,N2,[]):-N1 < N2.
:-op(700, xfy, avant). %définir avant comme un opérateur utilisable ainsi : x avant y. Référence : http://www.cse.unsw.edu.au/~billw/cs9414/notes/prolog/op.html