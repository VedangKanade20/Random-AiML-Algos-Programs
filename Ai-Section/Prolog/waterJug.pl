start(2,0):-write(' 4lit Jug: 2 | 3lit Jug: 0|\n'),
write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n'),
write('Goal Reached! Congrats!!\n'),
write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n').
start(X,Y):-write(' Water Jug Game \n\n\n'),
write('Intial State: 4lit Jug- 0lit\n'),
write(' 3lit Jug- 0lit\n'),
write('Final State: 4lit Jug- 2lit\n'),
write(' 3lit Jug- 0lit\n'),
write('Follow the Rules: \n'),
write('Rule 1: Fill 4lit Jug\n'),
write('Rule 2: Fill 3lit Jug\n'),
write('Rule 3: Empty 4lit Jug\n'),
write('Rule 4: Empty 3lit Jug\n'),
write('Rule 5: Pour water from 3lit Jug to fill 4lit Jug\n'),
write('Rule 6: Pour water from 4lit Jug to fill 3lit Jug\n'),
write('Rule 7: Pour all of water from 3lit Jug to 4lit Jug\n'),
write('Rule 8: Pour all of water from 4lit Jug to 3lit Jug\n'),
write(' 4lit Jug: 0 | 3lit Jug: 0'),nl,
write(' Current Quantity :'),
write(' 4lit Jug: '),write(X),write('| 3lit Jug: '),
write(Y),write('|\n'),
write(' Enter the move::'),
read(N),
contains(X,Y,N).
contains(_,Y,1):-start(4,Y).
contains(X,_,2):-start(X,3).
contains(_,Y,3):-start(0,Y).
contains(X,_,4):-start(X,0).
contains(X,Y,5):-N is Y-4+X, start(4,N).
contains(X,Y,6):-N is X-3+Y, start(N,3).
contains(X,Y,7):-N is X+Y, start(N,0).
contains(X,Y,8):-N is X+Y, start(0,N).

% This program performs operations based on the provided selection.
% To run this program, load it into your Prolog interpreter and execute the desired predicate.
% Start the game with both jugs empty 
%?- start(0, 0).

% Start the game with 4-liter jug full and 3-liter jug empty
%?- start(4, 0).

% Start the game with 4-liter jug empty and 3-liter jug full
%?- start(0, 3).