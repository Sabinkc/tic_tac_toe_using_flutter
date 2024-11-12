import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';

class GameScreenWithAi extends StatefulWidget {
  final String playerSide; // Side selected by the player ("X" or "O")

  const GameScreenWithAi({super.key, required this.playerSide});

  @override
  _GameScreenWithAiState createState() => _GameScreenWithAiState();
}

class _GameScreenWithAiState extends State<GameScreenWithAi> {
  List<String> _board = List.filled(9, ''); // Empty board
  bool _isPlayerTurn = true; // Initially set to player's turn
  String _winner = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.5),
        leading: IconButton(
          onPressed: () {
            _showEndGameConfirmationDialog();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.withOpacity(0.5), Colors.deepPurple],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _winner.isEmpty
                  ? (_isPlayerTurn ? "Your turn!" : "AI's turn!")
                  : 'Winner: $_winner',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          _board[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            CommonButton(
                title: "Restart",
                buttonColor: Colors.transparent,
                titleColor: Colors.white,
                borderColor: Colors.white,
                onTap: _showRestartConfirmationDialog),
            const SizedBox(
              height: 20,
            ),
            CommonButton(
                title: "End Game",
                buttonColor: Colors.white,
                titleColor: CommonColors.primaryColor,
                borderColor: Colors.white,
                onTap: _showEndGameConfirmationDialog),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_board[index].isEmpty && _isPlayerTurn) {
      setState(() {
        _board[index] = widget.playerSide; // Set the side chosen by the player
        _isPlayerTurn = false; // Change turn to AI
      });
      if (_checkWinner(widget.playerSide)) {
        setState(() {
          _winner = 'Player (${widget.playerSide})';
        });
        _showWinnerDialog('Player (${widget.playerSide})');
      } else if (_isBoardFull()) {
        setState(() {
          _winner = 'Draw';
        });
        _showWinnerDialog('It\'s a Draw!');
      } else {
        _aiMove();
      }
    }
  }

  void _aiMove() {
    Future.delayed(const Duration(milliseconds: 500), () {
      int bestMove = _minimax(_board, 0, true);
      setState(() {
        _board[bestMove] =
            widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
        _isPlayerTurn = true; // Switch turn to player
      });
      if (_checkWinner(_board[bestMove])) {
        setState(() {
          _winner = 'AI (${_board[bestMove]})';
        });
        _showWinnerDialog('AI (${_board[bestMove]})');
      } else if (_isBoardFull()) {
        setState(() {
          _winner = 'Draw';
        });
        _showWinnerDialog('It\'s a Draw!');
      }
    });
  }

  // Minimax function for optimal AI move
  int _minimax(List<String> board, int depth, bool isMaximizing) {
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }

    // Base Case 1: Check for a winner
    if (_checkWinner(widget.playerSide)) {
      return -10 + depth; // Player wins
    } else if (_checkWinner(widget.playerSide == 'X' ? 'O' : 'X')) {
      return 10 - depth; // AI wins
    }

    // Base Case 2: If board is full (draw)
    if (availableMoves.isEmpty) {
      return 0; // It's a draw
    }

    // Maximizing for AI
    if (isMaximizing) {
      int best = -1000;
      int bestMove = -1;
      for (int move in availableMoves) {
        board[move] = widget.playerSide == 'X' ? 'O' : 'X'; // AI move
        int score = _minimax(board, depth + 1, false);
        board[move] = ''; // Undo move

        if (score > best) {
          best = score;
          bestMove = move;
        }
      }
      return bestMove;
    } else {
      // Minimizing for Player
      int best = 1000;
      int bestMove = -1;
      for (int move in availableMoves) {
        board[move] = widget.playerSide; // Player move
        int score = _minimax(board, depth + 1, true);
        board[move] = ''; // Undo move

        if (score < best) {
          best = score;
          bestMove = move;
        }
      }
      return bestMove;
    }
  }

  bool _checkWinner(String side) {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == side &&
          _board[pattern[1]] == side &&
          _board[pattern[2]] == side) {
        return true;
      }
    }
    return false;
  }

  bool _isBoardFull() {
    for (var spot in _board) {
      if (spot.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text(winner),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text('End Game'),
            ),
          ],
        );
      },
    );
  }

  void _showRestartConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to restart the game?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showEndGameConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to end the game?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _board = List.filled(9, '');
      _winner = '';
      _isPlayerTurn = true;
    });
  }
}
