// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class LottieAnimation extends StatefulWidget {
//   @override
//   _LottieAnimationState createState() => _LottieAnimationState();
// }

// class _LottieAnimationState extends State<LottieAnimation>
//     with TickerProviderStateMixin {
//   AnimationController? _controller;

//   @override
//   void initState() {
//     super.initState();

//     // Create an AnimationController
//     _controller = AnimationController(
//       duration: Duration(seconds: 100), // Set the animation duration
//       vsync: this,
//     );

//     // Set the playback speed
//     _controller?.value = 1; // 0.5x speed

//     // Optionally, you can start the animation immediately
//     _controller?.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Lottie.asset(
//         "assetslottie/animation_ln90l9al.json",
//         fit: BoxFit.fitHeight,
//         controller: _controller,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
