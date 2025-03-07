import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/bottom_sheet_container_copy.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/models/user.dart';
import 'package:looking2hire/features/home/pages/hire_job_details_page.dart';
import 'package:looking2hire/features/home/widgets/map_user_miles_item.dart';
import 'package:looking2hire/features/home/widgets/mile_item.dart';
import 'package:looking2hire/features/home/widgets/set_distance_item.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/utils/location.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../widgets/mile_action_item.dart';

class LocateJobPage extends StatefulWidget {
  const LocateJobPage({super.key});

  @override
  State<LocateJobPage> createState() => _LocateJobPageState();
}

class _LocateJobPageState extends State<LocateJobPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  GoogleMapController? _mapController;

  bool showSheet = true;
  double mile = 0;
  double maxMiles = 10;
  List<int> miles = [1, 3, 5, 7, 10];
  int selectedMileIndex = 0;
  String time = "23 min";

  Set<Marker> userMarkers = {};

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  List<User> foundUsers = [
    User(
      id: "0",
      name: "John Doe",
      imageUrl: AppAssets.profilePicture,
      lat: 37.7749,
      lng: -122.4194,
      miles: 3,
    ),
    User(
      id: "0",
      name: "James Bond",
      imageUrl: AppAssets.profilePicture,
      lat: 34.0522,
      lng: -118.2437,
      miles: 6,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    //loadUserMarkers();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapController?.dispose();
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

  Future loadLocationMarker() async {
    userMarkers.clear();

    final position = await getCurrentLocation();
    if (position == null) return;
    final marker = Marker(
      markerId: const MarkerId("0"),
      position: const LatLng(30.01124477440843, 30.78459296375513),
      icon: await SvgPicture.asset(
        AppAssets.location2,
        height: 33,
        width: 26,
      ).toBitmapDescriptor(
        logicalSize: const Size(150, 150),
        imageSize: const Size(150, 150),
      ),
    );
    userMarkers.add(marker);
    setState(() {});
  }

  void loadUserMarkers() async {
    await loadLocationMarker();

    for (int i = 0; i < foundUsers.length; i++) {
      final user = foundUsers[i];
      final marker = Marker(
        markerId: MarkerId("${i + 1}"),
        position: LatLng(user.lat, user.lng),
        icon: await MapUserMilesItem(
          user: user,
          onPressed: gotoEmployerProfile,
        ).toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(150, 150),
        ),
      );
      userMarkers.add(marker);
    }
    setState(() {});
  }

  void updateLatLng(LatLng latlng) {}

  Future<void> _goToMark(CameraPosition cameraPosition) async {
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
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
        // child: GoogleMap(
        //   initialCameraPosition: _kGooglePlex,
        //   markers: userMarkers,
        //   onMapCreated: (controller) {
        //     _mapController = controller;
        //   },
        //   mapType: MapType.normal,
        //   myLocationEnabled: true,
        //   onTap: updateLatLng,
        // ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 100,
              child: MapUserMilesItem(
                user: User(
                  id: "0",
                  name: "Mark Zuky",
                  imageUrl: AppAssets.profilePicture,
                  lat: 0,
                  lng: 0,
                  miles: 5,
                ),
                onPressed: gotoEmployerProfile,
              ),
            ),

            Positioned(
              top: 150,
              right: 80,
              child: MapUserMilesItem(
                user: User(
                  id: "0",
                  name: "James Bond",
                  imageUrl: AppAssets.profilePicture,
                  lat: 0,
                  lng: 0,
                  miles: 6,
                ),
                onPressed: gotoEmployerProfile,
              ),
            ),

            Positioned(
              bottom: 400,
              right: 80,
              child: MapUserMilesItem(
                user: User(
                  id: "0",
                  name: "John Doe",
                  imageUrl: AppAssets.profilePicture,
                  lat: 0,
                  lng: 0,
                  miles: 10,
                ),

                onPressed: gotoEmployerProfile,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          showSheet
              ? null
              : FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: openSheet,
                child: SvgPicture.asset(AppAssets.share),
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
              : null,
    );
  }
}
