%fonctions outils
%------------------------------------------------------------
/*
	nonVide retourne vrai si la liste passee en parametre a au moins un element, faux sinon.
	
	Mode d'emploi :
	nonVide(Liste).
*/
nonVide([]) :- !,fail.
nonVide(_).

/*
	max compare Nb1 et Nb2 et retourne le plus grand des deux.

	Mode d'emploi :
	max(Nb1, Nb2, Resultat)
*/
max(Nb1, Nb1, Nb1) :- !.
max(Nb1, Nb2, Resultat) :- Nb1 > Nb2, Resultat is Nb1, !; Nb1 < Nb2, Resultat is Nb2, !.

%------------------------------------------------------------
%fin fonctions outils


%liste des cases qui sont aux coins du plateau
coin(11). coin(18). coin(81). coin(88).

%liste des cases qui sont sur un bord du plateau
bord(12). bord(13). bord(14). bord(15). bord(16). bord(17).
bord(21). bord(31). bord(41). bord(51). bord(61). bord(71).
bord(82). bord(83). bord(84). bord(85). bord(86). bord(87).
bord(28). bord(38). bord(48). bord(58). bord(68). bord(78).


/*
	valeurCase retourne la valeur assignee a la case. Une case de coin vaut 10, une case de bord vaut 5, une case quelconque vaut 1.
	
	Mode d'emploi :
	valeurCase(CoordonneesCase, Importance).
*/
valeurCase(Coordonnees, 10) :- coin(Coordonnees),!.
valeurCase(Coordonnees, 5) :- bord(Coordonnees),!.
valeurCase(Coordonnees, 1) :- !.

/*
	jetonAdverse retourne le symbole du jeton adverse
	
	Mode d'emploi : 
	jetonAdverse(MonJeton, JetonAdverse).
*/
jetonAdverse(x,o).
jetonAdverse(o,x).


/*
	rechercheAlphaBeta retourne la meilleure case a jouer pour le joueur, grace a l'algorithme Alpha-Beta d'une certaine profondeur.
	
	Mode d'emploi :
	rechercheAlphaBeta(Joueur, CasesJoueurX, CasesJoueurY, CasesVides, CoupsPossibles, ProfondeurRecherche, Profondeur, Alpha, Beta, MeilleurCoup, ValeurMeilleurCoup).
*/
rechercheAlphaBeta(Joueur, CasesJoueurX, CasesJoueurO, CasesVides, [Coup|AutresCoups], ProfondeurRecherche, Profondeur, Alpha, Beta, MeilleurCoup, ValeurMeilleurCoup) :-
	
	jetonAdverse(Joueur, Adversaire),
	nonVide(CoupsPossibles),
	nonVide(CasesJoueurX),
	nonVide(CasesJoueurY),
	ProfondeurCourante is Profondeur - 1,
	Alpha2 is -Alpha,
	Beta2 is -Beta,
	%jouer coup,
	rechercheAlphaBeta(Adversaire, CasesJoueurX, CasesJoueurO, CasesVides, CoupsPossibles, ProfondeurRecherche, Profondeur, Alpha2, Beta2, MeilleurCoup2, ValeurMeilleurCoup2).


/*
	evaluation retourne la valeur d'un plateau de jeu défini par CasesJoueurX et CasesJoueur0 pour un joueur Joueur. La valeur du plateau est la
	somme des points du joueur moins la somme des points de l'adversaire.
	
	Mode d'emploi :
	evaluation(Joueur, Adversaire, CasesJoueurX, CasesJoueurO).
*/

evaluation(Joueur, CasesX, CasesO, Valeur) :- 
	jetonAdverse(Joueur, Adversaire), evaluation(Joueur, Adversaire, CasesX, CasesO, Valeur1), evaluation(Adversaire, Joueur, CasesX, CasesO, Valeur2), Valeur is Valeur1 - Valeur2.
evaluation(x,_,[],_,0) :- !. %si on évalue le joueur o et qu'il n'y a plus de cases xs, on a une valeur de 0
evaluation(o,_,_,[],0) :- !. %si on évalue le joueur o et qu'il n'y a plus de cases o, on a une valeur de 0
evaluation(x, Adversaire, [CaseX|CasesX], _, Valeur) :- 
	evaluation(x, Adversaire, CasesX, _, Valeur1), valeurCase(CaseX, Valeur2), Valeur is Valeur1 + Valeur2, !.
evaluation(o, Adversaire, _, [CaseO|CasesO], Valeur) :-	
	evaluation(o, Adversaire, _, CasesO, Valeur1), valeurCase(CaseO, Valeur2), Valeur is Valeur1 + Valeur2, !.
	
/*
	elagage procède à une coupure de l'arbre de possibilités si nécessaire
	
	Mode d'emploi :
	elagage(................).
*/	
elagage(_).


/*
	rechercheMinMax joue le coup CoupAJouer et recherche ensuite le coup suivant optimal pour le nouveau plateau.
	
	Mode d'emploi :
	rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupAJouer, CoupOptimal, Score).
	
*/
rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupAJouer, CoupOptimal, Score) :- 
	jouerCoup(Joueur, Coup, CasesJoueurX, CasesJoueurO, NvCasesJoueurX, NvCasesJoueurO),
	coupsPossibles(Joueur, NvCasesJoueurX, NvCasesJoueurO, CasesPossibles),
	ProfondeurInf is Profondeur-1,
	lancerRecherche(ProfondeurInf, Joueur,  CasesJoueurX, CasesJoueurO, CasesPossibles, CoupOptimal, -ScoreCoup).

lancerRecherche(0, Joueur, CasesJoueurX, CasesJoueurO, CasesPossibles, MeilleurCoup, Score) :- 
	evaluation(Joueur, CasesJoueurX, CasesJoueurO, Score),!. %on a atteint la profondeur de recherche maximum
lancerRecherche(_, Joueur, CasesJoueurX, CasesJoueurO, [], MeilleurCoup, Score) :- 
	evaluation(Joueur, CasesJoueurX, CasesJoueurO, Score),!. %il n'y a plus de coup à évaluter
lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, [Coup|CoupsPossibles], MeilleurCoup, Score) :-
	rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, Coup, CoupOptimal1, Score1),
	lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupsPossibles, CoupOptimal2, Score2),
	(Score1 > Score2 ->
		Score is Score1, MeilleuCoup is CoupOptimal1
	;
		Score is Score2, MeilleurCoup is CoupOptimal2
	)
	%on prend le score maximum
	.
	