%Chercher toutes les possibilité

chercherPossibilite(X, ListeRond, ListeCroix, Accumulateur, Result):-
	(X<28; chercherPossibiliteGaucheHoriz(X, ListeRond, ListeCroix, Accumulateur, Result)),
	(X>70; chercherPossibiliteDroiteHoriz(X, ListeRond, ListeCroix, Accumulateur, Result)),
	((Var is X-7, Var2 is Var mod 10, Var2 == 0); chercherPossibiliteBasVert(X, ListeRond, ListeCroix, Accumulateur, Result)),
	((Var is X-2, Var2 is Var mod 10, Var2 == 0); chercherPossibiliteHautVert(X, ListeRond, ListeCroix, Accumulateur, Result)),
	(X<28 ; (Var is X-2, Var2 is Var mod 10, Var2 == 0)); chercherPossibiliteDiagGaucheHaut(X, ListeRond, ListeCroix, Accumulateur, Result)),
	(X>70 ; (Var is X-2, Var2 is Var mod 10, Var2 == 0)); chercherPossibiliteDiagDroiteHaut(X, ListeRond, ListeCroix, Accumulateur, Result)),
	(X<28 ; (Var is X-7, Var2 is Var mod 10, Var2 == 0)); chercherPossibiliteDiagGaucheBas(X, ListeRond, ListeCroix, Accumulateur, Result)),
	(X>70 ; (Var is X-7, Var2 is Var mod 10, Var2 == 0)); chercherPossibiliteDiagDroiteBas(X, ListeRond, ListeCroix, Accumulateur, Result)).

%Chercher possibilité DiagonaleDroite

chercherPossibiliteDiagDroiteHaut(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteDiagDroiteHaut(X+9, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteDiagDroiteHaut(XNow,_, _, _, _, _):- XNow > 80,!.

chercherPossibiliteDiagDroiteHaut(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X+9,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X+9, member(X1, ListeCroix)
	), XNow2 is XNow+9,
	chercherPossibiliteDiagDroiteHaut2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.
chercherPossibiliteDiagDroiteHaut(_,_,_,_,_,_):-true.


chercherPossibiliteDiagDroiteHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow+9, chercherPossibiliteDiagDroiteHaut2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagDroiteHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow > 80),!.

chercherPossibiliteDiagDroiteHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.




chercherPossibiliteDiagDroiteBas(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteDiagDroiteBas(X+11, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteDiagDroiteBas(XNow,_, _, _, _, _):- XNow > 80,!.

chercherPossibiliteDiagDroiteBas(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X+11,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X+11, member(X1, ListeCroix)
	), XNow2 is XNow+11,
	chercherPossibiliteDiagDroiteBas2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagDroiteBas(_,_,_,_,_,_):-true.


chercherPossibiliteDiagDroiteBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow+11, chercherPossibiliteDiagDroiteBas2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagDroiteBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow > 80),!.

chercherPossibiliteDiagDroiteBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.


%Chercher possibilité DiagonaleGauche

chercherPossibiliteDiagGaucheHaut(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteDiagGaucheHaut(X-11, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteDiagGaucheHaut(XNow,_, _, _, _, _):- XNow < 18,!.

chercherPossibiliteDiagGaucheHaut(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X-11,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X-11, member(X1, ListeCroix)
	), XNow2 is XNow-11,
	chercherPossibiliteDiagGaucheHaut2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.
X.
chercherPossibiliteDiagGaucheHaut(_,_,_,_,_,_):-true.


chercherPossibiliteDiagGaucheHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow-11, chercherPossibiliteDiagGaucheHaut2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagGaucheHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow < 18),!.

chercherPossibiliteDiagGaucheHaut2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.




chercherPossibiliteDiagGaucheBas(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteDiagGaucheBas(X-9, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteDiagGaucheBas(XNow,_, _, _, _, _):- XNow < 18,!.

chercherPossibiliteDiagGaucheBas(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X-9,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X-9, member(X1, ListeCroix)
	), XNow2 is XNow-9,
	chercherPossibiliteDiagGaucheBas2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagGaucheBas(_,_,_,_,_,_):-true.


chercherPossibiliteDiagGaucheBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow-9, chercherPossibiliteDiagGaucheBas2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDiagGaucheBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow < 18),!.

chercherPossibiliteDiagGaucheBas2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.


%Chercher possibilité verticale

chercherPossibiliteHautVert(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteHautVert(X-1, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteHautVert(XNow,_, _, _, _, _):- Var is XNow-1, Var2 is Var mod 10, Var2 == 0,!.

chercherPossibiliteHautVert(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X-1,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X-1, member(X1, ListeCroix)
	), XNow2 is XNow-1,
	chercherPossibiliteHautVert2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteHautVert(_,_,_,_,_,_):-true.


chercherPossibiliteHautVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow-1, chercherPossibiliteHautVert2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteHautVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (Var is X-1, Var2 is Var mod 10, Var2 = 0)),!.

chercherPossibiliteHautVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.






chercherPossibiliteBasVert(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteBasVert(X+1, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteBasVert(XNow,_, _, _, _, _):- Var is XNow-8, Var2 is Var mod 10, Var2 == 0,!.

chercherPossibiliteBasVert(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X+1,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X+1, member(X1, ListeCroix)
	), XNow2 is XNow+1,
	chercherPossibiliteBasVert2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteBasVert(_,_,_,_,_,_):-true.


chercherPossibiliteBasVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow+1, chercherPossibiliteBasVert2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteBasVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (Var is XNow-8, Var2 is Var mod 10, Var2 == 0)),!.

chercherPossibiliteBasVert2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.







%Recherche Horizontale (droite et gauche)

chercherPossibiliteDroiteHoriz(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteDroiteHoriz(X+10, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteDroiteHoriz(XNow,_, _, _, _, _):- XNow > 80,!.

chercherPossibiliteDroiteHoriz(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X+10,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X+10, member(X1, ListeCroix)
	), XNow2 is XNow+10,
	chercherPossibiliteDroiteHoriz2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDroiteHoriz(_,_,_,_,_,_):-true.


chercherPossibiliteDroiteHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow+10, chercherPossibiliteDroiteHoriz2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteDroiteHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow < 11 ; XNow>88)),!.

chercherPossibiliteDroiteHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.







chercherPossibiliteGaucheHoriz(X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-chercherPossibiliteGaucheHoriz(X-10, X, ListeRond, ListeCroix, ListeCasesPossibles, Result).

chercherPossibiliteGaucheHoriz(XNow,_, _, _, _, _):- XNow > 80,!.

chercherPossibiliteGaucheHoriz(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result):-
	(
	 member(X, ListeCroix), X1 is X-10,member(X1, ListeRond);
	 member(X, ListeRond), X1 is X-10, member(X1, ListeCroix)
	), XNow2 is XNow-10,
	chercherPossibiliteGaucheHoriz2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteGaucheHoriz(_,_,_,_,_,_):-true.


chercherPossibiliteGaucheHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :- 
	(
	 member(X, ListeRond), member(XNow, ListeCroix) ;
	 member(X, ListeCroix), member(XNow, ListeRond)
	),  XNow2 is XNow-10, chercherPossibiliteGaucheHoriz2(XNow2, X, ListeRond, ListeCroix, ListeCasesPossibles, Result),!.

chercherPossibiliteGaucheHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, Result) :-
	(member(XNow, ListeCasesPossibles); (XNow < 11 ; XNow>88)),!.

chercherPossibiliteGaucheHoriz2(XNow, X, ListeRond, ListeCroix, ListeCasesPossibles, [XNow|ListeCasesPossibles]):-true.

trouverLigne(X, Ligne):- Ligne is X//10.
trouverColonne(X, Colonne) :- Colonne is X mod 10.






/*
	jouerCoup permet au joueur Joueur de placer un jeton sur la case Coup et effectue les changements de jetons engendrés.
	
	Mode d'emploi :
	jouerCoup(Joueur, Coup, CasesJoueurX, CasesJoueurO, NvCasesJoueurX, NvCasesJoueurO).
*/
jouerCoup(x, Coup, CasesJoueurX, CasesJoueurO, NvCasesJoueurX, NvCasesJoueurO) :-
	coin(Coup), Coup == 11;
	coin(Coup), Coup == 18, chercherProchainPion(Joueur, Coup, 
	
	
/*
	changerLigne change tous les pions en les mettant depuis la coordonnée de Coup dans la direction Direction de la couleur de Joueur
	jusqu'à ce qu'un autre pion du joueur soit rencontré.
	La valeur de Direction peut être :
	+1 (droite)
	-1 (gauche)
	+10 (bas)
	-10 (haut)
	+11 (diagonale bas droite)
	-11 (diagonale haut gauche)
	+9 (diagonale bas gauche)
	-9 (diagonale haut droite)
	
	Mode d'emploi
	changerLigne(Joueur, Coup, Direction, CasesJoueurX, CasesJoueurO, NvCasesJoueurX, NvCasesJoueurO).
*/
	changerLigne(Joueur, Coup, Direction, CasesJoueurX, CasesJoueurO, NvCasesJoueurX, NvCasesJoueurO).
	
% Fonctions outils

/* supprimerElement supprime les occurences de l'element Element dans la liste ListeIn et en crée la nouvelle liste ListeOut.

	Mode d'emploi :
	supprimerElement(Element, ListeIn, ListeOut).
*/
supprimerElement(Element,[Element],[]). %point d'arret si la liste finit par Element
supprimerElement(Element,[B|[]],[B|[]]). %point d'arret si la liste finit par autre chose
supprimerElement(Element,[Element|Q1],Q2):-supprimerElement(Element,Q1,Q2). %on efface les Element
supprimerElement(Element,[T1|Q1],[T1|Q2]):-supprimerElement(Element,Q1,Q2). %si la lettre analysée n'est pas Element on la garde

%Fin fonctions outils