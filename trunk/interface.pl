testJeuFinVictoireRond :- afficheJeu(rond, [], croix, [], [], []).
testJeuFinMatchNull :- afficheJeu(rond, [32,42, 51], croix, [], [32], [33]).

testJeuDebut :- ListeVide = 
		[	
			11, 21, 31, 41, 51, 61, 71, 81,
		      	12, 22, 32, 42, 52, 62, 72, 82,
		      	13, 23, 33, 43, 53, 63, 73, 83,
		  	14, 24, 34,         64, 74, 84,
		  	15, 25, 35,         65, 75, 85,
		  	16, 26, 36, 46, 56, 66, 76, 86,
		 	17, 27, 37, 47, 57, 67, 77, 87,
		  	18, 28, 38, 48, 58, 68, 78, 88
		],
		
		ListeCroix = 
		[	
			44, 55
		],

		ListeRond = 
		[	
			45, 54
		], 
		afficheJeu(rond, [34, 43, 56, 65], croix, ListeVide, ListeCroix, ListeRond). 

testJeuMilieu :- ListeVide = 
		[	
			11, 21, 31, 41, 51, 61, 71, 81,
		      	12, 22, 32, 42, 52, 62, 72, 82,
		      	13, 23, 33,     53, 63, 73, 83,
		  	14, 24, 34,         64, 74, 84,
		  	15, 25, 35,         65, 75, 85,
		  	16, 26, 36,     56, 66, 76, 86,
		 	17, 27, 37, 47, 57, 67, 77, 87,
		  	18, 28, 38, 48, 58, 68, 78, 88
		],
		
		ListeCroix = 
		[	
			44, 55,43, 46, 45
		],

		ListeRond = 
		[	
			54
		], 
		afficheJeu(croix, [53, 63, 64, 65], rond, ListeVide, ListeCroix, ListeRond).


clearConsole :- write('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n').
afficheTour(J) :- write('Tour: '), write(J).
afficheCasePossible(L) :- write('\nCases Possibles: ') , write(L).
afficheVainqueur(J) :- write('\nVainqueur: '), write(J).
afficheChoixCase :- write('\n\nQuelle case choisissez vous?').
afficheChoixCaseError :- write('\n\n Impossible, choisissez une autre: ').


afficheJeu(_, _, _, [], _, _) :- clearConsole, afficheVainqueur(match_null), !.
afficheJeu(Tour, [],Vainqueur, _, _, _):- clearConsole, afficheVainqueur(Vainqueur),!.
afficheJeu(Tour, ListeCasePossible, _, ListeVide, ListeCroix, ListeRond):- clearConsole,afficheTour(Tour), afficheCasePossible(ListeCasePossible), afficheVainqueur(inconnu), afficherGrille(11, ListeVide, ListeCroix, ListeRond), afficheChoixCase.

afficherGrille(X, _,_,_):- X > 88,!.
afficherGrille(X, ListeVide, ListeCroix, ListeRond):- member(X,ListeVide), afficheCase(X, vide), findNextCase(X, Z), afficherGrille(Z, ListeVide, ListeCroix, ListeRond),!.
afficherGrille(X, ListeVide, ListeCroix, ListeRond):- member(X,ListeCroix), afficheCase(X, croix), findNextCase(X, Z), afficherGrille(Z, ListeVide, ListeCroix, ListeRond),!.
afficherGrille(X, ListeVide, ListeCroix, ListeRond):- member(X,ListeRond), afficheCase(X, rond), findNextCase(X, Z), afficherGrille(Z, ListeVide, ListeCroix, ListeRond),!.
afficherGrille(X, ListeVide, ListeCroix, ListeRond).

%Fonctions permettant dafficher une case. Plusieurs critères sont à prendre en compte:
%Si X-1 mod 10 == 0, on est sur la première case, il faut donc passer à la ligne avant d'afficher'.
%Prise en compte du type afin d'afficher' l'intérieur' des colonnes.
%Type possible: vide, croix, rond.

afficheCase(X,Type) :- Type == vide,retourLigne(X), write('| |'), !.
afficheCase(X,Type) :- Type == croix, retourLigne(X), write('|x|'),!.
afficheCase(X,Type) :- Type == rond, retourLigne(X), write('|o|'),!.


retourLigne(X) :- X < 20, write('\n'),!.
retourLigne(_).


%Fonction permettant de trouver la prochaine case à afficher et quand il n a plus de prochaine case, on arrête la recherche.

findNextCase(X, Z):- Compare = X-80, Compare<10, Compare > 0, Z is Compare+11,!.
findNextCase(X, Z):- Z is X+10.
