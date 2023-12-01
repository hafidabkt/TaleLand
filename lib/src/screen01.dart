// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/src/intrest.dart';
// import 'package:project/src/color.dart';
// class Screen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Add a delay of 2 seconds before navigating to Screen2
//     Future.delayed(Duration(seconds: 1), () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Screen2()),
//       );
//     });

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [myBlueColor, myPinkColor, myPurpleColor],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 100),
//               SvgPicture.asset(
//                 'assets/logo.svg',
//                 width: 180,
//                 height: 180,
//               ),
//               SizedBox(height:20),
//                 Text(
//                   '  TaleLand',
//                   style: TextStyle(
//                     fontFamily: 'Jost',
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

