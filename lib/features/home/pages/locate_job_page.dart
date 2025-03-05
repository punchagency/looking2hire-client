import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/widgets/distance_action_item.dart';
import 'package:looking2hire/features/home/widgets/map_user_miles_item.dart';
import 'package:looking2hire/features/home/widgets/mile_item.dart';
import 'package:looking2hire/features/home/widgets/set_distance_item.dart';

class LocateJobPage extends StatefulWidget {
  const LocateJobPage({super.key});

  @override
  State<LocateJobPage> createState() => _LocateJobPageState();
}

class _LocateJobPageState extends State<LocateJobPage> {
  double distance = 0;
  List<int> miles = [1, 3, 5, 7, 10];
  int selectedMileIndex = 0;

  void decrementDistance() {}
  void incrementDistance() {}

  void updateMile(int index) {
    selectedMileIndex = index;
    setState(() {});
  }

  void updateDistance(double value) {
    setState(() {
      distance = value;
    });
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
                onPressed: () {},
              ),
            ),

            Positioned(
              top: 150,
              right: 80,
              child: MapUserMilesItem(
                imageUrl: AppAssets.profilePicture,
                mile: 6,
                onPressed: () {},
              ),
            ),

            Positioned(
              bottom: 400,
              right: 80,
              child: MapUserMilesItem(
                imageUrl: AppAssets.profilePicture,
                mile: 10,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            height: 280,
            child: BottomSheetContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.share),
                      const SizedBox(width: 10),
                      Text(
                        "Set distance",
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
                                  title: "28 min",
                                ),
                                const SizedBox(width: 10),
                                SetDistanceItem(
                                  image: AppAssets.miles,
                                  title: "10 miles",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      DistanceActionItem(
                        isIncrement: false,
                        onPressed: decrementDistance,
                      ),
                      const SizedBox(width: 10),
                      DistanceActionItem(
                        isIncrement: true,
                        onPressed: incrementDistance,
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
                          enabledThumbRadius: 12.0,
                        ), // Adjust size
                      ),
                      child: Slider.adaptive(
                        min: 0,
                        max: 100,
                        value: distance,
                        onChanged: updateDistance,
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
                        onChanged: updateMile,
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
