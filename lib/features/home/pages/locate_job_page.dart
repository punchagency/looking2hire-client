import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/widgets/map_user_miles_item.dart';
import 'package:looking2hire/features/home/widgets/mile_item.dart';
import 'package:looking2hire/features/home/widgets/set_distance_item.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';

import '../widgets/mile_action_item.dart';

class LocateJobPage extends StatefulWidget {
  const LocateJobPage({super.key});

  @override
  State<LocateJobPage> createState() => _LocateJobPageState();
}

class _LocateJobPageState extends State<LocateJobPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool showSheet = true;
  double mile = 0;
  double maxMiles = 10;
  List<int> miles = [1, 3, 5, 7, 10];
  int selectedMileIndex = 0;
  String time = "23 min";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void gotoEmployerProfile() {
    context.pushTo(LookingToHireProfile());
  }

  void decrementMile() {
    if (mile.toInt() <= 0) return;
    mile = mile.toInt() - 1;
    setState(() {});
  }

  void incrementMile() {
    if (mile.toInt() >= maxMiles) return;
    mile = mile.toInt() + 1;
    setState(() {});
  }

  void updateSelectedMiles(int index) {
    selectedMileIndex = index;
    mile = miles[index].toDouble();
    setState(() {});
  }

  void updateMile(double value) {
    final mileIndex = miles.indexWhere((miles) => miles >= value);
    selectedMileIndex = mileIndex != -1 ? mileIndex : 0;
    mile = value;

    setState(() {});
  }

  void openSheet() {
    showSheet = true;
    setState(() {});
  }

  void closeSheet() {
    showSheet = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: ""),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.map),
            // image: NetworkImage(logoUrl),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 100,
              child: MapUserMilesItem(
                imageUrl: AppAssets.profilePicture,
                mile: 5,
                onPressed: gotoEmployerProfile,
              ),
            ),

            Positioned(
              top: 150,
              right: 80,
              child: MapUserMilesItem(
                imageUrl: AppAssets.profilePicture,
                mile: 6,
                onPressed: gotoEmployerProfile,
              ),
            ),

            Positioned(
              bottom: 400,
              right: 80,
              child: MapUserMilesItem(
                imageUrl: AppAssets.profilePicture,
                mile: 10,
                onPressed: gotoEmployerProfile,
              ),
            ),
          ],
        ),
      ),
      bottomSheet:
          showSheet
              ? SizedBox(
                height: 270,

                child: BottomSheetContainer(
                  onClose: closeSheet,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.share),
                          const SizedBox(width: 10),
                          Text(
                            "Set Distance",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lighterBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set distance within 10 miles",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.lighterBlack,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    SetDistanceItem(
                                      image: AppAssets.clock,
                                      title: time,
                                    ),
                                    const SizedBox(width: 10),
                                    SetDistanceItem(
                                      image: AppAssets.miles,
                                      title: "${mile.toInt()} miles",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          MileActionItem(
                            isIncrement: false,
                            onPressed: decrementMile,
                          ),
                          const SizedBox(width: 10),
                          MileActionItem(
                            isIncrement: true,
                            onPressed: incrementMile,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        height: 15,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            padding: const EdgeInsets.all(0),
                            inactiveTrackColor: const Color(0xFFF2F2F2),
                            activeTrackColor: const Color(0xFF2C58B8),
                            thumbColor: const Color(0xFF2C58B8),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 6.0,
                            ), // Adjust size
                          ),
                          child: Slider.adaptive(
                            min: 0,
                            max: maxMiles,
                            value: mile,
                            onChanged: updateMile,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(miles.length, (index) {
                          final mile = miles[index];
                          return MileItem(
                            selected: selectedMileIndex == index,
                            index: index,
                            mile: mile,
                            onChanged: updateSelectedMiles,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
              // ? BottomSheet(
              //   onClosing: () {},
              //   enableDrag: true,
              //   showDragHandle: true,
              //   animationController: _animationController,
              //   dragHandleColor: const Color(0xFFBABABA),
              //   constraints: BoxConstraints(maxHeight: 400, minHeight: 100),
              //   backgroundColor: Colors.white,
              //   builder: (context) {
              //     return Container(
              //       color: Colors.red,
              //       // constraints: BoxConstraints(maxHeight: 400, minHeight: 100),
              //     );
              //     return SizedBox(
              //       height: 280,
              //       child: BottomSheetContainer(
              //         onClose: closeSheet,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 SvgPicture.asset(AppAssets.share),
              //                 const SizedBox(width: 10),
              //                 Text(
              //                   "Set Distance",
              //                   style: const TextStyle(
              //                     fontSize: 26,
              //                     fontWeight: FontWeight.w500,
              //                     color: AppColors.lighterBlack,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(height: 18),
              //             Row(
              //               children: [
              //                 Expanded(
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         "Set distance within 10 miles",
              //                         style: const TextStyle(
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.w400,
              //                           color: AppColors.lighterBlack,
              //                         ),
              //                       ),
              //                       const SizedBox(height: 4),
              //                       Row(
              //                         children: [
              //                           SetDistanceItem(
              //                             image: AppAssets.clock,
              //                             title: time,
              //                           ),
              //                           const SizedBox(width: 10),
              //                           SetDistanceItem(
              //                             image: AppAssets.miles,
              //                             title: "${mile.toInt()} miles",
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 const SizedBox(width: 10),
              //                 MileActionItem(
              //                   isIncrement: false,
              //                   onPressed: decrementMile,
              //                 ),
              //                 const SizedBox(width: 10),
              //                 MileActionItem(
              //                   isIncrement: true,
              //                   onPressed: incrementMile,
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(height: 20),
              //             SizedBox(
              //               height: 15,
              //               child: SliderTheme(
              //                 data: SliderTheme.of(context).copyWith(
              //                   padding: const EdgeInsets.all(0),
              //                   inactiveTrackColor: const Color(0xFFF2F2F2),
              //                   activeTrackColor: const Color(0xFF2C58B8),
              //                   thumbColor: const Color(0xFF2C58B8),
              //                   thumbShape: RoundSliderThumbShape(
              //                     enabledThumbRadius: 6.0,
              //                   ), // Adjust size
              //                 ),
              //                 child: Slider.adaptive(
              //                   min: 0,
              //                   max: maxMiles,
              //                   value: mile,
              //                   onChanged: updateMile,
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(height: 20),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: List.generate(miles.length, (index) {
              //                 final mile = miles[index];
              //                 return MileItem(
              //                   selected: selectedMileIndex == index,
              //                   index: index,
              //                   mile: mile,
              //                   onChanged: updateSelectedMiles,
              //                 );
              //               }),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // )
              : null,
    );
  }
}
