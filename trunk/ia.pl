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
jetonAdverse(croix,rond).
jetonAdverse(rond,croix).


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
evaluation(croix,_,[],_,0) :- !. %si on évalue le joueur croix et qu'il n'y a plus de cases croix, on a une valeur de 0
evaluation(rond,_,_,[],0) :- !. %si on évalue le joueur rond et qu'il n'y a plus de cases rond, on a une valeur de 0
evaluation(croix, Adversaire, [CaseX|CasesX], _, Valeur) :- 
	evaluation(croix, Adversaire, CasesX, _, Valeur1), valeurCase(CaseX, Valeur2), Valeur is Valeur1 + Valeur2, !.
evaluation(rond, Adversaire, _, [CaseO|CasesO], Valeur) :-	
	evaluation(rond, Adversaire, _, CasesO, Valeur1), valeurCase(CaseO, Valeur2), Valeur is Valeur1 + Valeur2, !.
	
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
rechercheMinMax(1, Joueur, CasesJoueurX, CasesJoueurO, CoupAJouer, CoupAJouer, Score) :- 
	write('-----rechercheMinMaxFin--------'),
	write('Le joueur '), write(Joueur), write(' joue sur la case '), write(CoupAJouer), write('\n'),
	chercherCoupsPossibles(Joueur, CasesJoueurO, CasesJoueurX, CoupsPossibles),
	jouerPion(CoupAJouer, Joueur, CoupsPossibles, CasesJoueurO, CasesJoueurX, NvCasesJoueurO, NvCasesJoueurX),
	write('  casesJoueurX='), write(NvCasesJoueurX), write('  casesJoueurO='), write(NvCasesJoueurO), write('\n'),
	evaluation(Joueur, NvCasesJoueurX, NvCasesJoueurO, Score),!.



rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupAJouer, CoupOptimal, Score) :- 
	write('-----rechercheMinMax--------\n'),
	write('Le joueur '), write(Joueur), write(' joue sur la case '), write(CoupAJouer), write('\n'),
	chercherCoupsPossibles(Joueur, CasesJoueurO, CasesJoueurX, CoupsPossibles),
	jouerPion(CoupAJouer, Joueur, CoupsPossibles, CasesJoueurO, CasesJoueurX, NvCasesJoueurO, NvCasesJoueurX),
	jetonAdverse(Joueur,Adversaire),
	write('Coups possibles pour le joueur '), write(Adversaire), write(' : '),
	chercherCoupsPossibles(Adversaire, NvCasesJoueurO, NvCasesJoueurX, CasesPossiblesAdvTemp), %on cherche les coups possibles pour l adversaire à partir de la nouvelle configuration
	getListeCasesPossiblesOldFormat(CasesPossiblesAdvTemp, CasesPossiblesAdv),
	write('\n'),
	ProfondeurInf is Profondeur-1,
	(CasesPossiblesAdv \== [] ->
		write('-----lancerRecherche2('), write(ProfondeurInf), write(', '), write(Adversaire), write(', '), write(NvCasesJoueurX), write(', '), write(NvCasesJoueurO), write('\n'),
		lancerRecherche(ProfondeurInf, Adversaire,  NvCasesJoueurX, NvCasesJoueurO, CasesPossiblesAdv, CoupOptimal, ScoreCoupMin), Score is -ScoreCoupMin
		;
		CoupOptimal is CoupAJouer, Score is 2000 %si l'adversaire n'a plus de jeton, c'est un coup optimal!
	),
	write(' coupoptimal :'), write(CoupOptimal), write('; score :'), write(Score), write('\n')
	.
	
	
	

/*
	lancerRecherche trouve, pour un plateau donné, le meilleur coup à jouer pour le joueur Joueur en effectuant une
	recherche MinMax de profondeur Profondeur
	
	Mode d'emploi :
	lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupsPossibles, MeilleurCoup, Score)
	
*/
	
lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, [Coup], MeilleurCoup, Score) :- 
	write('-----lancerRecherche plusCases--------\n'),
	rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, Coup, MeilleurCoup, Score),!.
	
lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, [Coup|CoupsPossibles], MeilleurCoup, Score) :-
	rechercheMinMax(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, Coup, CoupOptimal1, Score1), %on teste un premier coup possible
	write('Score1 :'), write(Score1), write('\n'),
	write('-----lancerRecherche1--------\n'),
	lancerRecherche(Profondeur, Joueur, CasesJoueurX, CasesJoueurO, CoupsPossibles, CoupOptimal2, Score2), %on teste les autres coups possibles
	write('Score2 :'), write(Score2),
	write('  CoupOptimal1 :'), write(CoupOptimal1),
	write('  CoupOptimal2 :'), write(CoupOptimal2),
	(Score1 > Score2 ->
		Score is Score1, MeilleurCoup is CoupOptimal1
	;
		Score is Score2, MeilleurCoup is CoupOptimal2
	),
	%on prend le score maximum
	write('    Meilleur score: '), write(MeilleurCoup), write('\n')
	
	.

testIA :- getListeCasesPossiblesOldFormat([[27, -1, 24, -1, -1, -1, -1, 45, -1]], CasesPossibles), lancerRecherche(3, rond,  [26, 25, 28, 36], [27], CasesPossibles, MeilleurCoup, Score).
	
	
	
	%testIA :- getListeCasesPossiblesOldFormat([[44, 47, -1, 64, -1, -1, -1, -1, -1]], CasesPossibles), lancerRecherche(1, rond,  [45, 46, 54], [44], CasesPossibles, MeilleurCoup, Score).


