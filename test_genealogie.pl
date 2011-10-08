pere(pat,elsa).
pere(pat,celine).
pere(pat,clemence).
pere(fred,theo).
pere(fred,alix).
pere(yann,axelle).
pere(yann,josselin).
pere(marc,julien).
pere(jeanphilippe,camille).
pere(jeanphilippe,guillaume).
pere(andre,pat).
pere(andre,marc).
pere(andre,jeanphilippe).
pere(antoine,christine).
pere(antoine,laurence).
pere(antoine,fred).
pere(maurice,antoine).
pere(rene,andre).
pere(gaston,monique).
pere(arsene,simone).

homme(pat).
homme(fred).
homme(theo).
homme(yann).
homme(josselin).
homme(marc).
homme(julien).
homme(jeanphilippe).
homme(guillaume).
homme(andre).
homme(antoine).
homme(maurice).
homme(rene).
homme(gaston).
homme(arsene).

mari(pat,christine).
mari(fred,florence).
mari(yann,laurence).
mari(marc,elisabeth).
mari(jeanphilippe,patricia).
mari(andre,simone).
mari(antoine,monique).
mari(maurice,andree).
mari(rene,mimi).
mari(gaston,germaine).
mari(arsene,josephine).

/******************************************************
 * regles                                             */

/* toute personne qui apparait au dessus et qui n'est pas un homme est une femme
 * soit elle est mariee, soit elle est enfant de quelqu'un. */
femme(F) :- mari(_,F).
femme(F) :- pere(_,F), not(homme(F)), not(mari(_,F)). /* le dernier pour eviter les doublons ! */
mere(M,E) :- pere(P,E),mari(P,M).
mere(X) :- mere(X,_). /* prevoyons egalement les predicats d'arite 1, 
		c'est a dire a un seul argument : X est une mere si elle a des enfants */
pere(X) :- pere(X,_).

enfant(E,P) :- pere(P,E).
enfant(E,M) :- mere(M,E).
enfant(X) :- enfant(X,_).

/* la, c'est une definition recurente */
descendant(D,A) :- enfant(D,A).
descendant(D,A) :- enfant(D,X),descendant(X,A).

/******************************************************
 * pour mes tests, il suffit de demander "aff."       */
aff :- homme(X),write('Homme : '),write(X),nl,fail.
aff :- femme(X),write('Femme : '),write(X),nl,fail.
aff :- pere(X), write('Pere : '), write(X),nl,fail.
aff :- mere(X), write('Mere : '), write(X),nl,fail.
aff :- enfant(X),write('Enfant : '),write(X),nl,fail.
aff :- descendant(D,A),write(D),write(' descend de '),write(A),nl,fail.