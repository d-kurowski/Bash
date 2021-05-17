import os
import math


def display_board():
    os.system("cls" if os.name == "nt" else "clear")
    print("\n")
    for i in range(0, 8, 3):
        print(" " + board[i] + "|" + board[i + 1] + "|" + board[i + 2])
        if i != 6:
            print("-------")
        else:
            print("\n")


def collect_input():
    invalid_input = True
    valid_board_positions = []
    board_position = None

    for i in range(9):
        if board[i] != "X" and board[i] != "O":
            valid_board_positions.append(i)

    while invalid_input == True:
        board_position = int(input("Player turn, enter board position (0-8): "))

        if board_position in valid_board_positions:
            invalid_input = False
        else:
            print("Invalid position, try again!")

    return board_position


def is_winning(board_state, marker):
    wc = [marker, marker, marker]

    if (
        (board_state[0:3] == wc)
        or (board_state[3:6] == wc)
        or (board_state[6:9] == wc)
        or (board_state[0:7:3] == wc)
        or (board_state[1:8:3] == wc)
        or (board_state[2:9:3] == wc)
        or (board_state[0:9:4] == wc)
        or (board_state[2:7:2] == wc)
    ):
        return True
    else:
        return False


def no_more_moves(board_state):
    for i in range(9):
        if board_state[i] == "X" or board_state == "O":
            return False

    return True


def minimax(current_turn, board_state):
    if is_winning(board_state, computer_marker):
        return 1
    elif is_winning(board_state, player_marker):
        return -1
    elif no_more_moves(board_state):
        return 0

    if current_turn == "computer":
        best_score = -math.inf
        for i in range(3):
            if board_state[i] == " ":
                board_state[i] = computer_marker
                score = minimax("player", board_state.copy())
                board_state[i] = " "
                if score > best_score:
                    best_score = score
    else:
        best_score = math.inf
        for i in range(3):
            if board_state[i] == " ":
                board_state[i] = player_marker
                score = minimax("computer", board_state.copy())
                board_state[i] = " "
                if score < best_score:
                    best_score = score

    return best_score


def find_best_move(board_state):
    best_score = -math.inf
    best_move = None

    for i in range(9):
        if board_state[i] == " ":
            board_state[i] = computer_marker
            score = minimax("player", board_state.copy())
            board_state[i] = " "
            if score > best_score:
                best_score = score
                best_move = i

    return best_move


def announce_winner():
    if no_more_moves(board):
        print("It's a draw!")
    else:
        if whose_turn == player_marker:
            print("Player wins!")
        else:
            print("Computer wins!")


if __name__ == "__main__":

    board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    game_over = False
    player_marker = " "
    computer_marker = " "
    whose_turn = "X"

    while True:
        answer = input("Select a marker ('X' or 'O'): ")
        if answer in ("X", "x"):
            player_marker = "X"
            computer_marker = "O"
            break
        elif answer in ("O", "o"):
            player_marker = "O"
            computer_marker = "X"
            break
        else:
            print("Invalid marker, try again!")

    display_board()

    while not game_over:
        print(player_marker)

        if whose_turn == player_marker:
            selected_board_position = collect_input()
        else:
            selected_board_position = find_best_move(board)

        board[selected_board_position] = whose_turn

        display_board()

        game_over = is_winning(board, whose_turn) or no_more_moves(board)

        if not game_over:
            if whose_turn == "X":
                whose_turn = "O"
            else:
                whose_turn = "X"

        announce_winner()
