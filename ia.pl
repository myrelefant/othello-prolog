%fonctions outils
%------------------------------------------------------------
/*
	nonVide retourne vrai si la liste passee en parametre a au moins un element, faux sinon.
	
	Mode d'emploi :
	nonVide(Liste).
*/
nonVide([]) :- !,fail.
nonVide(_).

/* supprimerElement supprime les occurences de l'element Element dans la liste ListeIn et en crée la nouvelle liste ListeOut.

	Mode d'emploi :
	supprimerElement(Element, ListeIn, ListeOut).
*/
supprimerElement(Element,[Element],[]). %point d'arret si la liste finit par Element
supprimerElement(Element,[B|[]],[B|[]]). %point d'arret si la liste finit par autre chose
supprimerElement(Element,[Element|Q1],Q2):-supprimerElement(Element,Q1,Q2). %on efface les Element
supprimerElement(Element,[T1|Q1],[T1|Q2]):-supprimerElement(Element,Q1,Q2). %si la lettre analysée n'est pas Element on la garde

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
	importanceCase retourne la valeur assignee a la case. Une case de coin vaut 10, une case de bord vaut 5, une case quelconque vaut 1.
	
	Mode d'emploi :
	importanceCase(CoordonneesCase, Importance).
*/
importanceCase(Coordonnees, 10) :- coin(Coordonnees).
importanceCase(Coordonnees, 5) :- bord(Coordonnees).
importanceCase(Coordonnees, 1).

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
rechercheAlphaBeta(Joueur, CasesJoueurX, CasesJoueurO, CasesVides, CoupsPossibles, ProfondeurRecherche, Profondeur, Alpha, Beta, MeilleurCoup, ValeurMeilleurCoup) :-
	jetonAdverse(Joueur, Adversaire),
	nonVide(CoupsPossibles),
	nonVide(CasesJoueurX),
	nonVide(CasesJoueurY),
	ProfondeurCourante is Profondeur - 1,
	Alpha2 is -Alpha,
	Beta2 is -Beta,
	%jouer coup,
	rechercheAlphaBeta(Adversaire, CasesJoueurX, CasesJoueurO, CasesVides, CoupsPossibles, ProfondeurRecherche, Profondeur, Alpha2, Beta2, MeilleurCoup2, ValeurMeilleurCoup2).




