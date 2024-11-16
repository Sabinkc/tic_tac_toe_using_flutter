// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';

// class FiveFiveGameScreenWithAi extends StatefulWidget {
//   final String playerSide; // Side selected by the player ("X" or "O")

//   const FiveFiveGameScreenWithAi({super.key, required this.playerSide});

//   @override
//   _GameScreenWithAiState createState() => _GameScreenWithAiState();
// }

// class _GameScreenWithAiState extends State<FiveFiveGameScreenWithAi> {
//   List<String> _board = List.filled(25, ''); // 5x5 grid with 25 cells
//   bool _isPlayerTurn = true; // Initially set to player's turn
//   String _winner = '';

//   final AudioPlayer _audioPlayer = AudioPlayer();

//   Future<void> playButtonTapSound() async {
//     await _audioPlayer.play(AssetSource("button_pressed.mp3"));
//   }

//   Future<void> playGameOverSound() async {
//     await _audioPlayer.play(AssetSource("game_over.mp3"));
//   }

//   Future<void> playGameStartSound() async {
//     await _audioPlayer.play(AssetSource("game_start.mp3"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple.withOpacity(0.5),
//         leading: IconButton(
//           onPressed: () {
//             playButtonTapSound();
//             _showEndGameConfirmationDialog();
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.white,
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.purple.withOpacity(0.5), Colors.deepPurple],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _winner.isEmpty
//                   ? (_isPlayerTurn ? "Your turn!" : "AI's turn!")
//                   : 'Winner: $_winner',
//               style: const TextStyle(color: Colors.white, fontSize: 30),
//             ),
//             const SizedBox(height: 50),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 25, // 5x5 grid
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5, // 5 columns for a 5x5 grid
//                 ),
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _onTap(index),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 2),
//                         color: Colors.transparent,
//                       ),
//                       child: Center(
//                         child: Text(
//                           _board[index],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 50),
//             CommonButton(
//                 title: "Restart",
//                 buttonColor: Colors.transparent,
//                 titleColor: Colors.white,
//                 borderColor: Colors.white,
//                 onTap: () {
//                   playButtonTapSound();
//                   _showRestartConfirmationDialog();
//                 }),
//             const SizedBox(
//               height: 20,
//             ),
//             CommonButton(
//                 title: "End Game",
//                 buttonColor: Colors.white,
//                 titleColor: CommonColors.primaryColor,
//                 borderColor: Colors.white,
//                 onTap: () {
//                   playButtonTapSound();
//                   _showEndGameConfirmationDialog();
//                 }),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onTap(int index) {
//     if (_board[index].isEmpty && _isPlayerTurn) {
//       playButtonTapSound(); // Play sound on player tap
//       setState(() {
//         _board[index] = widget.playerSide;
//         _isPlayerTurn = false;
//       });
//       if (_checkWinner(widget.playerSide)) {
//         setState(() {
//           _winner = 'Player (${widget.playerSide})';
//         });
//         _showWinnerDialog('Player (${widget.playerSide})');
//       } else if (_isBoardFull()) {
//         setState(() {
//           _winner = 'Draw';
//         });
//         _showWinnerDialog('It\'s a Draw!');
//       } else {
//         _aiMove();
//       }
//     }
//   }

//   void _aiMove() {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       int bestMove = _getBestMove();
//       playButtonTapSound(); // Play sound on AI move
//       setState(() {
//         _board[bestMove] =
//             widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
//         _isPlayerTurn = true;
//       });
//       if (_checkWinner(_board[bestMove])) {
//         setState(() {
//           _winner = 'AI (${_board[bestMove]})';
//         });
//         _showWinnerDialog('AI (${_board[bestMove]})');
//       } else if (_isBoardFull()) {
//         setState(() {
//           _winner = 'Draw';
//         });
//         _showWinnerDialog('It\'s a Draw!');
//       }
//     });
//   }

//   int _getBestMove() {
//     int bestScore = -1000;
//     int bestMove = -1;
//     for (int i = 0; i < _board.length; i++) {
//       if (_board[i] == '') {
//         _board[i] = widget.playerSide == 'X' ? 'O' : 'X';
//         int score = _minimax(_board, 0, false);
//         _board[i] = '';
//         if (score > bestScore) {
//           bestScore = score;
//           bestMove = i;
//         }
//       }
//     }
//     return bestMove;
//   }

//   int _minimax(List<String> board, int depth, bool isMaximizing) {
//     String aiSide = widget.playerSide == 'X' ? 'O' : 'X';

//     if (_checkWinner(aiSide)) return 10 - depth;
//     if (_checkWinner(widget.playerSide)) return depth - 10;
//     if (_isBoardFull()) return 0;

//     if (isMaximizing) {
//       int bestScore = -1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = aiSide;
//           int score = _minimax(board, depth + 1, false);
//           board[i] = '';
//           bestScore = max(score, bestScore);
//         }
//       }
//       return bestScore;
//     } else {
//       int bestScore = 1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = widget.playerSide;
//           int score = _minimax(board, depth + 1, true);
//           board[i] = '';
//           bestScore = min(score, bestScore);
//         }
//       }
//       return bestScore;
//     }
//   }

//   bool _checkWinner(String side) {
//     List<List<int>> winPatterns = [
//       // Horizontal
//       [0, 1, 2, 3],
//       [1, 2, 3, 4],
//       [5, 6, 7, 8],
//       [6, 7, 8, 9],
//       [10, 11, 12, 13],
//       [11, 12, 13, 14],
//       [15, 16, 17, 18],
//       [16, 17, 18, 19],
//       [20, 21, 22, 23],
//       [21, 22, 23, 24],
//       // Vertical
//       [0, 5, 10, 15],
//       [1, 6, 11, 16],
//       [2, 7, 12, 17],
//       [3, 8, 13, 18],
//       [4, 9, 14, 19],
//       [5, 10, 15, 20],
//       [6, 11, 16, 21],
//       [7, 12, 17, 22],
//       [8, 13, 18, 23],
//       [9, 14, 19, 24],
//       // Diagonal
//       [0, 6, 12, 18],
//       [1, 7, 13, 19],
//       [2, 8, 14, 20],
//       [3, 9, 15, 21],
//       [4, 10, 16, 22],
//       [20, 16, 12, 8],
//       [21, 17, 13, 9],
//       [22, 18, 14, 10],
//       [23, 19, 15, 11],
//       [24, 20, 16, 12],
//     ];

//     for (var pattern in winPatterns) {
//       if (pattern.every((index) => _board[index] == side)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   bool _isBoardFull() {
//     return _board.every((cell) => cell.isNotEmpty);
//   }

//   void _showWinnerDialog(String winner) {
//     playGameOverSound();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Game Over'),
//           content: Text('$winner wins!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _resetGame();
//               },
//               child: const Text('Play Again'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: const Text('Exit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _resetGame() {
//     setState(() {
//       _board = List.filled(25, '');
//       _isPlayerTurn = true;
//       _winner = '';
//     });
//   }

//   void _showRestartConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Restart Game'),
//           content: const Text('Are you sure you want to restart the game?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _resetGame();
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEndGameConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('End Game'),
//           content: const Text('Are you sure you want to end the game?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';

class FiveFiveGameScreenWithAi extends StatefulWidget {
  final String playerSide; // Side selected by the player ("X" or "O")

  const FiveFiveGameScreenWithAi({super.key, required this.playerSide});

  @override
  _GameScreenWithAiState createState() => _GameScreenWithAiState();
}

class _GameScreenWithAiState extends State<FiveFiveGameScreenWithAi> {
  List<String> _board = List.filled(25, ''); // 5x5 grid with 25 cells
  bool _isPlayerTurn = true; // Initially set to player's turn
  String _winner = '';

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Functions for playing sound effects
  Future<void> playButtonTapSound() async {
    await _audioPlayer.play(AssetSource("button_pressed.mp3"));
  }

  Future<void> playGameOverSound() async {
    await _audioPlayer.play(AssetSource("game_over.mp3"));
  }

  Future<void> playGameStartSound() async {
    await _audioPlayer.play(AssetSource("game_start.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.5),
        leading: IconButton(
          onPressed: () {
            playButtonTapSound();
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
                itemCount: 25, // 5x5 grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5 columns for a 5x5 grid
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
                onTap: () {
                  playButtonTapSound();
                  _showRestartConfirmationDialog();
                }),
            const SizedBox(
              height: 20,
            ),
            CommonButton(
                title: "End Game",
                buttonColor: Colors.white,
                titleColor: CommonColors.primaryColor,
                borderColor: Colors.white,
                onTap: () {
                  playButtonTapSound();
                  _showEndGameConfirmationDialog();
                }),
          ],
        ),
      ),
    );
  }

  // Handle user taps on the grid
  void _onTap(int index) {
    if (_board[index].isEmpty && _isPlayerTurn) {
      playButtonTapSound(); // Play sound on player tap
      setState(() {
        _board[index] = widget.playerSide;
        _isPlayerTurn = false; // After player move, it's AI's turn
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
        _aiMove(); // Trigger AI move after player's move
      }
    }
  }

  // AI's move
  void _aiMove() {
    Future.delayed(const Duration(milliseconds: 500), () {
      int bestMove = _getBestMove();
      setState(() {
        _board[bestMove] =
            widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
        _isPlayerTurn = true; // After AI move, it's player's turn
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

  // Get best move for AI using minimax algorithm
  int _getBestMove() {
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < _board.length; i++) {
      if (_board[i] == '') {
        _board[i] =
            widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
        int score = _minimax(_board, 0, false);
        _board[i] = ''; // Reset the cell after testing
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  // Minimax algorithm for AI
  int _minimax(List<String> board, int depth, bool isMaximizing) {
    String aiSide = widget.playerSide == 'X' ? 'O' : 'X';

    if (_checkWinner(aiSide)) return 10 - depth; // AI's score
    if (_checkWinner(widget.playerSide)) return depth - 10; // Player's score
    if (_isBoardFull()) return 0; // Draw

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = aiSide;
          int score = _minimax(board, depth + 1, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = widget.playerSide;
          int score = _minimax(board, depth + 1, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  // Check for a winner
  bool _checkWinner(String side) {
    List<List<int>> winPatterns = [
      // Horizontal
      [0, 1, 2, 3, 4],
      [5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],
      // Vertical
      [0, 5, 10, 15, 20],
      [1, 6, 11, 16, 21],
      [2, 7, 12, 17, 22],
      [3, 8, 13, 18, 23],
      [4, 9, 14, 19, 24],
      // Diagonal
      [0, 6, 12, 18, 24],
      [4, 8, 12, 16, 20]
    ];

    for (var pattern in winPatterns) {
      if (pattern.every((index) => _board[index] == side)) {
        return true;
      }
    }
    return false;
  }

  // Check if the board is full
  bool _isBoardFull() {
    return !_board.contains('');
  }

  // Show winner dialog
  void _showWinnerDialog(String winner) {
    playGameOverSound(); // Play sound for game over
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(winner),
          actions: [
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
                _showEndGameConfirmationDialog();
              },
              child: const Text('End Game'),
            ),
          ],
        );
      },
    );
  }

  // Show restart confirmation dialog
  void _showRestartConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to restart the game?'),
          actions: [
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

  // Show end game confirmation dialog
  void _showEndGameConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('End Game'),
          content: const Text('Are you sure you want to end the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // End the game and go back
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

  // Restart the game
  void _restartGame() {
    setState(() {
      _board = List.filled(25, ''); // Reset board
      _isPlayerTurn = true;
      _winner = '';
    });
  }
}
