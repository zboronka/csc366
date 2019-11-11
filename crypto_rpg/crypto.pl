:- consult("../gv/gv").

:- declare(lo, 0).
:- declare(hi, 9).

generate_random_number(R) :-
	value_of(hi, Hi),
	value_of(lo, Lo),
	HiP1 is Hi + 1,
	random(Lo, HiP1, R).

generate_random_crypto_problem :-
	undeclare(problem), fail.
generate_random_crypto_problem :-
	generate_random_number(N1),
	generate_random_number(N2),
	generate_random_number(N3),
	generate_random_number(N4),
	generate_random_number(N5),
	generate_random_number(G),
	declare(problem, problem(numbers(N1,N2,N3,N4,N5),goal(G))).

display_problem :-
	value_of(problem, problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	write('numbers = {'),write(N1),write(','),write(N2),write(','),write(N3),write(','),write(N4),write(','),write(N5),write('} and goal = '),write(G),nl.

display_problems(1) :-
	generate_random_crypto_problem,
	display_problem, !.
display_problems(N) :-
	display_problems(1),
	NM1 is N - 1,
	display_problems(NM1).

add_crypto_problem_to_KB(_,_,_,_,_,_) :-
	undeclare(problem), fail.
add_crypto_problem_to_KB(N1,N2,N3,N4,N5,G) :-
	declare(problem, problem(numbers(N1,N2,N3,N4,N5),goal(G))).
