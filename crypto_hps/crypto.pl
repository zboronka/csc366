% FILE:  crypto.pl of crypto_hps
% TYPE:  Prolog source
% LINE:  The heuristic crypto problem solver
% DATE:  2019

% -----------------------------------------------------------------
% LOAD FILES

:- consult('../crypto_rpg/crypto').
:- consult('../combinatorial_sets/combinatorial_sets').
:- consult('../lp/lp').

% -----------------------------------------------------------------
% SOME SIMPLE "LOWER LEVEL" RECOGNITION UTILITIES

same(A,A).

adjacent(A,B) :- A is B+1.
adjacent(A,B) :- A is B-1.

% -----------------------------------------------------------------
% SOME SIMPLE "LOWER LEVEL" ACTION UTILITIES

multiply([A,B],ex(A,*,B)).
multiply([H|T],ex(H,*,R)) :- multiply(T,R).

subtract([A,B],ex(A,-,B)).
subtract([H|T],ex(H,-,R)) :- subtract(T,R).

addition([A,B],ex(A,+,B)).
addition([H|T],ex(H,+,R)) :- addition(T,R).

% -----------------------------------------------------------------
% SOME "HIGHER LEVEL" CRYPTO PROBLEM SOLVING PREDICATES

goal_is_zero :-
	value_of(problem,problem(_,goal(0))).

goal_is_nonzero :-
	value_of(problem,problem(_,goal(G))),
	G \= 0.

zero_in_numbers :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),_)),
	contains([N1,N2,N3,N4,N5],0).

goal_in_numbers :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	contains([N1,N2,N3,N4,N5],G).

pair_in_numbers :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),_)),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),_),
	same(A,B).

pair_in_numbers(value(V),rest(C,D,E)) :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),_)),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),extras(C,D,E)),
	same(A,B), V=A.

pair_add_to_goal :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),_),
	G is A + B.

pair_add_to_goal(pair(A,B),rest(C,D,E)) :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),extras(C,D,E)),
	G is A + B.

pair_sub_to_goal :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),_),
	G is A - B.

pair_sub_to_goal :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),_),
	G is B - A.

pair_sub_to_goal(pair(A,B),rest(C,D,E)) :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),extras(C,D,E)),
	G is A - B.

pair_sub_to_goal(pair(B,A),rest(C,D,E)) :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),goal(G))),
	comb(set(N1,N2,N3,N4,N5),comb(A,B),extras(C,D,E)),
	G is B - A.

pair_in_rest(set(A,B,C)) :-
	comb(set(A,B,C),comb(D,E),_),
	same(D,E).

pair_in_rest(set(A,B,C,D)) :-
	comb(set(A,B,C,D),comb(E,F),_),
	same(E,F).

pair_in_rest(set(A,B,C),value(E),rest(D)) :-
	comb(set(A,B,C),comb(E,F),extras(D)),
	same(E,F).

pair_in_rest(set(A,B,C,D),value(E),rest(G,H)) :-
	comb(set(A,B,C,D),comb(E,F),extras(G,H)),
	same(E,F).

numbers(N1,N2,N3,N4,N5) :-
	value_of(problem,problem(numbers(N1,N2,N3,N4,N5),_)).

goal(G) :-
	value_of(problem,problem(_,goal(G))).

numbers_other_than(these(A1,A2),those(B1,B2,B3)) :-
	numbers(N1,N2,N3,N4,N5),
	remove_elements([A1,A2],[N1,N2,N3,N4,N5],[B1,B2,B3]).

numbers_other_than(these(A),those(B1,B2,B3,B4)) :-
	numbers(N1,N2,N3,N4,N5),
	remove(A,[N1,N2,N3,N4,N5],[B1,B2,B3,B4]).

% -----------------------------------------------------------------
% MORE LIST PROCESSORS

remove_elements([],List,List).
remove_elements([H|T],List,Reduced_List) :-
	member(H,List),
	remove(H,List,Partial_List),
	remove_elements(T,Partial_List,Reduced_List).
remove_elements([_|T],List,Reduced_List) :-
	remove_elements(T,List,Reduced_List).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 1

situation1 :-
	goal_is_zero,
	zero_in_numbers.

action1 :-
	numbers(N1,N2,N3,N4,N5),
	multiply([N1,N2,N3,N4,N5],Expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 2

situation2 :-
	goal_is_zero,
	pair_in_numbers.

action2 :-
	pair_in_numbers(value(V),rest(C,D,E)),
	subtract([V,V],X1),
	multiply([0,C,D,E],X2),
	substitute(X1,0,X2,Expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 3

situation3 :-
	goal_is_nonzero,
	goal_in_numbers,
	zero_in_numbers.

action3 :-
	goal(G),
	numbers_other_than(these(0,G),those(A,B,C)),
	multiply([0,A,B,C],Zero_valued_expression),
	Expression = ex(G,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 4

situation4 :-
	pair_add_to_goal(_,rest(C,D,E)),
	contains([C,D,E],0).

action4 :-
	pair_add_to_goal(pair(A,B),rest(C,D,E)),
	addition([A,B],X1),
	multiply([C,D,E],Zero_valued_expression),
	Expression = ex(X1,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 5

situation5 :-
	pair_sub_to_goal(_,rest(C,D,E)),
	contains([C,D,E],0).

action5 :-
	pair_sub_to_goal(pair(A,B),rest(C,D,E)),
	subtract([A,B],X1),
	multiply([C,D,E],Zero_valued_expression),
	Expression = ex(X1,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 6

situation6 :-
	pair_add_to_goal(_,rest(C,D,E)),
	pair_in_rest(set(C,D,E)).

action6 :-
	pair_add_to_goal(pair(A,B),rest(C,D,E)),
	addition([A,B],X1),
	pair_in_rest(set(C,D,E),value(V),rest(F)),
	subtract([V,V],X2),
	multiply([X2,F],Zero_valued_expression),
	Expression = ex(X1,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 7

situation7 :-
	pair_sub_to_goal(_,rest(C,D,E)),
	pair_in_rest(set(C,D,E)).

action7 :-
	pair_sub_to_goal(pair(A,B),rest(C,D,E)),
	subtract([A,B],X1),
	pair_in_rest(set(C,D,E),value(V),rest(F)),
	subtract([V,V],X2),
	multiply([X2,F],Zero_valued_expression),
	Expression = ex(X1,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------
% CRYPTO HEURISTIC 7

situation8 :-
	goal_in_numbers,
	goal(G),
	numbers_other_than(these(G),those(B1,B2,B3,B4)),
	pair_in_rest(set(B1,B2,B3,B4)).

action8 :-
	goal(G),
	numbers_other_than(these(G),those(B1,B2,B3,B4)),
	pair_in_rest(set(B1,B2,B3,B4),value(V),rest(C1,C2)),
	subtract([V,V],X1),
	multiply([X1,C1,C2],Zero_valued_expression),
	Expression = ex(G,+,Zero_valued_expression),
	add_solution_to_KB(Expression).

% -----------------------------------------------------------------

% THE RULE BASE

rule(1,situation1,action1).
rule(2,situation2,action2).
rule(3,situation3,action3).
rule(4,situation4,action4).
rule(5,situation5,action5).
rule(6,situation6,action6).
rule(7,situation7,action7).
rule(8,situation8,action8).

% -----------------------------------------------------------------
% SOLVE AN INTERNALIZED PROBLEM (IT MAY HAVE BEEN RANDOMLY
% GENERATED OR SPECIFICALLY ESTABLISHED) HEURISTICALLY,
% PLACING ITS SOLUTION IN THE KB.

solve_problem_heuristically :-
	rule(Number,Situation,Action),
	write('considering rule '),write(Number),write(' ...'),nl,
	Situation,
	write('application of rule '),write(Number),
	Action.
solve_problem_heuristically :-
	add_solution_to_KB(none).

add_solution_to_KB(Expression) :-
	undeclare(solution),
	declare(solution,solution(Expression)).
add_solution_to_KB(Expression) :-
	declare(solution,solution(Expression)).

% -----------------------------------------------------------------
% DISPLAY THE SOLUTION -- ASSUMING THAT THE PROBLEM HAS BEEN SOLVED

display_solution :-
	value_of(solution,solution(none)),
	write('NO SOLUTION found with this rule base.'),nl.
display_solution :-
	value_of(solution,solution(Expression)),
	write(' produces solution: '),display_result(Expression),nl.
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
	write('( '),display_result(ex(A1,O1,B1)),write(' '),write(O),write(' '),
	display_result(ex(A2,O2,B2)),write(' )').

% -----------------------------------------------------------------
% SUBSTITUTION CODE

substitute(New,Old,ex(Old,O,Z),ex(New,O,Z)).
substitute(New,Old,ex(X,O,Old),ex(X,O,New)).
substitute(New,Old,ex(X,O,Z),ex(Y,O,Z)) :-
	substitute(New,Old,X,Y).
substitute(New,Old,ex(X,O,Y),ex(X,O,Z)) :-
	substitute(New,Old,Y,Z).

% -----------------------------------------------------------------
% CRYPTO PROBLEM SOLVER -- SOLVE A RANDOM PROBLEM

solve_one :-
	generate_random_crypto_problem,
	display_problem,
	solve_problem_heuristically,
	display_solution.

% -----------------------------------------------------------------
% CRYPTO PROBLEM SOLVER -- SOLVE A SPECIFIC PROBLEM

solve(problem(numbers(N1,N2,N3,N4,N5),goal(G))) :-
	add_crypto_problem_to_KB(N1,N2,N3,N4,N5,G), % from crypto.pl of crypto_rpg
	display_problem,
	solve_problem_heuristically,
	display_solution.

% -----------------------------------------------------------------
% RANDOM CRYPTO PROBLEM SOLVING

demo(1) :-
	solve_one.
demo(N) :-
	demo(1),
	M is N-1,
	demo(M).
