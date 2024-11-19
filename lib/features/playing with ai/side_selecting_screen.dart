// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/features/playing%20with%20ai/game_screen_with_ai.dart';

// class SideSelectingScreen extends StatelessWidget {
//   const SideSelectingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AudioPlayer audioPlayer = AudioPlayer();
//     Future playButtonTapSound() async {
//       await audioPlayer.play(AssetSource("button_pressed.mp3"));
//     }

//     Future<void> playGameStartSound() async {
//       await audioPlayer.play(AssetSource("game_start.mp3"));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CommonColors.primaryColor.withOpacity(0.5),
//         leading: IconButton(
//           onPressed: () {
//             playButtonTapSound();
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.white,
//         ),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               CommonColors.primaryColor.withOpacity(0.5),
//               CommonColors.primaryColor
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Choose a side",
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 playGameStartSound();
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) =>
//                             const GameScreenWithAi(playerSide: 'X')));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white)),
//                 height: 200,
//                 width: 250,
//                 child: const Center(
//                   child: Text(
//                     "X",
//                     style: TextStyle(
//                         color: CommonColors.primaryColor,
//                         fontSize: 130,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 playGameStartSound();
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) =>
//                             const GameScreenWithAi(playerSide: 'O')));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: CommonColors.primaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white)),
//                 height: 200,
//                 width: 250,
//                 child: const Center(
//                   child: Text(
//                     "O",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 130,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/features/playing%20with%20ai/game_screen_with_ai.dart';

class SideSelectingScreen extends StatelessWidget {
  const SideSelectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();

    Future playButtonTapSound() async {
      await audioPlayer.play(AssetSource("button_pressed.mp3"));
    }

    Future<void> playGameStartSound() async {
      await audioPlayer.play(AssetSource("game_start.mp3"));
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor.withOpacity(0.5),
        leading: IconButton(
          onPressed: () {
            playButtonTapSound();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CommonColors.primaryColor.withOpacity(0.5),
              CommonColors.primaryColor
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose a side",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth *
                    0.08, // Adjust font size based on screen width
              ),
            ),
            SizedBox(
              height:
                  screenHeight * 0.03, // Adjust spacing based on screen height
            ),
            GestureDetector(
              onTap: () {
                playGameStartSound();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        const GameScreenWithAi(playerSide: 'X'),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                height: screenHeight * 0.23, // Make height responsive
                width: screenWidth * 0.6, // Make width responsive
                child: Center(
                  child: Text(
                    "X",
                    style: TextStyle(
                      color: CommonColors.primaryColor,
                      fontSize: screenHeight * 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:
                  screenHeight * 0.03, // Adjust spacing based on screen height
            ),
            GestureDetector(
              onTap: () {
                playGameStartSound();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        const GameScreenWithAi(playerSide: 'O'),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                height: screenHeight * 0.23, // Make height responsive
                width: screenWidth * 0.6, // Make width responsive
                child: Center(
                  child: Text(
                    "O",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:
                  screenHeight * 0.03, // Adjust spacing based on screen height
            ),
          ],
        ),
      ),
    );
  }
}
