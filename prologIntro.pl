%%%%%%%%%%%%%%
% QUESTION 1 %
%%%%%%%%%%%%%%

% assume people's sex based on their name
woman(sue). woman(ida). woman(estelle). woman(grace). woman(mary).
man(peter). man(john1). man(rob). man(george). man(john2). man(jay).

% add facts about parenthood
parent(sue, rob). parent(sue, estelle).
parent(john1, rob). parent(john1, estelle).
parent(ida, george). parent(ida, grace).
parent(peter, george). parent(peter, grade).
parent(estelle, john2). parent(estelle, mary). parent(estelle, jay).
parent(george, john2). parent(george, mary). parent(george, jay).

% add facts about siblings, make it bi-directional
sibling(rob, estelle). sibling(estelle, rob).
sibling(george, grace). sibling(grace, george).
sibling(john2, mary). sibling(mary, john). sibling(john2, jay).
sibling(jay, john2). sibling(jay, mary). sibling(mary, jay).

% add facts about couples, make it bi-directional
lover(sue, john). lover(john, sue).
lover(ida, peter). lover(peter, ida).
lover(estelle, george). lover(george, estelle).

% create rules about grandparent, grandfather, brother, a_pair_of_brothers, mother_in_law, uncle, ancestor 
grandparent(X, Z) :- parent(X, Y), parent(Y, Z). % X is a grandparent of Z
grandfather(X, Z) :- man(X), grandparent(X, Z). % X is the grandfather of Z
brother(X, Y) :- sibling(X, Y), man(X). % X is a brother of Y
a_pair_of_brothers(X, Y) :- brother(X, Y), man(Y). % X and Y are both brothers
mother_in_law(X, Y) :- woman(X), lover(Y, Z), parent(X, Z). % X is a woman, Y loves Z, and X is Z's mother.
uncle(X, Y) :- brother(X, Z), parent(Z, Y). % X is the brother of Z, and Z is the parent of Y.
ancestor(X, Y) :- parent(X, Y). % base case -> X is a parent of Y
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y). % check if X is an ancestor of Y (recursively)


%%%%%%%%%%%%%%
% QUESTION 2 %
%%%%%%%%%%%%%%

% add cities
city(chicago). city(detroit). city(orlando).
city(newyork). city(losangeles).
city(toronto). city(vancouver).

% add first and second largest airport names in cities
airport(toronto, pearson). airport(toronto, billy_bishop).
airport(vancouver, abbotsford). airport(vancouver, vancouver_international).
airport(chicago, ohare). airport(chicago, midway).
airport(detroit, detroit_metropolitan). airport(detroit, bishop).
airport(orlando, orlando_international). airport(orlando, sanford).
airport(newyork, laguardia). airport(newyork, john_f_kennedy).
airport(losangeles, la_international). airport(losangeles, john_wayne).

% add facts about WWII hero names
hero(churchill). hero(charles_de_gaulle). hero(roosevelt).
hero(eisenhower). hero(general_patton). hero(bernard_montgomery). 
hero(vasily_zaytsev). hero(douglas_bader). hero(patrick_reid).
hero(john_f_kennedy). hero(john_clem). hero(ohare).

% add facts about WWII battle names
battle(pearl_harbor). battle(stalingrad). battle(midway).
battle(okinawa). battle(iwo_jima). battle(operation_overlord).
battle(kursk). battle(philippine_sea). battle(narva). battle(caen).

% add query
has_world_war_airports(X) :- airport(X, Y), airport(X, Z), hero(Y), battle(Z).


%%%%%%%%%%%%%%
% QUESTION 3 %
%%%%%%%%%%%%%%

% Part A -> Return true is X is the last element of the list Xs
my_last(X, [X]). % Base Case -> X is the only element in the list 
my_last(X, [_|Xs]) :- my_last(X, Xs).

% Part B -> Return True if X and Y are adjacent in the list Zs
my_adjacent(X, Y, [X, Y|_]). % Base Case -> X and Y are adjacent and only elements
my_adjacent(X, Y, [_|T]) :- my_adjacent(X, Y, T).

% Part C -> Return True if X is a list that is palindromic
palindrome(X) :- reverse(X, X).

%%%%%%%%%%%%%%
% QUESTION 4 %
%%%%%%%%%%%%%%

fib(1, 0). % base case
fib(2, 1). % base case
% Calculate N'th fibonacci number as F. Set N1 to N-1, N2 to N-2, and add sums of fib(N-1) and fib(N-2).
fib(N, F) :- N > 2, N1 is N - 1, N2 is N - 2, fib(N1, F1), fib(N2, F2), F is F1 + F2.


%%%%%%%%%%%%%%
% QUESTION 5 %
%%%%%%%%%%%%%%

% Part 1: Get sum of list
sum([], 0). % Base case -> empty list has 0 sum
sum([H|T], Sum) :- sum(T, Rest), Sum is H + Rest.

% Part 2: Get mean of list
mean([], 0). % Base case -> empty list has 0 mean (don't want to divide by 0)
mean(List, Mean) :- sum(List, Sum), length(List, Length), Length > 0, Mean is Sum / Length.

% Part 3: Get minimum value from list
min([H], H). % Base case -> one element
min([H|T], H) :- min(T, Min), H < Min.
min([H|T], Min) :- min(T, Min), H >= Min.

% Part 4: Get maximum value from list
max([H], H). % Base case -> one element
max([H|T], H) :- max(T, Max), H > Max.
max([H|T], Max) :- max(T, Max), H < Max.
    