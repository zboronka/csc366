%%%% File: dinnerware

%% Facts

% cutlery(N,soup(A)) :: N is the name of the cutlery and A is whether it can be used for soup
cutlery(knife,soup(no)).
cutlery(fork,soup(no)).
cutlery(spoon,soup(yes)).
cutlery(chopsticks,soup(yes)).

% dish(N,soup(A)) :: N is the name of the dish and A is whether it can be used for soup
dish(plate,soup(no)).
dish(bowl,soup(yes)).
dish(cup,soup(yes)).
dish(saucecup,soup(no)).

%% Rules

% soup :: all items that are cutlery
cutlery :- cutlery(Name,_),write(Name),nl,fail.
cutlery.

% dishes :: all items that are dishes
dishes :- dish(Name,_),write(Name),nl,fail.
dishes.

% dinnerware :: all items that are flatware
dinnerware :- cutlery,dishes.

% soupable(Name) :: Name can eat soup
soupable(Name) :- cutlery(Name,soup(yes)).
soupable(Name) :- dish(Name,soup(yes)).

% pair(C,D) :: C is a cutlery that can be paired with D to eat soup
pair(C,D) :- cutlery(C,soup(yes)),dish(D,soup(yes)).

% nsfs(C,D) :: Neither C or D are safe for eating soup with
nsfs(C,D) :- cutlery(C,soup(no)),dish(D,soup(no)).

% exit :: exits swipl with the correct command for exiting
exit :- halt.
