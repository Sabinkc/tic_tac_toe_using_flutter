// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';

// class FiveFiveGameScreenWithFriend extends StatefulWidget {
//   const FiveFiveGameScreenWithFriend({super.key});

//   @override
//   _GameScreenWithFriendState createState() => _GameScreenWithFriendState();
// }

// class _GameScreenWithFriendState extends State<FiveFiveGameScreenWithFriend> {
//   List<String> _board = List.filled(25, ''); // 5x5 board, so 25 cells
//   bool _isPlayer1Turn = true; // Initially set to Player 1's turn
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
//                   ? (_isPlayer1Turn
//                       ? "Player(x) 1's turn!"
//                       : "Player(o) 2's turn!")
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
//                   crossAxisCount: 5, // 5 columns for 5x5 grid
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
//     if (_board[index].isEmpty) {
//       playButtonTapSound(); // Play sound on player tap
//       setState(() {
//         _board[index] = _isPlayer1Turn ? 'X' : 'O';
//         _isPlayer1Turn = !_isPlayer1Turn;
//       });
//       if (_checkWinner(_board[index])) {
//         setState(() {
//           _winner = _isPlayer1Turn ? 'Player 2' : 'Player 1';
//         });
//         _showWinnerDialog(_isPlayer1Turn ? 'Player 2' : 'Player 1');
//       } else if (_isBoardFull()) {
//         setState(() {
//           _winner = 'Draw';
//         });
//         _showWinnerDialog('It\'s a Draw!');
//       }
//     }
//   }

//   bool _checkWinner(String side) {
//     List<List<int>> winPatterns = [];

//     // Check rows and columns for a 4-match
//     for (int i = 0; i < 5; i++) {
//       for (int j = 0; j <= 1; j++) {
//         // Horizontal
//         winPatterns
//             .add([i * 5 + j, i * 5 + j + 1, i * 5 + j + 2, i * 5 + j + 3]);
//         // Vertical
//         winPatterns.add(
//             [j * 5 + i, (j + 1) * 5 + i, (j + 2) * 5 + i, (j + 3) * 5 + i]);
//       }
//     }

//     // Check diagonals for a 4-match
//     for (int i = 0; i <= 1; i++) {
//       for (int j = 0; j <= 1; j++) {
//         winPatterns.add([
//           i * 5 + j,
//           (i + 1) * 5 + j + 1,
//           (i + 2) * 5 + j + 2,
//           (i + 3) * 5 + j + 3
//         ]);
//         winPatterns.add([
//           i * 5 + 4 - j,
//           (i + 1) * 5 + 3 - j,
//           (i + 2) * 5 + 2 - j,
//           (i + 3) * 5 + 1 - j
//         ]);
//       }
//     }

//     // Check all win patterns
//     for (var pattern in winPatterns) {
//       if (_board[pattern[0]] == side &&
//           _board[pattern[1]] == side &&
//           _board[pattern[2]] == side &&
//           _board[pattern[3]] == side) {
//         return true;
//       }
//     }
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
//                 winner,
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
//                 SizedBox(
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
//                     playButtonTapSound();
//                     Navigator.pop(context);
//                   },
//                   child: const Text('No'),
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
//                     playGameStartSound();
//                     Navigator.pop(context);
//                     _restartGame();
//                   },
//                   child: const Text('Yes'),
//                 ),
//               ],
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
//       _isPlayer1Turn = true; // Reset to Player 1's turn
//     });
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
//                   },
//                   child: const Text('No'),
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
//                   child: const Text('Yes'),
//                 ),
//               ],
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
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';

class FiveFiveGameScreenWithFriend extends StatefulWidget {
  const FiveFiveGameScreenWithFriend({super.key});

  @override
  _GameScreenWithFriendState createState() => _GameScreenWithFriendState();
}

class _GameScreenWithFriendState extends State<FiveFiveGameScreenWithFriend> {
  List<String> _board = List.filled(25, ''); // 5x5 board, so 25 cells
  bool _isPlayer1Turn = true; // Initially set to Player 1's turn
  String _winner = '';
  Set<int> _winningIndices = {};

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
                  ? (_isPlayer1Turn
                      ? "Player(x) 1's turn!"
                      : "Player(o) 2's turn!")
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
                  crossAxisCount: 5, // 5 columns for 5x5 grid
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
                          width: 2,
                        ),
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

  void _onTap(int index) {
    if (_board[index].isEmpty && _winner.isEmpty) {
      playButtonTapSound(); // Play sound on player tap
      setState(() {
        _board[index] = _isPlayer1Turn ? 'X' : 'O';
        _isPlayer1Turn = !_isPlayer1Turn;
      });

      List<int>? winnerPattern = _checkWinner(_board[index]);
      if (winnerPattern != null) {
        setState(() {
          _winner = _isPlayer1Turn ? 'Player 2' : 'Player 1';
          _winningIndices = Set.from(winnerPattern); // Store winning indices
        });
        _showWinnerDialog(_isPlayer1Turn ? 'Player 2' : 'Player 1');
      } else if (_isBoardFull()) {
        setState(() {
          _winner = 'Draw';
        });
        _showWinnerDialog('It\'s a Draw!');
      }
    }
  }

  List<int>? _checkWinner(String side) {
    List<List<int>> winPatterns = [];

    // Check rows and columns for a 4-match
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j <= 1; j++) {
        // Horizontal
        winPatterns
            .add([i * 5 + j, i * 5 + j + 1, i * 5 + j + 2, i * 5 + j + 3]);
        // Vertical
        winPatterns.add(
            [j * 5 + i, (j + 1) * 5 + i, (j + 2) * 5 + i, (j + 3) * 5 + i]);
      }
    }

    // Check diagonals for a 4-match
    for (int i = 0; i <= 1; i++) {
      for (int j = 0; j <= 1; j++) {
        winPatterns.add([
          i * 5 + j,
          (i + 1) * 5 + j + 1,
          (i + 2) * 5 + j + 2,
          (i + 3) * 5 + j + 3
        ]);
        winPatterns.add([
          i * 5 + 4 - j,
          (i + 1) * 5 + 3 - j,
          (i + 2) * 5 + 2 - j,
          (i + 3) * 5 + 1 - j
        ]);
      }
    }

    // Check all win patterns
    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == side &&
          _board[pattern[1]] == side &&
          _board[pattern[2]] == side &&
          _board[pattern[3]] == side) {
        return pattern; // Return the winning pattern
      }
    }
    return null;
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
                winner,
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
                SizedBox(
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
                    playButtonTapSound();
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
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
                    playGameStartSound();
                    Navigator.pop(context);
                    _restartGame();
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _board = List.filled(25, ''); // Reset the board
      _winner = '';
      _isPlayer1Turn = true; // Reset to Player 1's turn
      _winningIndices
          .clear(); // Clear the winning indices (highlighted borders)
    });
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
                  },
                  child: const Text('No'),
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
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
