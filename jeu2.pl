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

*/