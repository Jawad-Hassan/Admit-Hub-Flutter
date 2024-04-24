// import 'package:flutter/material.dart';
// import '../main.dart';
// import 'home.dart';
//
// class WelcomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/welcome_image.jpg',
//               width: 200.0,
//               height: 200.0,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );
//               },
//               child: Text('Please Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }