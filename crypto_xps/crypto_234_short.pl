:- consult('../combinatorial_sets/combinatorial_sets').
:- consult(crypto_testers).

crypto(N1,N2,Goal,ex(N1,+,N2)) :- Goal is ( N1 + N2 ).
crypto(N1,N2,Goal,ex(N1,*,N2)) :- Goal is ( N1 * N2 ).
crypto(N1,N2,Goal,ex(N1,-,N2)) :- Goal is ( N1 - N2 ).
crypto(N1,N2,Goal,ex(N2,-,N1)) :- Goal is ( N2 - N1 ).
crypto(N1,N2,Goal,ex(N1,/,N2)) :- nonzero(N2), Goal is ( N1 / N2 ).
crypto(N1,N2,Goal,ex(N2,/,N1)) :- nonzero(N1), Goal is ( N2 / N1 ).

nonzero(N) :- N > 0.
nonzero(N) :- N < 0.

crypto(N1,N2,N3,G,Expr) :-
	comb(set(N1,N2,N3),comb(A,B),extras(C)),
	crypto(A,B,SG,SGE),
	crypto(C,SG,G,UGE),
	substitute(SGE,SG,UGE,Expr).

crypto(N1,N2,N3,N4,G,Expr) :-
	comb(set(N1,N2,N3,N4),comb(A,B),extras(C,D)),
	crypto(A,B,SG,SGE),
	crypto(C,D,SG,G,UGE),
	substitute(SGE,SG,UGE,Expr).

substitute(New,Old,ex(Old,O,Z),ex(New,O,Z)).
substitute(New,Old,ex(X,O,Old),ex(X,O,New)).
substitute(New,Old,ex(X,O,Z),ex(Y,O,Z)) :-
	substitute(New,Old,X,Y).
substitute(New,Old,ex(X,O,Z),ex(X,O,Y)) :-
	substitute(New,Old,Z,Y).
