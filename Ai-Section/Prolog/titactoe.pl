% Tic Tac Toe game in Prolog
% Board positions: 1 2 3
%                  4 5 6
%                  7 8 9
:- dynamic(board/1).
:- dynamic(player/1).

start :-
    retractall(board(_)),
    retractall(player(_)),
    assert(board([e,e,e,e,e,e,e,e,e])),
    assert(player(x)),
    play.

play :-
    board(Board),
    display_board(Board),
    ( winner(Board, Winner) ->
        format('~w wins!~n', [Winner])
    ; full(Board) ->
        write('Draw!~n')
    ; player(Player),
      format('Player ~w, enter position (1-9): ', [Player]),
      read(Pos),
      integer(Pos), Pos >= 1, Pos =< 9,
      nth1(Pos, Board, e) ->
        move(Player, Pos, Board, NewBoard),
        retract(board(Board)),
        assert(board(NewBoard)),
        switch_player,
        play
    ; write('Invalid move. Try again.~n'), play
    ).

move(Player, Pos, Board, NewBoard) :-
    nth1(Pos, Board, e, Rest),
    nth1(Pos, NewBoard, Player, Rest).

switch_player :-
    player(x) -> retract(player(x)), assert(player(o));
    retract(player(o)), assert(player(x)).

display_board([A,B,C,D,E,F,G,H,I]) :-
    format('~n~w | ~w | ~w~n', [A1,B1,C1]),
    write('---------'), nl,
    format('~w | ~w | ~w~n', [D1,E1,F1]),
    write('---------'), nl,
    format('~w | ~w | ~w~n~n', [G1,H1,I1]),
    display_cell(A,1,A1), display_cell(B,2,B1), display_cell(C,3,C1),
    display_cell(D,4,D1), display_cell(E,5,E1), display_cell(F,6,F1),
    display_cell(G,7,G1), display_cell(H,8,H1), display_cell(I,9,I1).

display_cell(e, N, N) :- !.
display_cell(V, _, V).

winner(Board, Player) :-
    win_pos(Pos),
    maplist(nth1_in_board(Board), Pos, [Player,Player,Player]),
    Player \= e.

nth1_in_board(Board, N, V) :- nth1(N, Board, V).

win_pos([1,2,3]).
win_pos([4,5,6]).
win_pos([7,8,9]).
win_pos([1,4,7]).
win_pos([2,5,8]).
win_pos([3,6,9]).
win_pos([1,5,9]).
win_pos([3,5,7]).

full(Board) :- \+ member(e, Board).

% To play, run: ?- start.