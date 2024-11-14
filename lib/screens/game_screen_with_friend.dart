import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';

class GameScreenWithFriend extends StatefulWidget {
  const GameScreenWithFriend({Key? key}) : super(key: key);

  @override
  _GameScreenWithFriendState createState() => _GameScreenWithFriendState();
}

class _GameScreenWithFriendState extends State<GameScreenWithFriend> {
  List<String> _board = List.filled(9, ''); // Empty board
  bool _isPlayerOneTurn = true; // Player 1 starts first
  String _winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.5),
        leading: IconButton(
          onPressed: _showEndGameConfirmationDialog,
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
                  ? (_isPlayerOneTurn ? "Player 1's turn" : "Player 2's turn")
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
              onTap: _showRestartConfirmationDialog,
            ),
            const SizedBox(height: 20),
            CommonButton(
              title: "End Game",
              buttonColor: Colors.white,
              titleColor: CommonColors.primaryColor,
              borderColor: Colors.white,
              onTap: _showEndGameConfirmationDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_board[index].isEmpty && _winner.isEmpty) {
      setState(() {
        _board[index] = _isPlayerOneTurn ? 'X' : 'O';
        _isPlayerOneTurn = !_isPlayerOneTurn;
      });
      if (_checkWinner()) {
        setState(() {
          _winner = _isPlayerOneTurn ? 'Player 2 (O)' : 'Player 1 (X)';
        });
        _showWinnerDialog(_winner);
      } else if (_isBoardFull()) {
        setState(() {
          _winner = 'Draw';
        });
        _showWinnerDialog('It\'s a Draw!');
      }
    }
  }

  bool _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]] &&
          _board[pattern[0]] != '') {
        return true;
      }
    }
    return false;
  }

  bool _isBoardFull() {
    return _board.every((spot) => spot.isNotEmpty);
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(winner),
              SizedBox(
                height: 150,
                child: Lottie.asset("assets/gameover_animation.json"),
              ),
            ],
          ),
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
      _isPlayerOneTurn = true;
    });
  }
}
