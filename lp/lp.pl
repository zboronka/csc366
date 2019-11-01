% FILE:  lp.pl
% TYPE:  Prolog source
% Line:  Some useful list processing predicates
% Date:  Fall 2019

% first ------------------------------------------------------------------
% Just for fun. Nobody would use this.
% ------------------------------------------------------------------------

first([H|_],H).

% rest -------------------------------------------------------------------
% Just for fun. Nobody would use this.
% ------------------------------------------------------------------------

rest([_|T],T).

% last_element (last)-----------------------------------------------------
% This alternate take suggests why nobody would use first and rest:
%   last_element(List,Last) :- rest(List,[]), first(List,Last).
%   last_element(List,Last) :- rest(List,Rest), last_element(Rest,Last).
% ------------------------------------------------------------------------

last_element([H|[]],H).
last_element([_|T],Result) :- last_element(T,Result).

% write_list -------------------------------------------------------------

write_list([]).
write_list([H|T]) :- write(H), nl, write_list(T).

% writelistrev -----------------------------------------------------------

write_list_reversed([]).
write_list_reversed([H|T]) :- write_list_reversed(T), write(H), nl.

% size (length) ----------------------------------------------------------

size([],0).
size([_|T],L) :- size(T,K), L is (1+K).

% count(Element,List,Count) ----------------------------------------------

count(_,[],0).
count(Element,[Element|Rest],Count) :-
	count(Element,Rest,RestCount),
	Count is RestCount + 1.
count(Element,[_|Rest],Count) :-
	count(Element,Rest,Count).

% element_of(member) -----------------------------------------------------

element_of(X,[X|_]).
element_of(X,[_|T]) :- element_of(X,T).

% contains ---------------------------------------------------------------

contains([X|_],X).
contains([_|T],X) :- contains(T,X).

% nth --------------------------------------------------------------------

nth(0,[H|_],H).
nth(N,[_|T],E) :- K is N - 1, nth(K,T,E).

% pick -------------------------------------------------------------------

pick(L,Item) :-
	length(L,Length),
	random(0,Length,RN),
	nth(RN,L,Item).

% sum --------------------------------------------------------------------

sum([],0).
sum([Head|Tail],Sum) :-
	sum(Tail,SumOfTail),
	Sum is Head + SumOfTail.

% makelist ---------------------------------------------------------------

make_list(0,_,[]).
make_list(Length,Element,[Element|Rest]) :-
	K is Length - 1,
	make_list(K,Element,Rest).

% iota -------------------------------------------------------------------

iota(0,[]).
iota(N,IotaN) :-
	K is N - 1,
	iota(K,IotaK),
	add_last(N,IotaK,IotaN).

% add_first --------------------------------------------------------------

add_first(X,L,[X|L]).

% add_last ---------------------------------------------------------------

add_last(X,[],[X]).
add_last(X,[H|T],[H|TX]) :- add_last(X,T,TX).

% esrever(reverse) -------------------------------------------------------

esrever([],[]).
esrever([H|T],R) :-
	esrever(T,Rev),add_last(H,Rev,R).

% join_lists (append) ----------------------------------------------------
% Note that append is defined only for three arguments.
% ------------------------------------------------------------------------

join_lists([],L,L).
join_lists([H|T1],L2,[H|T3]) :- join_lists(T1,L2,T3).

join_lists(L1,L2,L3,Result) :-
	join_lists(L1,L2,L12),join_lists(L12,L3,Result).

join_lists(L1,L2,L3,L4,Result) :-
	join_lists(L1,L2,L3,L123),join_lists(L123,L4,Result).

% product ----------------------------------------------------------------

product([],1).
product([Head|Tail],Product) :-
	product(Tail,ProductOfTail),
	Product is Head * ProductOfTail.

% factorial --------------------------------------------------------------

factorial(N,Nfactorial) :-
	iota(N,IotaN),
	product(IotaN,Nfactorial).

% make_set ---------------------------------------------------------------

make_set([],[]).
make_set([H|T],TS) :-
	member(H,T),
	make_set(T,TS).
make_set([H|T],[H|TS]) :-
	make_set(T,TS).

% replace ----------------------------------------------------------------

replace(0,Object,[_|T],[Object|T]).
replace(ListPosition,Object,[H|T1],[H|T2]) :-
	K is ListPosition - 1,
	replace(K,Object,T1,T2).

% remove -----------------------------------------------------------------

remove(_,[],[]).
remove(First,[First|Rest],Rest).
remove(Element,[First|Rest],[First|RestLessElement]) :-
	remove(Element,Rest,RestLessElement).

% take -------------------------------------------------------------------

take(List,Element,Rest) :-
	pick(List,Element),
	remove(Element,List,Rest).

% split ------------------------------------------------------------------

split([],[],[]).
split([[A,B]|T],[A|AA],[B|BB]) :-
	split(T,AA,BB).

% min_pair ---------------------------------------------------------------

min_pair(N1,N2,N1) :- N1 =< N2.
min_pair(N1,N2,N2) :- N2 =< N1.

% max_pair ---------------------------------------------------------------

max_pair(N1,N2,N1) :- N1 >= N2.
max_pair(N1,N2,N2) :- N2 >= N1.

% min --------------------------------------------------------------------
% min(NumericList,MinNumber) :: MinNumber is the smallest number in the
%   nonempty list NumericList
% ------------------------------------------------------------------------

min([MinNumber|[]], MinNumber).
min([H1|[H2|T]], MinNumber) :-
	min_pair(H1,H2,Min) , min([Min|T], MinNumber).

% max --------------------------------------------------------------------
% max(NumericList,MaxNumber) :: MaxNumber is the largest number in the
%   nonempty list NumericList
% ------------------------------------------------------------------------

max([MaxNumber|[]], MaxNumber).
max([H1|[H2|T]], MaxNumber) :-
	max_pair(H1,H2,Max) , max([Max|T], MaxNumber).

% sort_inc ---------------------------------------------------------------
% sort_inc(UnorderedNumericList,OrderedNumericList) :: the latter list is
%   the former list but ordered low to high
% ------------------------------------------------------------------------

sort_inc([],[]).
sort_inc(U,O) :-
	min(U,Min),remove(Min,U,Rest),
	sort_inc(Rest,Ord),add_first(Min,Ord,O),!.

% sort_dec ---------------------------------------------------------------
% sort_dec(UnorderedNumericList,OrderedNumericList) :: the latter list is
%   the former list but ordered high to low
% ------------------------------------------------------------------------

sort_dec([],[]).
sort_dec(U,O) :-
	max(U,Max),remove(Max,U,Rest),
	sort_dec(Rest,Ord),add_first(Max,Ord,O),!.

% a_list -----------------------------------------------------------------
% a_list(FirstList,SecondList,AssociationList) :: create an association
%   list from the two lists of equal length, the first considered to be 
%   keys, the second considered to be values, and the third the resulting
%   association list representing represented as pairs encapsulated into
%   terms with the name 'pair'
% ------------------------------------------------------------------------
% For example: a_list([one,two],[1,2],[pair(one,1),pair(two,2)])
% ------------------------------------------------------------------------

a_list([K|[]],[V|[]],[pair(K,V)]).
a_list([K|TK],[V|TV],KV) :-
	a_list(TK,TV,List),add_first(pair(K,V),List,KV).

% assoc ------------------------------------------------------------------
% assoc(AList,Key,Value) :: find the Value in the second slot 
%   corresponding to Key in the first slot of some pair of the association
%   list
% ------------------------------------------------------------------------

assoc([pair(K,V)|_],K,V).
assoc([_|T],K,V) :-
	assoc(T,K,V).
