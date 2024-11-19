// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';

// class GameScreenWithFriend extends StatefulWidget {
//   const GameScreenWithFriend({super.key});

//   @override
//   _GameScreenWithFriendState createState() => _GameScreenWithFriendState();
// }

// class _GameScreenWithFriendState extends State<GameScreenWithFriend> {
//   List<String> _board = List.filled(9, ''); // Empty board
//   bool _isPlayer1Turn = true; // Initially set to Player 1's turn
//   String _winner = '';
//   List<int> _winningIndices = [];

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
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
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
//               style:
//                   TextStyle(color: Colors.white, fontSize: screenHeight * 0.04),
//             ),
//             SizedBox(height: screenHeight * 0.08),
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
//                           color: _winningIndices.contains(index)
//                               ? Colors.green
//                               : Colors.white,
//                           width: 4,
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
//                             fontSize: screenHeight * 0.07,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.07),
//             CommonButton(
//                 title: "Restart",
//                 buttonColor: Colors.transparent,
//                 titleColor: Colors.white,
//                 borderColor: Colors.white,
//                 onTap: () {
//                   playButtonTapSound();
//                   _showRestartConfirmationDialog();
//                 }),
//             SizedBox(
//               height: screenHeight * 0.02,
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
//       final winnerPattern = _checkWinner(_board[index]);
//       if (winnerPattern != null) {
//         setState(() {
//           _winningIndices = winnerPattern;
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

//   List<int>? _checkWinner(String side) {
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
//         return pattern;
//       }
//     }
//     return null;
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

//   void _restartGame() {
//     setState(() {
//       _board = List.filled(9, '');
//       _winner = '';
//       _isPlayer1Turn = true; // Start with player 1
//       _winningIndices = [];
//     });
//   }
// }

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';

class GameScreenWithFriend extends StatefulWidget {
  const GameScreenWithFriend({super.key});

  @override
  _GameScreenWithFriendState createState() => _GameScreenWithFriendState();
}

class _GameScreenWithFriendState extends State<GameScreenWithFriend> {
  List<String> _board = List.filled(9, ''); // Empty board
  bool _isPlayer1Turn = true; // Initially set to Player 1's turn
  String _winner = '';
  List<int> _winningIndices = [];

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
              style:
                  TextStyle(color: Colors.white, fontSize: screenHeight * 0.04),
            ),
            SizedBox(height: screenHeight * 0.08),
            // Use LayoutBuilder to make the GridView responsive
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onTap(index),
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _winningIndices.contains(index)
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
            SizedBox(height: screenHeight * 0.07),
            CommonButton(
              title: "Restart",
              buttonColor: Colors.transparent,
              titleColor: Colors.white,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                _showRestartConfirmationDialog();
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            CommonButton(
              title: "End Game",
              buttonColor: Colors.white,
              titleColor: CommonColors.primaryColor,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                _showEndGameConfirmationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_board[index].isEmpty) {
      playButtonTapSound(); // Play sound on player tap
      setState(() {
        _board[index] = _isPlayer1Turn ? 'X' : 'O';
        _isPlayer1Turn = !_isPlayer1Turn;
      });
      final winnerPattern = _checkWinner(_board[index]);
      if (winnerPattern != null) {
        setState(() {
          _winningIndices = winnerPattern;
          _winner = _isPlayer1Turn ? 'Player 2' : 'Player 1';
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
        return pattern;
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

  void _restartGame() {
    setState(() {
      _board = List.filled(9, '');
      _winner = '';
      _isPlayer1Turn = true; // Start with player 1
      _winningIndices = [];
    });
  }
}
