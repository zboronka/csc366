% Implementation of global variable ADT

% Essential functionality
declare(Variable, Value) :-
	assert(binding(Variable, Value)).

display_bindings :-
	binding(Variable, Value),
	write(Variable), write(' -> '), write(Value), nl,
	fail.
display_bindings.

value_of(Variable, Value) :-
	binding(Variable, Value).

bind(Variable, Value) :-
	retract(binding(Variable,_)),
	assert(binding(Variable, Value)).

undeclare(Variable) :-
	retract(binding(Variable,_)).

% Arithmetic operators
inc(Variable) :-
	value_of(Variable, X),
	INC is X + 1,
	bind(Variable, INC).

dec(Variable) :-
	value_of(Variable, X),
	DEC is X - 1,
	bind(Variable, DEC).

add(Variable, X) :-
	value_of(Variable, V),
	VPX is V + X,
	bind(Variable, VPX).

sub(Variable, X) :-
	value_of(Variable, V),
	VMX is V - X,
	bind(Variable, VMX).

% Quality of life rules
exit :- halt.
quit :- halt.
