%% file:  proglang2.pro
%% line:  some knowledge about programming languages

% language(L) means L is a programming language

language(smalltalk).
language(lisp).
language(prolog).
language(snobol).
language(apl).

% essence(L,DT,CF) means language L features datatype DT
% and computational formalism CF

essence(smalltalk, objects, 'message passing').
essence(lisp, lists, 'recursive functions').
essence(prolog, relations, 'logical inferencing').
essence(snobol, pattern, 'string processing').
essence(apl, matrix, 'matrix operations').

% history(L,I,D) means language L was invented by I in year D

history(smalltalk, inventor('Alan Kay'), date(1980)).
history(lisp, inventor('John McCarthy'), date(1959)).
history(prolog, inventor('Alan Colmeraur'), date(1971)).
history(snobol, inventor('Ralph Griswold'), date(1962)).
history(apl, inventor('Kenneth Iverson'), date(1964)).
