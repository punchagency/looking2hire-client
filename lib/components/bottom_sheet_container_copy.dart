// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:looking2hire/constants/app_assets.dart';

// class BottomSheetContainer extends StatelessWidget {
//   final Widget child;
//   final VoidCallback onClose;
//   final AnimationController? animationController;

//   const BottomSheetContainer({
//     Key? key,
//     required this.child,
//     required this.onClose,
//     this.animationController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomSheet(
//       onClosing: onClose,
//       enableDrag: true,
//       showDragHandle: true,
//       animationController: animationController,
//       dragHandleColor: const Color(0xFFBABABA),
//       // constraints: BoxConstraints(maxHeight: 400, minHeight: 100),
//       backgroundColor: Colors.white,
//       builder: (context) {
//         return child;
//       },
//     );
//   }
// }
