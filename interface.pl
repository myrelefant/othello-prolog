testJeuFinVictoireRond :- afficheJeu(rond, [], croix, [], [], []).
testJeuFinMatchNull :- afficheJeu(rond, [32,42, 51], croix, [], [32], [33]).

testJeuDebut :- 
		ListeRond = 
		[	
			44, 55
		],

		ListeCroix = 
		[	
			45, 54
		], 
		afficheJeu(rond, [34, 43, 56, 65], ListeCroix, ListeRond). 

testJeuMilieu :- 
		
		ListeCroix = 
		[	
			44, 55,43, 46, 45
		],

		ListeRond = 
		[	
			54
		], 
		afficheJeu(croix, [53, 63, 64, 65], ListeCroix, ListeRond).


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

vide(X, PionsJ, PionsA):- not(member(X, PionsJ)), not(member(X, PionsA)).

clearConsole :- write('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n').
afficheTour(J) :- write('Tour: '), write(J).
afficheCasePossible(L) :- write('\nCases Possibles: ') , write(L).
afficheVainqueur(J) :- write('\nVainqueur: '), write(J).
afficheChoixCase :- write('\n\nQuelle case choisissez vous?').
afficheChoixCaseError :- write('\n\n Impossible, choisissez une autre: ').


afficheJeu(_, [],_, _) :- clearConsole, afficheVainqueur(match_null), !.
afficheJeu(Tour, ListeCasePossible, ListeCroix, ListeRond):- clearConsole,afficheTour(Tour), afficheCasePossible(ListeCasePossible), afficheVainqueur(inconnu), afficherGrille(11, ListeCroix, ListeRond), afficheChoixCase.

afficherGrille(X, _,_):- X > 88,!.
afficherGrille(X, ListeCroix, ListeRond):- vide(X, ListeRond, ListeCroix), afficheCase(X, vide), findNextCase(X, Z), afficherGrille(Z, ListeCroix, ListeRond),!.
afficherGrille(X, ListeCroix, ListeRond):- member(X,ListeCroix), afficheCase(X, croix), findNextCase(X, Z), afficherGrille(Z, ListeCroix, ListeRond),!.
afficherGrille(X, ListeCroix, ListeRond):- member(X,ListeRond), afficheCase(X, rond), findNextCase(X, Z), afficherGrille(Z, ListeCroix, ListeRond),!.
afficherGrille(X, ListeCroix, ListeRond).

%Fonctions permettant dafficher une case. Plusieurs critères sont à prendre en compte:
%Si X-1 mod 10 == 0, on est sur la première case, il faut donc passer à la ligne avant d'afficher'.
%Prise en compte du type afin d'afficher' l'intérieur' des colonnes.
%Type possible: vide, croix, rond.

afficheCase(X,Type) :- Type == vide,retourLigne(X), write('| |'), !.
afficheCase(X,Type) :- Type == croix, retourLigne(X), write('|x|'),!.
afficheCase(X,Type) :- Type == rond, retourLigne(X), write('|o|'),!.


retourLigne(X) :- eval(X-1, Res) , eval(Res mod 10, Res2), Res2=0, write('\n'), !.
retourLigne(_).


%Fonction permettant de trouver la prochaine case à afficher et quand il n a plus de prochaine case, on arrête la recherche.

findNextCase(X, Z):- eval(X-8, Compare), eval(Compare mod 10, Compare2), Compare2 \==0, Z is X+1,!.
findNextCase(X, Z):- Z is X+3.

eval(Expr,Res):-Res is Expr.