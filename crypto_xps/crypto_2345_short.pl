:- consult(crypto_234_short).

crypto(N1,N2,N3,N4,N5,G,Expr) :-
	comb(set(N1,N2,N3,N4,N5),comb(A,B),extras(C,D,E)),
	crypto(A,B,SG,SGE),
	crypto(C,D,E,SG,G,UGE),
	substitute(SGE,SG,UGE,Expr).
