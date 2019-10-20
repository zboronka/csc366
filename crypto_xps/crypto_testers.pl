test2(0).
test2(N) :-
	demo2,
	NM1 is N-1,
	test2(NM1).

demo2 :-
	generate2(N1,N2,G),
	display2(N1,N2,G),
	solve2(N1,N2,G).

generate2(N1,N2,G) :-
	random(0,6,N1),
	random(0,6,N2),
	random(0,6,G).

display2(N1,N2,G) :-
	write(problem(numbers(N1,N2),goal(G))), write(' --> ').

solve2(N1,N2,G) :-
	crypto(N1,N2,G,X),
	write(X),nl.
solve2(_,_,_) :-
	write('no solution'),nl.

test3(0).
test3(N) :-
	demo3,
	NM1 is N-1,
	test3(NM1).

demo3 :-
	generate3(N1,N2,N3,G),
	display3(N1,N2,N3,G),
	solve3(N1,N2,N3,G).

generate3(N1,N2,N3,G) :-
	random(0,6,N1),
	random(0,6,N2),
	random(0,6,N3),
	random(0,6,G).

display3(N1,N2,N3,G) :-
	write(problem(numbers(N1,N2,N3),goal(G))), write(' --> ').

solve3(N1,N2,N3,G) :-
	crypto(N1,N2,N3,G,X),
	write(X),nl.
solve3(_,_,_,_) :-
	write('no solution'),nl.

test4(0).
test4(N) :-
	demo4,
	NM1 is N-1,
	test4(NM1).

demo4 :-
	generate4(N1,N2,N3,N4,G),
	display4(N1,N2,N3,N4,G),
	solve4(N1,N2,N3,N4,G).

generate4(N1,N2,N3,N4,G) :-
	random(0,6,N1),
	random(0,6,N2),
	random(0,6,N3),
	random(0,6,N4),
	random(0,6,G).

display4(N1,N2,N3,N4,G) :-
	write(problem(numbers(N1,N2,N3,N4),goal(G))), write(' --> ').

solve4(N1,N2,N3,N4,G) :-
	crypto(N1,N2,N3,N4,G,X),
	write(X),nl.
solve4(_,_,_,_,_) :-
	write('no solution'),nl.

