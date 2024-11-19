// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
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
//   List<int> _winningIndices = []; // Stores indices of the winning combination
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
//                         border: Border.all(
//                           color: _winningIndices.contains(index)
//                               ? Colors.green
//                               : Colors.white,
//                           width: 2,
//                         ),
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
//       // First, try to block the player from winning
//       int blockMove = _findBlockingMove(widget.playerSide);
//       if (blockMove != -1) {
//         setState(() {
//           _board[blockMove] =
//               widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
//           _isPlayerTurn = true;
//         });
//         playButtonTapSound(); // Play sound on AI move
//         if (_checkWinner(_board[blockMove])) {
//           setState(() {
//             _winner = 'AI (${_board[blockMove]})';
//           });
//           _showWinnerDialog('AI (${_board[blockMove]})');
//         } else if (_isBoardFull()) {
//           setState(() {
//             _winner = 'Draw';
//           });
//           _showWinnerDialog('It\'s a Draw!');
//         }
//       } else {
//         // If no block needed, try to make a winning move
//         int winningMove =
//             _findWinningMove(widget.playerSide == 'X' ? 'O' : 'X');
//         if (winningMove != -1) {
//           setState(() {
//             _board[winningMove] =
//                 widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
//             _isPlayerTurn = true;
//           });
//           playButtonTapSound(); // Play sound on AI move
//           if (_checkWinner(_board[winningMove])) {
//             setState(() {
//               _winner = 'AI (${_board[winningMove]})';
//             });
//             _showWinnerDialog('AI (${_board[winningMove]})');
//           } else if (_isBoardFull()) {
//             setState(() {
//               _winner = 'Draw';
//             });
//             _showWinnerDialog('It\'s a Draw!');
//           }
//         } else {
//           // If no winning or blocking move, make a random move
//           int move = _getRandomMove();
//           setState(() {
//             _board[move] =
//                 widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
//             _isPlayerTurn = true;
//           });
//           playButtonTapSound(); // Play sound on AI move
//           if (_checkWinner(_board[move])) {
//             setState(() {
//               _winner = 'AI (${_board[move]})';
//             });
//             _showWinnerDialog('AI (${_board[move]})');
//           } else if (_isBoardFull()) {
//             setState(() {
//               _winner = 'Draw';
//             });
//             _showWinnerDialog('It\'s a Draw!');
//           }
//         }
//       }
//     });
//   }

//   int _findBlockingMove(String side) {
//     // Check if the player is about to win and block the move
//     List<List<int>> winPatterns = _getWinPatterns();
//     for (var pattern in winPatterns) {
//       int emptyIndex = _findEmptySpot(pattern, side);
//       if (emptyIndex != -1) {
//         return emptyIndex;
//       }
//     }
//     return -1;
//   }

//   int _findWinningMove(String side) {
//     // Check if the AI can win on the next move
//     List<List<int>> winPatterns = _getWinPatterns();
//     for (var pattern in winPatterns) {
//       int emptyIndex = _findEmptySpot(pattern, side);
//       if (emptyIndex != -1) {
//         return emptyIndex;
//       }
//     }
//     return -1;
//   }

//   List<List<int>> _getWinPatterns() {
//     // Define win patterns for horizontal, vertical, and diagonal
//     return [
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
//       [4, 8, 12, 16],
//     ];
//   }

//   int _findEmptySpot(List<int> pattern, String side) {
//     int count = 0;
//     int emptyIndex = -1;
//     for (var i in pattern) {
//       if (_board[i] == '') {
//         count++;
//         emptyIndex = i;
//       } else if (_board[i] == side) {
//         count++;
//       }
//     }
//     if (count == 4) {
//       return emptyIndex;
//     }
//     return -1;
//   }

//   bool _checkWinner(String side) {
//     // Check for winning combination for either player
//     List<List<int>> winPatterns = _getWinPatterns();
//     for (var pattern in winPatterns) {
//       int count = 0;
//       for (var i in pattern) {
//         if (_board[i] == side) {
//           count++;
//         }
//       }
//       if (count == 4) {
//         _winningIndices = pattern;
//         return true;
//       }
//     }
//     return false;
//   }

//   bool _isBoardFull() {
//     // Check if the board is full
//     for (var cell in _board) {
//       if (cell == '') {
//         return false;
//       }
//     }
//     return true;
//   }

//   int _getRandomMove() {
//     // Get a random empty spot for AI
//     List<int> emptySpots = [];
//     for (int i = 0; i < _board.length; i++) {
//       if (_board[i] == '') {
//         emptySpots.add(i);
//       }
//     }
//     return emptySpots[Random().nextInt(emptySpots.length)];
//   }

//   void _showWinnerDialog(String winner) {
//     // Display winner dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Winner: $winner"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _restartGame();
//               },
//               child: const Text("Restart"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _showEndGameConfirmationDialog();
//               },
//               child: const Text("End Game"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showRestartConfirmationDialog() {
//     // Show restart confirmation dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Are you sure you want to restart?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _restartGame();
//               },
//               child: const Text("Yes"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("No"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEndGameConfirmationDialog() {
//     // Show end game confirmation dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Are you sure you want to end the game?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: const Text("Yes"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("No"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _restartGame() {
//     setState(() {
//       _board = List.filled(25, ''); // Reset the board
//       _winner = '';
//       _isPlayerTurn = true;
//       _winningIndices.clear();
//     });
//   }
// }

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  List<int> _winningIndices = []; // Stores indices of the winning combination
  bool _isPlayerTurn = true; // Initially set to player's turn
  String _winner = '';

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
                      ? "Your turn(${widget.playerSide})!"
                      : "AI's turn (${widget.playerSide == 'X' ? 'O' : 'X'})!")
                  : 'Winner: $_winner',
              style:
                  TextStyle(color: Colors.white, fontSize: screenHeight * 0.03),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: screenHeight * 0.45,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: 25, // 5x5 grid (25 cells)
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // 5 columns for 5x5 grid
                    crossAxisSpacing: 0, // No spacing between items
                    mainAxisSpacing: 0,
                    childAspectRatio: screenWidth /
                        (screenHeight * 0.45), // No spacing between items
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _winningIndices.contains(index)
                                ? Colors.green // Highlight winning cells
                                : Colors.white,
                            width: 3,
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
                                      : Colors.white, // Default color for empty
                              fontSize: screenHeight *
                                  0.04, // Scale text size based on cell size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
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
      // First, try to block the player from winning
      int blockMove = _findBlockingMove(widget.playerSide);
      if (blockMove != -1) {
        setState(() {
          _board[blockMove] =
              widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
          _isPlayerTurn = true;
        });
        playButtonTapSound(); // Play sound on AI move
        if (_checkWinner(_board[blockMove])) {
          setState(() {
            _winner = 'AI (${_board[blockMove]})';
          });
          _showWinnerDialog('AI (${_board[blockMove]})');
        } else if (_isBoardFull()) {
          setState(() {
            _winner = 'Draw';
          });
          _showWinnerDialog('It\'s a Draw!');
        }
      } else {
        // If no block needed, try to make a winning move
        int winningMove =
            _findWinningMove(widget.playerSide == 'X' ? 'O' : 'X');
        if (winningMove != -1) {
          setState(() {
            _board[winningMove] =
                widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
            _isPlayerTurn = true;
          });
          playButtonTapSound(); // Play sound on AI move
          if (_checkWinner(_board[winningMove])) {
            setState(() {
              _winner = 'AI (${_board[winningMove]})';
            });
            _showWinnerDialog('AI (${_board[winningMove]})');
          } else if (_isBoardFull()) {
            setState(() {
              _winner = 'Draw';
            });
            _showWinnerDialog('It\'s a Draw!');
          }
        } else {
          // If no winning or blocking move, make a random move
          int move = _getRandomMove();
          setState(() {
            _board[move] =
                widget.playerSide == 'X' ? 'O' : 'X'; // AI plays opposite side
            _isPlayerTurn = true;
          });
          playButtonTapSound(); // Play sound on AI move
          if (_checkWinner(_board[move])) {
            setState(() {
              _winner = 'AI (${_board[move]})';
            });
            _showWinnerDialog('AI (${_board[move]})');
          } else if (_isBoardFull()) {
            setState(() {
              _winner = 'Draw';
            });
            _showWinnerDialog('It\'s a Draw!');
          }
        }
      }
    });
  }

  int _findBlockingMove(String side) {
    // Check if the player is about to win and block the move
    List<List<int>> winPatterns = _getWinPatterns();
    for (var pattern in winPatterns) {
      int emptyIndex = _findEmptySpot(pattern, side);
      if (emptyIndex != -1) {
        return emptyIndex;
      }
    }
    return -1;
  }

  int _findWinningMove(String side) {
    // Check if the AI can win on the next move
    List<List<int>> winPatterns = _getWinPatterns();
    for (var pattern in winPatterns) {
      int emptyIndex = _findEmptySpot(pattern, side);
      if (emptyIndex != -1) {
        return emptyIndex;
      }
    }
    return -1;
  }

  List<List<int>> _getWinPatterns() {
    // Define win patterns for horizontal, vertical, and diagonal
    return [
      // Horizontal
      [0, 1, 2, 3],
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [6, 7, 8, 9],
      [10, 11, 12, 13],
      [11, 12, 13, 14],
      [15, 16, 17, 18],
      [16, 17, 18, 19],
      [20, 21, 22, 23],
      [21, 22, 23, 24],
      // Vertical
      [0, 5, 10, 15],
      [1, 6, 11, 16],
      [2, 7, 12, 17],
      [3, 8, 13, 18],
      [4, 9, 14, 19],
      [5, 10, 15, 20],
      [6, 11, 16, 21],
      [7, 12, 17, 22],
      [8, 13, 18, 23],
      [9, 14, 19, 24],
      // Diagonal
      [0, 6, 12, 18],
      [4, 8, 12, 16],
    ];
  }

  int _findEmptySpot(List<int> pattern, String side) {
    int count = 0;
    int emptyIndex = -1;
    for (var i in pattern) {
      if (_board[i] == '') {
        count++;
        emptyIndex = i;
      } else if (_board[i] == side) {
        count++;
      }
    }
    if (count == 4) {
      return emptyIndex;
    }
    return -1;
  }

  bool _checkWinner(String side) {
    // Check for winning combination for either player
    List<List<int>> winPatterns = _getWinPatterns();
    for (var pattern in winPatterns) {
      int count = 0;
      for (var i in pattern) {
        if (_board[i] == side) {
          count++;
        }
      }
      if (count == 4) {
        _winningIndices = pattern;
        return true;
      }
    }
    return false;
  }

  bool _isBoardFull() {
    // Check if the board is full
    for (var cell in _board) {
      if (cell == '') {
        return false;
      }
    }
    return true;
  }

  int _getRandomMove() {
    // Get a random empty spot for AI
    List<int> emptySpots = [];
    for (int i = 0; i < _board.length; i++) {
      if (_board[i] == '') {
        emptySpots.add(i);
      }
    }
    return emptySpots[Random().nextInt(emptySpots.length)];
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
      _board = List.filled(25, ''); // Reset the board
      _winner = '';
      _isPlayerTurn = true;
      _winningIndices.clear();
    });
  }
}
