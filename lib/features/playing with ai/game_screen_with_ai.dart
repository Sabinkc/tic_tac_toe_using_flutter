// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';

// class GameScreenWithAi extends StatefulWidget {
//   final String playerSide; // Side selected by the player ("X" or "O")

//   const GameScreenWithAi({super.key, required this.playerSide});

//   @override
//   _GameScreenWithAiState createState() => _GameScreenWithAiState();
// }

// class _GameScreenWithAiState extends State<GameScreenWithAi> {
//   List<String> _board = List.filled(9, ''); // Empty board
//   bool _isPlayerTurn = true; // Initially set to player's turn
//   String _winner = '';
//   List<int> _winningCombination = [];
//   List<int> _highlightedCells = []; // To store indices of winning cells

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
//                   ? (_isPlayerTurn
//                       ? "Your turn (${widget.playerSide})!"
//                       : "AI's turn (${widget.playerSide == 'X' ? 'O' : 'X'})!")
//                   : 'Winner: $_winner',
//               style: const TextStyle(color: Colors.white, fontSize: 35),
//             ),
//             const SizedBox(height: 50),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 9,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                 ),
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _onTap(index),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: _winningCombination.contains(index)
//                               ? Colors.green
//                               : Colors.white,
//                           width: 5, // Make the border thicker to highlight
//                         ),
//                         color: Colors.transparent,
//                       ),
//                       child: Center(
//                         child: Text(
//                           _board[index],
//                           style: TextStyle(
//                             color: _board[index] == 'X'
//                                 ? Colors.red // Red for 'X'
//                                 : _board[index] == 'O'
//                                     ? Colors.yellow // Yellow for 'O'
//                                     : Colors.white, // Default color for empty
//                             fontSize: 60,
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
//       [0, 1, 2],
//       [3, 4, 5],
//       [6, 7, 8],
//       [0, 3, 6],
//       [1, 4, 7],
//       [2, 5, 8],
//       [0, 4, 8],
//       [2, 4, 6],
//     ];
//     for (var pattern in winPatterns) {
//       if (_board[pattern[0]] == side &&
//           _board[pattern[1]] == side &&
//           _board[pattern[2]] == side) {
//         _winningCombination = pattern; // Save the winning combination
//         return true;
//       }
//     }
//     _winningCombination.clear(); // Clear the list if no winner
//     return false;
//   }

//   bool _isBoardFull() {
//     return !_board.contains('');
//   }

//   void _showWinnerDialog(String winner) async {
//     await playGameOverSound(); // Ensure the sound plays before showing dialog

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: CommonColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Winner: $winner",
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 height: 120,
//                 child: Lottie.asset("assets/gameover_animation.json"),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playGameStartSound();
//                     Navigator.pop(context);
//                     _restartGame();
//                   },
//                   child: const Text('Restart'),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playButtonTapSound();
//                     Navigator.pop(context);
//                     Navigator.pop(context);
//                   },
//                   child: const Text('End Game'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       },
//     );
//   }

//   void _showRestartConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: CommonColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Center(
//             child: Text(
//               textAlign: TextAlign.center,
//               'Are you sure to restart the game?',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playGameStartSound();
//                     Navigator.pop(context);
//                     _restartGame();
//                   },
//                   child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text('Yes')),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playButtonTapSound();
//                     Navigator.pop(context);
//                   },
//                   child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text('No')),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
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
//           backgroundColor: CommonColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Center(
//             child: Text(
//               textAlign: TextAlign.center,
//               'Are you sure you want to end the game?',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playButtonTapSound();
//                     Navigator.pop(context);
//                     Navigator.pop(context);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('Yes'),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: CommonColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     playButtonTapSound();
//                     Navigator.pop(context);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('No'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       },
//     );
//   }

//   void _restartGame() {
//     setState(() {
//       _board = List.filled(9, ''); // Reset the board
//       _isPlayerTurn = true; // Set to player's turn
//       _winner = ''; // Reset winner
//       _highlightedCells = []; // Clear the highlighted cells
//       _winningCombination = []; // Clear the winning combination
//     });
//   }
// }

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  List<int> _winningCombination = [];
  List<int> _highlightedCells = []; // To store indices of winning cells

  final AudioPlayer _audioPlayer = AudioPlayer();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double gridSize = screenWidth * 0.75; // Grid takes 75% of the screen width
    double fontSize = screenWidth * 0.12; // Font size based on screen width
    double buttonWidth =
        screenWidth * 0.45; // Buttons' width relative to screen width
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
                  ? (_isPlayerTurn
                      ? "Your turn (${widget.playerSide})!"
                      : "AI's turn (${widget.playerSide == 'X' ? 'O' : 'X'})!")
                  : 'Winner: $_winner',
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    screenWidth * 0.1, // Keep font size fixed, not responsive
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the size of each cell based on the screen size
                double cellSize =
                    min(constraints.maxWidth, constraints.maxHeight) / 3;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1, // Ensure the grid items are square
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onTap(index),
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _winningCombination.contains(index)
                                  ? Colors.green
                                  : Colors.white,
                              width: 4,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              _board[index],
                              style: TextStyle(
                                color: _board[index] == 'X'
                                    ? Colors.red // Red for 'X'
                                    : _board[index] == 'O'
                                        ? Colors.yellow // Yellow for 'O'
                                        : Colors
                                            .white, // Default color for empty
                                fontSize: cellSize *
                                    0.4, // Scale text size based on cell size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.05),
            CommonButton(
                title: "Restart",
                buttonColor: Colors.transparent,
                titleColor: Colors.white,
                borderColor: Colors.white,
                onTap: () {
                  playButtonTapSound();
                  _showRestartConfirmationDialog();
                }),
            SizedBox(
              height: screenHeight * 0.02,
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

  void _onTap(int index) {
    if (_board[index].isEmpty && _isPlayerTurn) {
      playButtonTapSound(); // Play sound on player tap
      setState(() {
        _board[index] = widget.playerSide;
        _isPlayerTurn = false;
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
      int bestMove = _getBestMove();
      playButtonTapSound(); // Play sound on AI move
      setState(() {
        _board[bestMove] =
            widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
        _isPlayerTurn = true;
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

  int _getBestMove() {
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < _board.length; i++) {
      if (_board[i] == '') {
        _board[i] = widget.playerSide == 'X' ? 'O' : 'X';
        int score = _minimax(_board, 0, false);
        _board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int _minimax(List<String> board, int depth, bool isMaximizing) {
    String aiSide = widget.playerSide == 'X' ? 'O' : 'X';

    if (_checkWinner(aiSide)) return 10 - depth;
    if (_checkWinner(widget.playerSide)) return depth - 10;
    if (_isBoardFull()) return 0;

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

  bool _checkWinner(String side) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == side &&
          _board[pattern[1]] == side &&
          _board[pattern[2]] == side) {
        _winningCombination = pattern; // Save the winning combination
        return true;
      }
    }
    _winningCombination.clear(); // Clear the list if no winner
    return false;
  }

  bool _isBoardFull() {
    return !_board.contains('');
  }

  void _showWinnerDialog(String winner) async {
    await playGameOverSound(); // Ensure the sound plays before showing dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CommonColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Winner: $winner",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: Lottie.asset("assets/gameover_animation.json"),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playGameStartSound();
                    Navigator.pop(context);
                    _restartGame();
                  },
                  child: const Text('Restart'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playButtonTapSound();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('End Game'),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
          backgroundColor: CommonColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              'Are you sure to restart the game?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playGameStartSound();
                    Navigator.pop(context);
                    _restartGame();
                  },
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Yes')),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playButtonTapSound();
                    Navigator.pop(context);
                  },
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('No')),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
          backgroundColor: CommonColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              'Are you sure you want to end the game?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playButtonTapSound();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Yes'),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    playButtonTapSound();
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('No'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _board = List.filled(9, ''); // Reset the board
      _isPlayerTurn = true; // Set to player's turn
      _winner = ''; // Reset winner
      _highlightedCells = []; // Clear the highlighted cells
      _winningCombination = []; // Clear the winning combination
    });
  }
}
