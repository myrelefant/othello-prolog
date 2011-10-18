/*
	Othello: 8*8

	Utilisant la console, on décide d utiliser des rond: o et des croix: x à la place du noir et du blanc.

	Règles du jeu:

		- Le joueur qui joue en premier possède les ronds
		- Un coup est possible si le joueur jouant mange les pions adverses
		- Tous les pions mangés deviennent de la forme de celui qui mange
		- Si un joueur ne possède pas de coup possible, il passe son tour.
		- Si les 2 joueurs n ont plus de coup possible, 2 fois à la suite, la partie est finie.
		- Le gagnant est celui qui possède le plus de pions sur le plateau à la fin
		- Le plateau sera modélisé comme suit:

			1  2  3  4  5  6  7  8
		
		1   11 12 13 14 15 16 17 18   1
		2   21 22 23 24 25 26 27 28   2
		3   31 32 33 34 35 36 37 38   3
		4   41 42 43 44 45 46 47 48   4
		5   51 52 53 54 55 56 57 58   5
		6   61 62 63 64 65 66 67 68   6
		7   71 72 73 74 75 76 77 78   7
		8	81 82 83 84 85 86 87 88   8

			1  2  3  4  5  6  7  8

		
		Nous utiliserons pour les méthodes 2 listes: 

			- Une liste contenant les pions du joueur rond: ListeRond
			- Une liste contenant les pions du joueur croix: ListeCroix

		un coup possible est représenté par un couple:
		
		- Coup(X, ListePionsEnnemis)
			X = Coordonnées du point joué
			ListePionsEnnemis: Liste de coordonnées des pions qui seront mangés

		Fonction à coder pour le jeu:

		Jeu: Cette fonction déroulera toutes les étapes du jeu
		JoueurCoup(X, ListeCoupPossible): X = 0 pour passer et X doit faire parti des coups possibles pour être valide
		RetournerPions(Tour, X): Retourne tous les pions ennemis mangeable par le joueur qui a son tour
		ChercherCoupsPossibles(Result): Cherche tous les coups possibles et les insère dans la liste Result. 

		sens de déplacement: 
			
			droite
			gauche
			bas
			haut
			hautGauche
			hautDroit
			basGauche
			basDroit

*/

isCase(X) :- Jeu = 
			[
				11, 12, 13, 14, 15, 16, 17, 18,   
			    21, 22, 23, 24, 25, 26, 27, 28,  
			    31, 32, 33, 34, 35, 36, 37, 38, 
			    41, 42, 43, 44, 45, 46, 47, 48,
			    51, 52, 53, 54, 55, 56, 57, 58,   
			    61, 62, 63, 64, 65, 66, 67, 68,   
			    71, 72, 73, 74, 75, 76, 77, 78,   
				81, 82, 83, 84, 85, 86, 87, 88
			], member(X, Jeu).


%XVoisin = 0 lorsque le pion n a pas de voisin.

getVoisin(X, droite, XVoisin) :- (eval(X+1, Res), isCase(Res) , XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, gauche, XVoisin) :- (eval(X-1, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, bas, XVoisin) :- (eval(X+10, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, haut, XVoisin):- (eval(X-10, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, hautGauche, XVoisin):- (eval(X-11, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, hautDroit, XVoisin) :- (eval(X-9, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, basGauche, XVoisin):- (eval(X+9, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.
getVoisin(X, basDroit, XVoisin):- (eval(X+11, Res), isCase(Res), XVoisin = Res, !) ; XVoisin = 0,!.

eval(Expr,Res):-Res is Expr.

vide(X, PionsJ, PionsA):- not(member(X, PionsJ)), not(member(X, PionsA)).

adversaire(rond, croix).
adversaire(croix, rond).

pionJoueur(rond, ListeRond, ListeCroix, ListeRond).
pionJoueur(croix, ListeRond, ListeCroix, ListeCroix).

testCoupsLegaux(R, A, B):- chercherCoupsPossibles(rond, [64, 46], [45, 54], R).


			
testJouerPiont(JN, AN):- jouerPion(44, rond, [[64, -1, -1, -1, 44, -1, -1, -1, -1], [46, -1, 44, -1, -1, -1, -1, -1, -1]] , [64, 46], [45, 54], JN, AN).

jouerPion(_,_,[], _, _, _, _):-!.
jouerPion(X, Joueur, [[XEnd, RG, RD, RH, RB, RHG, RHD, RBG, RBD]|LCP], ListeRond, ListeCroix, PionsJN, PionsAN):- 
									adversaire(Joueur, Adversaire), 
									pionJoueur(Joueur, ListeRond, ListeCroix, PionsJ),
									pionJoueur(Adversaire, ListeRond, ListeCroix, PionsA),
									jouerPion(X, Joueur, LCP, ListeRond, ListeCroix, PionsJN2, PionsAN2),
									((RD  == X, mangerPion(X, XEnd, droite, PionsJ, PionsA, PionsJND, PionsAND)); true),
									((RB  == X, mangerPion(X, XEnd, bas, PionsJ, PionsA, PionsJNB, PionsANB)); true),
									append(PionsJND, PionsJNB, PionsJNDoublon), append(PionsAND, PionsANB, PionsANDoublon), supprDoublon(PionsJNDoublon, PionsJN), supprDoublon(PionsANDoublon, PionsAN).


supprDoublon([E],[E]):- !. %une liste à un seul élément est un ensemble
supprDoublon([T|Q],[T|Q2]):- supprDoublon(Q,Q2), not(member(T,Q2)),!. %si T n est pas encore présent dans Q2, on cherche à transformar en ensemble Q dans Q2 puis on ajoute T à Q2.
supprDoublon([T|Q],L2):- supprDoublon(Q,L2), member(T,L2).

test(PionsJN, PionsAN):- mangerPion(47, 44, gauche, [44, 55], [45, 54, 46], PionsJN, PionsAN).

%mangerPion(CaseDébut, CaseCourante, CaseFin, Direction, PionsJ, PionsA, PionsJN, PionsAN) change les pions situés entre CaseDébut et CaseFin en les ajoutant dans les possessions de JoueurJ et en les enlevant des possessions de JoueurA
%si la case courante est la dernière case, on ne doit rien changer aux pions des joueurs

%si la case courante n est pas la dernière case, on cherche la prochaine case à changer et on relance le prédicat, puis on change la case sur les Pions résultant



mangerPion(X, XEnd, Direction, PionsJ, PionsA, PionsJN, PionsAN):- getVoisin(X, Direction, XCurr), mangerPion(X, XCurr, XEnd, Direction, PionsJ, PionsA, PionsJN, PionsAN).

mangerPion(_, X, X, _, PionsJ, PionsA, PionsJ, PionsA) :-!. 
mangerPion(X, XCurr, XEnd, Direction, PionsJ, PionsA, PionsJN, PionsAN):- getVoisin(XCurr, Direction, XVois), mangerPion(X, XVois, XEnd, Direction, PionsJ, PionsA, PionsJN2, PionsAN2), addElem(XCurr, PionsJN2, PionsJN3), addElem(X, PionsJN3, PionsJN), suppr(XCurr, PionsAN2, PionsAN),!.


suppr(Lettre,[Lettre],[]). %point d'arret si la liste finit par Lettre
suppr(Lettre,[B|[]],[B|[]]). %point d'arret si la liste finit par autre chose
suppr(Lettre,[Lettre|Q1],Q2):-suppr(Lettre,Q1,Q2),!. %on efface les Lettre
suppr(Lettre,[T1|Q1],[T1|Q2]):-suppr(Lettre,Q1,Q2). %si la lettre analysée n'est pas Lettre on la garde


chercherCoupsPossibles(Joueur,ListeRond, ListeCroix, R):- 
									adversaire(Joueur, Adversaire), 
									pionJoueur(Joueur, ListeRond, ListeCroix, PionsJ),
									pionJoueur(Adversaire, ListeRond, ListeCroix, PionsA), 
									chercherCoupsPossibles2(PionsJ, PionsJ, PionsA, R), write(R).



chercherCoupsPossibles2([], _, _,_):-!.
chercherCoupsPossibles2([TPj], PionsJ, PionsA, [RTemp]):- coupsLegaux(TPj, PionsJ, PionsA, RTemp),!.
chercherCoupsPossibles2([TPj|LPj], PionsJ, PionsA, [RTemp|R]):- coupsLegaux(TPj, PionsJ, PionsA, RTemp), chercherCoupsPossibles2(LPj, PionsJ, PionsA, R).


coupsLegaux(X, PionsJ, PionsA, [X | [RD, RG, RB, RH, RHG, RHD, RBG, RBD]]) :- 
																						  coupsLegauxFunc(X, droite, PionsJ, PionsA, RD),
																						  coupsLegauxFunc(X, gauche, PionsJ, PionsA, RG),
																						  coupsLegauxFunc(X, bas, PionsJ, PionsA, RB),
																						  coupsLegauxFunc(X, haut, PionsJ, PionsA, RH),
																						  coupsLegauxFunc(X, hautGauche, PionsJ, PionsA, RHG),
																						  coupsLegauxFunc(X, hautDroit, PionsJ, PionsA, RHD),
																						  coupsLegauxFunc(X, basGauche, PionsJ, PionsA, RBG),
																						  coupsLegauxFunc(X, basDroit, PionsJ, PionsA, RBD).

coupsLegauxFunc(Case, Direction, PionsJ, PionsA, R):- coupLegauxFirstStep(Case, Direction, PionsJ, PionsA, R),!.

coupLegauxFirstStep(Case, Direction, PionsJ, PionsA, -1):- 
	getVoisin(Case, Direction, CaseVoisine), not(isCase(CaseVoisine)),!.
coupLegauxFirstStep(Case, Direction, PionsJ, PionsA, -1):- 
	getVoisin(Case, Direction, CaseVoisine), isCase(CaseVoisine), not(member(CaseVoisine, PionsA)),!.
coupLegauxFirstStep(Case, Direction, PionsJ, PionsA, R):- 
	getVoisin(Case, Direction, CaseVoisine), isCase(CaseVoisine), member(CaseVoisine, PionsA), coupsLegauxSecondStep(Case, CaseVoisine, Direction, PionsJ, PionsA, R).
coupsLegauxSecondStep(_,0,_,_,_,_,_):-!.
coupsLegauxSecondStep(Case, CaseExp, Direction, PionsJ, PionsA, CaseVoisine):- getVoisin(CaseExp, Direction, CaseVoisine), isCase(CaseVoisine), vide(CaseVoisine, PionsJ, PionsA),!.
coupsLegauxSecondStep(Case, CaseExp, Direction, PionsJ, PionsA, R):- getVoisin(CaseExp, Direction, CaseVoisine), isCase(CaseVoisine),member(CaseVoisine, PionsA), coupsLegauxSecondStep(Case, CaseVoisine, Direction, PionsJ, PionsA, R).

																		   
addElem(X, L, [X|L]).


/*
=coups_legaux(N, Case, P, PA, T, A, TR, R) :-	case_voisine(N, Case, _, NCase),
							not(member(NCase, T)), !,
							jetons_retournes(N, NCase, P, PA, [], [], R1),
							(not_empty(R1)->
								coups_legaux(N, Case, P, PA, [NCase|T], [[NCase,R1]|A], TR, R);
								coups_legaux(N, Case, P, PA, [NCase|T], A, TR, R)).
coups_legaux(_, _, _, _, T, A, T, A).
*/