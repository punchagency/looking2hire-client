import 'package:flutter/cupertino.dart';
import 'package:looking2hire/features/home/widgets/job_detail_tabitem.dart';

import '../../../app_colors.dart';

class JobDetailsTabbar extends StatelessWidget {
  final List<String> tabs;

  final int selectedTab;
  final ValueChanged<int> onChanged;

  const JobDetailsTabbar({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.lightestGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          return Expanded(
            child: JobDetailTabitem(
              title: tab,
              selected: index == selectedTab,
              onPressed: () => onChanged(index),
            ),
          );
          // return Expanded(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: JobDetailTabitem(
          //           title: tab,
          //           selected: index == selectedTab,
          //           onPressed: () => onChanged(index),
          //         ),
          //       ),
          //       if (index != tabs.length - 1) SizedBox(width: 10),
          //     ],
          //   ),
          // );
        }),
      ),
    );
  }
}
