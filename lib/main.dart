import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screens/game_screen_with_ai.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/side_selecting_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.dynaPuffTextTheme(
        Theme.of(context).textTheme,
      )),
      home: const HomeScreen(),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const TicTacToeApp());
// }

// class TicTacToeApp extends StatelessWidget {
//   const TicTacToeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tic Tac Toe',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const GameScreen(),
//     );
//   }
// }

// class GameScreen extends StatefulWidget {
//   const GameScreen({super.key});

//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   static const int gridSize = 3;
//   List<String> board =
//       List.filled(gridSize * gridSize, ''); // Initialize empty board
//   bool isPlayerTurn = true;

//   void playerMove(int index) {
//     if (board[index] == '' && isPlayerTurn) {
//       setState(() {
//         board[index] = 'X'; // Player's symbol
//         isPlayerTurn = false; // Switch to AI's turn
//       });
//       String? winner = checkWinner();
//       if (winner == null) {
//         aiMove(); // Make AI move
//       } else {
//         showEndDialog(winner);
//       }
//     }
//   }

//   void aiMove() {
//     int bestScore = -1000;
//     int bestMove = -1;

//     // Minimax algorithm to find the best move
//     for (int i = 0; i < board.length; i++) {
//       if (board[i] == '') {
//         board[i] = 'O'; // AI's symbol
//         int score = minimax(0, false);
//         board[i] = ''; // Undo the move

//         if (score > bestScore) {
//           bestScore = score;
//           bestMove = i;
//         }
//       }
//     }

//     // Make the best move
//     if (bestMove != -1) {
//       setState(() {
//         board[bestMove] = 'O'; // AI's symbol
//         isPlayerTurn = true; // Switch back to player's turn
//       });
//       String? winner = checkWinner();
//       if (winner != null) {
//         showEndDialog(winner);
//       }
//     }
//   }

//   int minimax(int depth, bool isMaximizing) {
//     String? winner = checkWinner();
//     if (winner == 'O') return 1; // AI wins
//     if (winner == 'X') return -1; // Player wins
//     if (winner == 'Draw') return 0; // Draw

//     if (isMaximizing) {
//       int bestScore = -1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = 'O'; // AI's move
//           int score = minimax(depth + 1, false);
//           board[i] = ''; // Undo move
//           bestScore = score > bestScore ? score : bestScore;
//         }
//       }
//       return bestScore;
//     } else {
//       int bestScore = 1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = 'X'; // Player's move
//           int score = minimax(depth + 1, true);
//           board[i] = ''; // Undo move
//           bestScore = score < bestScore ? score : bestScore;
//         }
//       }
//       return bestScore;
//     }
//   }

//   String? checkWinner() {
//     // Check rows for a winner
//     for (int i = 0; i < gridSize; i++) {
//       if (board[i * gridSize] == board[i * gridSize + 1] &&
//           board[i * gridSize] == board[i * gridSize + 2] &&
//           board[i * gridSize] != '') {
//         return board[i * gridSize]; // Return 'X' or 'O'
//       }
//     }

//     // Check columns for a winner
//     for (int i = 0; i < gridSize; i++) {
//       if (board[i] == board[i + gridSize] &&
//           board[i] == board[i + 2 * gridSize] &&
//           board[i] != '') {
//         return board[i]; // Return 'X' or 'O'
//       }
//     }

//     // Check diagonals for a winner
//     if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
//       return board[0]; // Return 'X' or 'O'
//     }
//     if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
//       return board[2]; // Return 'X' or 'O'
//     }

//     // Check for a draw
//     if (board.every((cell) => cell != '')) {
//       return 'Draw'; // Indicate a draw
//     }

//     return null; // No winner yet
//   }

//   void showEndDialog(String? winner) {
//     String message = (winner == 'Draw') ? 'It\'s a draw!' : '$winner wins!';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               restartGame(); // Restart game after dialog closes
//             },
//             child: const Text('Restart'),
//           ),
//         ],
//       ),
//     );
//   }

//   void restartGame() {
//     setState(() {
//       board = List.filled(gridSize * gridSize, ''); // Reset board
//       isPlayerTurn = true; // Reset turn
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tic Tac Toe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Your turn!",
//               style: TextStyle(fontSize: 30),
//             ),
//             const SizedBox(height: 50),
//             Expanded(
//               child: GridView.builder(
//                 itemCount: 9,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                 ),
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => playerMove(index), // Handle player's move
//                     child: Container(
//                       color: Colors.grey[300], // Cell background color
//                       margin: const EdgeInsets.all(4),
//                       child: Center(
//                         child: Text(
//                           board[index],
//                           style: TextStyle(
//                             fontSize: 60,
//                             color:
//                                 board[index] == 'X' ? Colors.blue : Colors.red,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: restartGame, // Restart game
//               child: const Text("Restart"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
