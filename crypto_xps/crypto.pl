% -----------------------------------------------------------------
% FILE:  crypto.pl of crypto_xps
% TYPE:  Prolog source
% LINE:  The exhaustive crypto problem generator/solver/displayer
% DATE:  2019

% -----------------------------------------------------------------
% LOAD FILES

:- consult('../crypto_rpg/crypto').
:- consult(crypto_2345_short).

% -----------------------------------------------------------------
% SOLVE AN INTERNALIZED PROBLEM (IT MAY HAVE BEEN RANDOMLY
% GENERATED OR SPECIFICALLY ESTABLISHED) DECOMPOSITIONALLY,
% PLACING ITS SOLUTION IN THE KB.

solve_problem_decompositionally :-
	value_of(crypto_problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	crypto(N1,N2,N3,N4,N5,G,Expression),
	add_solution_to_KB(Expression).
solve_problem_decompositionally :-
	add_solution_to_KB(none).

% ------------------------------------------------------------------
% DISPLAY THE SOLUTION -- ASSUMING THAT THE PROBLEM HAS BEEN SOLVED

add_solution_to_KB(Expression) :-
	undeclare(solution),
	declare(solution,solution(Expression)).
add_solution_to_KB(Expression) :-
	declare(solution,solution(Expression)).

display_solution :-
	value_of(solution,solution(none)),
	write('No solution to this problem.'),nl.
display_solution :-
	value_of(solution,solution(Expression)),
	write('Solution: '), display_result(Expression),nl.
display_solution.

display_result(ex(A,O,B)) :-
	number(A),number(B),
	write('( '),write(A),write(' '),write(O),write(' '),write(B),write(' )').
display_result(ex(A,O,B)) :-
	number(A), B = ex(A1,O1,B1),
	write('( '),write(A),write(' '),write(O),write(' '),
	display_result(ex(A1,O1,B1)),write(' )').
display_result(ex(A,O,B)) :-
	number(B), A = ex(A1,O1,B1),
	write('( '),display_result(ex(A1,O1,B1)),write(' '),write(O),write(' '),
	write(B),write(' )').
display_result(ex(A,O,B)) :-
	A = ex(A1,O1,B1), B = ex(A2,O2,B2),
	write('( '), display_result(ex(A1,O1,B1)),write(' '),write(O),write(' '),
	display_result(ex(A2,O2,B2)),write(' )').

% ------------------------------------------------------------------
% CRYPTO PROBLEM SOLVER -- SOLVE A RANDOM PROBLEM

solve_one :-
	generate_random_crypto_problem,
	display_problem,
	solve_problem_decompositionally,
	display_solution.

% ------------------------------------------------------------------
% CRYPTO PROBLEM SOLVER -- SOLVE A SPECIFIC PROBLEM

solve(problem(numbers(N1,N2,N3,N4,N5),goal(G))) :-
	add_crypto_problem_to_KB(N1,N2,N3,N4,N5,G),
	display_problem,
	solve_problem_decompositionally,
	display_solution.

% ------------------------------------------------------------------
% RANDOM CRYPTO PROBLEM SOLVING

demo(1) :-
	solve_one.
demo(N) :-
	demo(1),
	M is N-1,
	demo(M).
