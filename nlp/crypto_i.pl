:- consult(io).
:- consult('../crypto_xps/crypto').

sentence(Problem) --> simpleproblemcommand(Problem).
sentence(Problem) --> simpleproblemquery(Problem).
sentence(Problem) --> randomproblemcommand(Problem).
simpleproblemcommand(Problem) --> [use],numberzzz(Numbers),[to],[make],goal(Goal),[.],
	{Problem = problem(Numbers,goal(Goal))}.
simpleproblemcommand(Problem) --> [write],goal(Goal),[in],[terms],[of],numberzzz(Numbers),[.],
	{Problem = problem(Numbers,goal(Goal))}.
randomproblemcommand(Problem) --> [use],[whatever],[to],[make],[whatever],[.],
	{generate_random_crypto_problem, value_of(problem, Problem)}.
simpleproblemquery(Problem) --> [can],[you],[make],goal(Goal),separator,numberzzz(Numbers),[?],
	{Problem = problem(Numbers,goal(Goal))}.
separator --> [from].
separator --> [with].
goal(Goal) --> number(Goal).
numberzzz(Numbers) --> number(N1),[and],number(N2),[and],number(N3),[and],number(N4),[and],number(N5),
	{Numbers = numbers(N1,N2,N3,N4,N5)}.
numberzzz(Numbers) --> number(N1),number(N2),number(N3),number(N4),[and],number(N5),
	{Numbers = numbers(N1,N2,N3,N4,N5)}.
numberzzz(Numbers) --> [the],[first],[five],[positive],[numbers],
	{Numbers = numbers(1,2,3,4,5)}.
numberzzz(Numbers) --> [numbers],[zero],[through],[four],
	{Numbers = numbers(0,1,2,3,4)}.
numberzzz(Numbers) --> [numbers],[one],[through],[five],
	{Numbers = numbers(1,2,3,4,5)}.
numberzzz(Numbers) --> [numbers],[two],[through],[six],
	{Numbers = numbers(2,3,4,5,6)}.
numberzzz(Numbers) --> [numbers],[three],[through],[seven],
	{Numbers = numbers(3,4,5,6,7)}.
numberzzz(Numbers) --> [numbers],[four],[through],[eight],
	{Numbers = numbers(4,5,6,7,8)}.
numberzzz(Numbers) --> [numbers],[five],[through],[nine],
	{Numbers = numbers(5,6,7,8,9)}.
numberzzz(Numbers) --> [the],[odd],[numbers],
	{Numbers = numbers(1,3,5,7,9)}.
numberzzz(Numbers) --> [five],pluralnumber(Number),
	{Numbers = numbers(Number,Number,Number,Number,Number)}.
numberzzz(Numbers) --> [four],pluralnumber(N1),[and],[one],number(N2),
	{Numbers = numbers(N1,N1,N1,N1,N2)}.
numberzzz(Numbers) --> [one],number(N1),[and],[four],pluralnumber(N2),
	{Numbers = numbers(N1,N2,N2,N2,N2)}.
numberzzz(Numbers) --> [two],pluralnumber(N1),[and],[three],pluralnumber(N2),
	{Numbers = numbers(N1,N1,N2,N2,N2)}.
numberzzz(Numbers) --> [three],pluralnumber(N1),[and],[two],pluralnumber(N2),
	{Numbers = numbers(N1,N1,N1,N2,N2)}.
numberzzz(Numbers) --> [two],pluralnumber(N1),[and],[two],pluralnumber(N2),[and],[one],number(N3),
	{Numbers = numbers(N1,N1,N2,N2,N3)}.
numberzzz(Numbers) --> [one],number(N1),[and],[two],pluralnumber(N2),[and],[two],pluralnumber(N3),
	{Numbers = numbers(N1,N2,N2,N3,N3)}.
numberzzz(Numbers) --> [two],pluralnumber(N1),[and],[one],number(N2),[and],[two],pluralnumber(N3),
	{Numbers = numbers(N1,N1,N2,N3,N3)}.
number(0) --> [zero].
number(1) --> [one].
number(2) --> [two].
number(3) --> [three].
number(4) --> [four].
number(5) --> [five].
number(6) --> [six].
number(7) --> [seven].
number(8) --> [eight].
number(9) --> [nine].
pluralnumber(0) --> [zeros].
pluralnumber(1) --> [ones].
pluralnumber(2) --> [twos].
pluralnumber(3) --> [threes].
pluralnumber(4) --> [fours].
pluralnumber(5) --> [fives].
pluralnumber(6) --> [sixes].
pluralnumber(7) --> [sevens].
pluralnumber(8) --> [eights].
pluralnumber(9) --> [nines].

% The parser
% ------------------------------------------------------------------------------------

parser :-
	read_sentence(S),
	sentence(Problem,S,[]),
	write(Problem),nl,
	parser.
parser :-
	write('Not a sentence ...'),nl,
	parser.

% The interpreter
% ------------------------------------------------------------------------------------

interpreter :-
	read_sentence(S),
	sentence(Problem,S,[]),
	solve_without_echo(Problem),
	interpreter.
interpreter :-
	write('Not a sentence ...'),nl,
	interpreter.

% Solve a specific problem without the echo
% ------------------------------------------------------------------------------------

solve_without_echo(problem(numbers(N1,N2,N3,N4,N5),goal(G))) :-
	add_crypto_problem_to_KB(N1,N2,N3,N4,N5,G),
	solve_problem_decompositionally,
	display_solution.
