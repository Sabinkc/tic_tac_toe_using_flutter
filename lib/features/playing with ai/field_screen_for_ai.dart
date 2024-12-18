// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';
// import 'package:tic_tac_toe/features/playing_with_friend/five_five_game_screen_with_friend.dart';
// import 'package:tic_tac_toe/features/playing%20with%20ai/five_five_side_selecting_screen.dart';
// import 'package:tic_tac_toe/features/playing_with_friend/game_screen_with_friend.dart';
// import 'package:tic_tac_toe/features/playing%20with%20ai/side_selecting_screen.dart';

// class FieldScreenForAi extends StatelessWidget {
//   const FieldScreenForAi({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AudioPlayer audioPlayer = AudioPlayer();
//     Future playButtonTapSound() async {
//       await audioPlayer.play(AssetSource("button_pressed.mp3"));
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
//             colors: [Colors.purple.withOpacity(0.5), CommonColors.primaryColor],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             const Text(
//               "Choose board size",
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CommonButton(
//               title: "3x3 board",
//               buttonColor: CommonColors.primaryColor,
//               titleColor: Colors.white,
//               borderColor: Colors.white,
//               onTap: () {
//                 playButtonTapSound();
//                 Navigator.push(context, CupertinoPageRoute(builder: (context) {
//                   return const SideSelectingScreen();
//                 }));
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CommonButton(
//               title: "5x5 board",
//               buttonColor: Colors.white,
//               titleColor: CommonColors.primaryColor,
//               borderColor: Colors.white,
//               onTap: () {
//                 playButtonTapSound();
//                 Navigator.push(context, CupertinoPageRoute(builder: (context) {
//                   return const FiveFiveSideSelectingScreen();
//                 }));
//               },
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
import 'package:tic_tac_toe/common/common_button.dart';
import 'package:tic_tac_toe/features/playing_with_friend/five_five_game_screen_with_friend.dart';
import 'package:tic_tac_toe/features/playing%20with%20ai/five_five_side_selecting_screen.dart';
import 'package:tic_tac_toe/features/playing_with_friend/game_screen_with_friend.dart';
import 'package:tic_tac_toe/features/playing%20with%20ai/side_selecting_screen.dart';

class FieldScreenForAi extends StatelessWidget {
  const FieldScreenForAi({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();

    Future playButtonTapSound() async {
      await audioPlayer.play(AssetSource("button_pressed.mp3"));
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
            colors: [Colors.purple.withOpacity(0.5), CommonColors.primaryColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.07, // Adjust height based on screen size
            ),
            Text(
              "Choose board size",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.08, // Make text size responsive
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03, // Adjust spacing
            ),
            CommonButton(
              title: "3x3 board",
              buttonColor: CommonColors.primaryColor,
              titleColor: Colors.white,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const SideSelectingScreen();
                }));
              },
            ),
            SizedBox(
              height: screenHeight * 0.02, // Adjust spacing
            ),
            CommonButton(
              title: "5x5 board",
              buttonColor: Colors.white,
              titleColor: CommonColors.primaryColor,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const FiveFiveSideSelectingScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
