perm(s(A,B),p(A,B)).
perm(s(A,B),p(B,A)).

perm(s(A,B,C),p(A,X,Y)) :- perm(s(B,C),p(X,Y)).
perm(s(A,B,C),p(B,X,Y)) :- perm(s(A,C),p(X,Y)).
perm(s(A,B,C),p(C,X,Y)) :- perm(s(A,B),p(X,Y)).

perm(s(A,B,C,D),p(A,X,Y,Z)) :- perm(s(B,C,D),p(X,Y,Z)).
perm(s(A,B,C,D),p(B,X,Y,Z)) :- perm(s(A,C,D),p(X,Y,Z)).
perm(s(A,B,C,D),p(C,X,Y,Z)) :- perm(s(A,B,D),p(X,Y,Z)).
perm(s(A,B,C,D),p(A,X,Y,Z)) :- perm(s(B,C,D),p(X,Y,Z)).

perm(s(A,B,C,D,E),p(A,X,Y,Z,W)) :- perm(s(B,C,D,E),p(X,Y,Z,W)).
perm(s(A,B,C,D,E),p(B,X,Y,Z,W)) :- perm(s(A,C,D,E),p(X,Y,Z,W)).
perm(s(A,B,C,D,E),p(C,X,Y,Z,W)) :- perm(s(B,A,D,E),p(X,Y,Z,W)).
perm(s(A,B,C,D,E),p(D,X,Y,Z,W)) :- perm(s(B,C,A,E),p(X,Y,Z,W)).
perm(s(A,B,C,D,E),p(E,X,Y,Z,W)) :- perm(s(B,C,D,A),p(X,Y,Z,W)).

permutations(A,B) :-
	perm(s(A,B),p(V,W)),
	write(V),write(W),write(' '),
	fail.
permutations(_,_).

permutations(A,B,C) :-
	perm(s(A,B,C),p(V,W,X)),
	write(V),write(W),write(X),write(' '),
	fail.
permutations(_,_,_).

permutations(A,B,C,D) :-
	perm(s(A,B,C,D),p(V,W,X,Y)),
	write(V),write(W),write(X),write(Y),write(' '),
	fail.
permutations(_,_,_,_).

permutations(A,B,C,D,E) :-
	perm(s(A,B,C,D,E),p(V,W,X,Y,Z)),
	write(V),write(W),write(X),write(Y),write(Z),write(' '),
	fail.
permutations(_,_,_,_,_).

comb(set(N1,N2,N3),comb(N1,N2),extras(N3)).
comb(set(N1,N2,N3),comb(N1,N3),extras(N2)).
comb(set(N1,N2,N3),comb(N2,N3),extras(N1)).

comb(set(N1,N2,N3,N4),comb(N1,N2),extras(N3,N4)).
comb(set(N1,N2,N3,N4),comb(N1,N3),extras(N2,N4)).
comb(set(N1,N2,N3,N4),comb(N1,N4),extras(N2,N3)).
comb(set(N1,N2,N3,N4),comb(N2,N3),extras(N1,N4)).
comb(set(N1,N2,N3,N4),comb(N2,N4),extras(N1,N3)).
comb(set(N1,N2,N3,N4),comb(N3,N4),extras(N1,N2)).

comb(set(N1,N2,N3,N4,N5),comb(N1,N2),extras(N3,N4,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N1,N3),extras(N2,N4,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N1,N4),extras(N2,N3,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N1,N5),extras(N2,N3,N4)).
comb(set(N1,N2,N3,N4,N5),comb(N2,N3),extras(N1,N4,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N2,N4),extras(N1,N3,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N2,N5),extras(N1,N3,N4)).
comb(set(N1,N2,N3,N4,N5),comb(N3,N4),extras(N1,N2,N5)).
comb(set(N1,N2,N3,N4,N5),comb(N3,N5),extras(N1,N2,N4)).
comb(set(N1,N2,N3,N4,N5),comb(N4,N5),extras(N1,N2,N3)).

combinations(A,B,C) :-
	comb(set(A,B,C),comb(X,Y),extras(_)),
	write(X),write(Y),write(' '),
	fail.
combinations(_,_,_).

combinations(A,B,C,D) :-
	comb(set(A,B,C,D),comb(X,Y),extras(_,_)),
	write(X),write(Y),write(' '),
	fail.
combinations(_,_,_,_).

combinations(A,B,C,D,E) :-
	comb(set(A,B,C,D,E),comb(X,Y),extras(_,_,_)),
	write(X),write(Y),write(' '),
	fail.
combinations(_,_,_,_,_).
