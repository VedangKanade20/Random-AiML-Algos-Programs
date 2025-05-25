% To play a game with the computer, type
% play.

% --- Winning Conditions ---

win(Board, Player) :- rowwin(Board, Player).
win(Board, Player) :- colwin(Board, Player).
win(Board, Player) :- diagwin(Board, Player).

rowwin([P,P,P,_,_,_,_,_,_], P).
rowwin([_,_,_,P,P,P,_,_,_], P).
rowwin([_,_,_,_,_,_,P,P,P], P).

colwin([P,_,_,P,_,_,P,_,_], P).
colwin([_,P,_,_,P,_,_,P,_], P).
colwin([_,_,P,_,_,P,_,_,P], P).

diagwin([P,_,_,_,P,_,_,_,P], P).
diagwin([_,_,P,_,P,_,P,_,_], P).

% --- Full board check (for draw) ---
full(Board) :- \+ member(b, Board).

% --- Display the board ---
display([A,B,C,D,E,F,G,H,I]) :-
    write([A,B,C]), nl,
    write([D,E,F]), nl,
    write([G,H,I]), nl, nl.

% --- Check if X can win in one move ---
x_can_win_in_one(Board) :- move(Board, x, NewBoard), win(NewBoard, x).

% --- Computer's move logic (o) ---
validate(Board, NewBoard) :-
    move(Board, o, NewBoard),
    win(NewBoard, o), !.  % Winning move

validate(Board, NewBoard) :-
    move(Board, o, NewBoard),
    \+ x_can_win_in_one(NewBoard), !.  % Avoid letting x win next

validate(Board, NewBoard) :-
    move(Board, o, NewBoard).  % Otherwise, make any move

% --- Make a move (for o or simulation) ---
move([b,B,C,D,E,F,G,H,I], P, [P,B,C,D,E,F,G,H,I]).
move([A,b,C,D,E,F,G,H,I], P, [A,P,C,D,E,F,G,H,I]).
move([A,B,b,D,E,F,G,H,I], P, [A,B,P,D,E,F,G,H,I]).
move([A,B,C,b,E,F,G,H,I], P, [A,B,C,P,E,F,G,H,I]).
move([A,B,C,D,b,F,G,H,I], P, [A,B,C,D,P,F,G,H,I]).
move([A,B,C,D,E,b,G,H,I], P, [A,B,C,D,E,P,G,H,I]).
move([A,B,C,D,E,F,b,H,I], P, [A,B,C,D,E,F,P,H,I]).
move([A,B,C,D,E,F,G,b,I], P, [A,B,C,D,E,F,G,P,I]).
move([A,B,C,D,E,F,G,H,b], P, [A,B,C,D,E,F,G,H,P]).

% --- User Move (x) via position ---
xmove([b,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,b,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,b,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,b,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,b,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,b,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,b,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,b,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,b], 9, [A,B,C,D,E,F,G,H,x]).
xmove(Board, _, Board) :- write('Illegal move.'), nl.

% --- Start game ---
play :- explain, playfrom([b,b,b,b,b,b,b,b,b]).

explain :-
    write('You play X by entering a number (1-9) followed by a period.'), nl,
    write('The board positions are numbered as follows:'), nl,
    display([1,2,3,4,5,6,7,8,9]).

% --- Game loop ---
playfrom(Board) :-
    win(Board, x), write('You win!'), nl.

playfrom(Board) :-
    win(Board, o), write('I win!'), nl.

playfrom(Board) :-
    full(Board), write('Draw!'), nl.

playfrom(Board) :-
    read(N),
    xmove(Board, N, NewBoard),
    (Board == NewBoard ->  % illegal move, try again
        playfrom(Board)
    ;
        display(NewBoard),
        (win(NewBoard, x) -> write('You win!'), nl
        ;
            (full(NewBoard) -> write('Draw!'), nl
            ;
                validate(NewBoard, CompBoard),
                display(CompBoard),
                playfrom(CompBoard)
            )
        )
    ).
