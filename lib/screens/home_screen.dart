// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tic_tac_toe/common/colors.dart';
// import 'package:tic_tac_toe/common/common_button.dart';
// import 'package:tic_tac_toe/screens/game_screen_with_friend.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Total height of the screen
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         height: screenHeight,
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
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "o",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 200,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "x",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 200,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 80,
//             ),
//             TweenAnimationBuilder(
//                 tween: Tween<double>(begin: 0, end: 1),
//                 duration: const Duration(
//                   seconds: 1,
//                 ),
//                 builder: (context, value, child) {
//                   return Opacity(
//                     opacity: value,
//                     child: const Text(
//                       "Choose a play mode",
//                       style: TextStyle(color: Colors.white, fontSize: 30),
//                     ),
//                   );
//                 }),
//             const SizedBox(
//               height: 20,
//             ),
//             // Animate the "With AI" button sliding in from below
//             TweenAnimationBuilder(
//               tween: Tween<double>(begin: screenHeight, end: 0),
//               duration: const Duration(seconds: 1),
//               builder: (context, value, child) {
//                 return Transform.translate(
//                   offset: Offset(0, value),
//                   child: CommonButton(
//                     title: "With AI",
//                     buttonColor: Colors.white,
//                     titleColor: CommonColors.primaryColor,
//                     borderColor: Colors.white,
//                     onTap: () {},
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             // Animate the "With a friend" button sliding in from below
//             TweenAnimationBuilder(
//               tween: Tween<double>(begin: screenHeight, end: 0),
//               duration: const Duration(seconds: 1),
//               builder: (context, value, child) {
//                 return Transform.translate(
//                   offset: Offset(0, value),
//                   child: CommonButton(
//                     title: "With a friend",
//                     buttonColor: CommonColors.primaryColor,
//                     titleColor: Colors.white,
//                     borderColor: Colors.white,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (context) => const GameScreenWithFriend(),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';
import 'package:tic_tac_toe/screens/game_screen_with_friend.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Total height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: MediaQuery.of(context).size.width,
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
            // Animate the "o" and "x" texts sliding down from above
            TweenAnimationBuilder(
              tween: Tween<double>(begin: -screenHeight / 4, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "o",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "x",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 80),

            // Animate the opacity of "Choose a play mode"
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: const Text(
                    "Choose a play mode",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Animate the "With AI" button sliding in from below
            TweenAnimationBuilder(
              tween: Tween<double>(begin: screenHeight, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: CommonButton(
                    title: "With AI",
                    buttonColor: Colors.white,
                    titleColor: CommonColors.primaryColor,
                    borderColor: Colors.white,
                    onTap: () {},
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Animate the "With a friend" button sliding in from below
            TweenAnimationBuilder(
              tween: Tween<double>(begin: screenHeight, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: CommonButton(
                    title: "With a friend",
                    buttonColor: CommonColors.primaryColor,
                    titleColor: Colors.white,
                    borderColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const GameScreenWithFriend(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
