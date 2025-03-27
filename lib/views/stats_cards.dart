import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {
  final List<Widget> cards;
  const StatsCards({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    // return GridView(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //   ),
    //   children: cards,
    // );
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      // crossAxisAlignment: WrapCrossAlignment.center,
      // runAlignment: WrapAlignment.center,
      // alignment: WrapAlignment.center,
      children: cards,
    );
  }
}
