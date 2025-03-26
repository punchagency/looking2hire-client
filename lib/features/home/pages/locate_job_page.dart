import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/user.dart';
import 'package:looking2hire/features/home/pages/work_job_details_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/mile_item.dart';
import 'package:looking2hire/features/home/widgets/set_distance_item.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/utils/location.dart';
import 'package:looking2hire/utils/platform.dart';
import 'package:provider/provider.dart';
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
  double mile = 1;
  double maxMiles = 10;
  List<int> miles = [1, 3, 5, 7, 10];
  int selectedMileIndex = 0;
  String time = "23 min";

  bool isLoading = false;

  int usersCountLimit = 10;

  Marker? currentUserMarker;
  Set<Marker> jobMarkers = {};
  Position? currentPosition;
  CameraPosition? initialCameraPosition;
  final LatLng defaultCameraPosition = const LatLng(
    37.7749,
    -122.4194,
  ); // Default to San Francisco

  //List<User> foundUsers = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    loadjobMarkers();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void decrementMile() {
    if (mile.toInt() <= 0) return;
    mile = mile.toInt() - 1;
    final mileIndex = miles.indexWhere((miles) => miles >= mile);
    selectedMileIndex = mileIndex != -1 ? mileIndex : 0;
    setState(() {});
    getJobsInDistance();
    //generateRandomUsersLatLngBasedOnMilesFromCurrentLocation();
  }

  void incrementMile() {
    if (mile.toInt() >= maxMiles) return;
    mile = mile.toInt() + 1;
    final mileIndex = miles.indexWhere((miles) => miles >= mile);
    selectedMileIndex = mileIndex != -1 ? mileIndex : 0;

    setState(() {});
    getJobsInDistance();
    //generateRandomUsersLatLngBasedOnMilesFromCurrentLocation();
  }

  void updateSelectedMiles(int index) {
    selectedMileIndex = index;
    mile = miles[index].toDouble();

    setState(() {});
    getJobsInDistance();
    //generateRandomUsersLatLngBasedOnMilesFromCurrentLocation();
  }

  void updateMile(double value) {
    final mileIndex = miles.indexWhere((miles) => miles >= value);
    selectedMileIndex = mileIndex != -1 ? mileIndex : 0;
    mile = value;

    setState(() {});
    getJobsInDistance();
    //generateRandomUsersLatLngBasedOnMilesFromCurrentLocation();
  }

  void openSheet() {
    showSheet = true;
    setState(() {});
  }

  void closeSheet() {
    showSheet = false;
    setState(() {});
  }

  /// Function to update camera zoom based on miles
  void _updateCameraZoom() {
    double zoom = _getZoomLevel();
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(initialCameraPosition!.target, zoom),
    );
  }

  double _getZoomLevel() {
    return 14.0 - (mile * 0.35);
  }

  Future loadLocationMarker() async {
    if (currentPosition != null) return;
    final position = await getCurrentLocation();
    if (position == null) return;

    currentPosition = position;
    context.read<JobProvider>().currentPosition = position;

    initialCameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: _getZoomLevel(),
    );
    // _goToPosition(LatLng(position.latitude, position.longitude));

    final marker = Marker(
      markerId: const MarkerId("0"),
      position: LatLng(position.latitude, position.longitude),
      icon:
          await SvgPicture.asset(
            AppAssets.location2,
            height: 26,
            width: 33,
          ).toBitmapDescriptor(),
    );
    currentUserMarker = marker;
  }

  void gotoJobDetails(Job job) {
    final jobProvider = context.read<JobProvider>();
    jobProvider.job = job;
    context.pushTo(WorkJobDetailsPage());
  }

  void getJobsInDistance() async {
    final jobProvider = context.read<JobProvider>();
    isLoading = true;
    setState(() {});
    await jobProvider.getJobsInDistance(
      latitude: currentPosition!.latitude,
      longitude: currentPosition!.longitude,
      maxDistance: mile.toInt(),
    );

    final jobsInDistance = jobProvider.jobsInDistance;
    print("mile: $mile, jobsInDistance: $jobsInDistance");
    for (var job in jobsInDistance) {
      final markerIcon = await _createMarkerIcon(job);
      final marker = Marker(
        markerId: MarkerId(job.id),
        position: LatLng(
          job.employer!.location![0],
          job.employer!.location![1],
        ),
        icon: markerIcon,
        onTap: () => gotoJobDetails(job),
      );
      jobMarkers.add(marker);
    }
    isLoading = false;
    _updateCameraZoom();
    setState(() {});
  }

  // void generateRandomUsersLatLngBasedOnMilesFromCurrentLocation() async {
  //   if (currentPosition == null || currentUserMarker == null) return;
  //   isLoading = true;

  //   foundUsers.clear();
  //   jobMarkers.clear();

  //   final random = Random();

  //   // final usersCount = random.nextInt(usersCountLimit) + 1;
  //   int usersCount = usersCountLimit;

  //   for (int i = 0; i < usersCount; i++) {
  //     final mile = random.nextInt(miles[selectedMileIndex]) + 1;
  //     // Convert miles to meters (1 mile = 1609.34 meters)
  //     final radiusInMeters = mile * 1609.34;

  //     // Generate random angle in radians
  //     final angle = random.nextDouble() * 2 * pi;

  //     // Calculate random point within circle using current position as center
  //     final lat =
  //         currentPosition!.latitude + (radiusInMeters / 111320) * cos(angle);
  //     final lng =
  //         currentPosition!.longitude +
  //         (radiusInMeters / (111320 * cos(currentPosition!.latitude))) *
  //             sin(angle);

  //     final user = User(
  //       id: (i + 1).toString(),
  //       name: names[random.nextInt(names.length)],
  //       imageUrl: AppAssets.profilePicture,
  //       lat: lat,
  //       lng: lng,
  //       miles: mile,
  //     );

  //     foundUsers.add(user);
  //   }

  //   for (int i = 0; i < foundUsers.length; i++) {
  //     final user = foundUsers[i];
  //     try {
  //       final BitmapDescriptor markerIcon = await _createMarkerIcon(user);
  //       final marker = Marker(
  //         markerId: MarkerId("${i + 1}"),
  //         position: LatLng(user.lat, user.lng),
  //         icon: markerIcon,
  //         onTap: () => gotoEmployerProfile(user),
  //       );
  //       jobMarkers.add(marker);
  //     } catch (e) {
  //       debugPrint('Error creating marker for user ${user.id}: $e');
  //       // Fallback to default marker if custom marker fails
  //       final marker = Marker(
  //         markerId: MarkerId("${i + 1}"),
  //         position: LatLng(user.lat, user.lng),
  //         onTap: () => gotoEmployerProfile(user),
  //       );
  //       jobMarkers.add(marker);
  //     }
  //   }
  //   jobMarkers.add(currentUserMarker!);

  //   isLoading = false;
  //   _updateCameraZoom();
  //   setState(() {});
  // }

  Future<void> loadjobMarkers() async {
    if (!isAndroidAndIos) return;
    jobMarkers.clear();

    await loadLocationMarker();

    getJobsInDistance();

    //generateRandomUsersLatLngBasedOnMilesFromCurrentLocation();
  }

  Future<BitmapDescriptor> _createMarkerIcon(Job job) async {
    final miles = getMilesBetweenTwoPoints(
      currentPosition!.latitude,
      currentPosition!.longitude,
      job.employer!.location![0],
      job.employer!.location![1],
    );
    final Widget markerWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(1.61, 1.61),
              color: Colors.black.withOpacity(0.35),
              blurRadius: 4.46,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ProfilePhoto(imageUrl: user.imageUrl, size: 30),
            CircleAvatar(
              radius: 15,
              backgroundImage:
                  (job.employer?.company_logo ?? "").isNotEmpty
                      ? CachedNetworkImageProvider(job.employer!.company_logo!)
                      : AssetImage(AppAssets.defaultProfilePic)
                          as ImageProvider,
              // backgroundImage: NetworkImage(user.imageUrl),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 4),
            Text(
              "${miles.toInt()} mile${miles.toInt() == 1 ? "" : "s"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
    return await markerWidget.toBitmapDescriptor();
  }

  void updateLatLng(LatLng latlng) {}

  Future<void> goToPosition(LatLng position) async {
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: _getZoomLevel()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: ""),
      body: Stack(
        children: [
          if (initialCameraPosition != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: showSheet ? 240 : 0,
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition!,
                markers: jobMarkers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                padding: EdgeInsets.only(
                  bottom: showSheet ? 40 : 70,
                  right: 13,
                ),
                onTap: updateLatLng,
              ),
            ),
          if (showSheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
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
              ),
            ),
          if (isLoading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color.fromRGBO(0, 0, 0, 0.2),
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: AppColors.blue),
            ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          showSheet
              ? null
              : FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: openSheet,
                child: SvgPicture.asset(AppAssets.share),
              ),
      // bottomSheet:
      //     showSheet
      //         ? SizedBox(
      //           height: 270,
      //           child: BottomSheetContainer(
      //             onClose: closeSheet,
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   children: [
      //                     SvgPicture.asset(AppAssets.share),
      //                     const SizedBox(width: 10),
      //                     Text(
      //                       "Set Distance",
      //                       style: const TextStyle(
      //                         fontSize: 26,
      //                         fontWeight: FontWeight.w500,
      //                         color: AppColors.lighterBlack,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 18),
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             "Set distance within 10 miles",
      //                             style: const TextStyle(
      //                               fontSize: 16,
      //                               fontWeight: FontWeight.w400,
      //                               color: AppColors.lighterBlack,
      //                             ),
      //                           ),
      //                           const SizedBox(height: 4),
      //                           Row(
      //                             children: [
      //                               SetDistanceItem(
      //                                 image: AppAssets.clock,
      //                                 title: time,
      //                               ),
      //                               const SizedBox(width: 10),
      //                               SetDistanceItem(
      //                                 image: AppAssets.miles,
      //                                 title: "${mile.toInt()} miles",
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     const SizedBox(width: 10),
      //                     MileActionItem(
      //                       isIncrement: false,
      //                       onPressed: decrementMile,
      //                     ),
      //                     const SizedBox(width: 10),
      //                     MileActionItem(
      //                       isIncrement: true,
      //                       onPressed: incrementMile,
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 20),

      //                 SizedBox(
      //                   height: 15,
      //                   child: SliderTheme(
      //                     data: SliderTheme.of(context).copyWith(
      //                       padding: const EdgeInsets.all(0),
      //                       inactiveTrackColor: const Color(0xFFF2F2F2),
      //                       activeTrackColor: const Color(0xFF2C58B8),
      //                       thumbColor: const Color(0xFF2C58B8),
      //                       thumbShape: RoundSliderThumbShape(
      //                         enabledThumbRadius: 6.0,
      //                       ), // Adjust size
      //                     ),
      //                     child: Slider.adaptive(
      //                       min: 0,
      //                       max: maxMiles,
      //                       value: mile,
      //                       onChanged: updateMile,
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(height: 20),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: List.generate(miles.length, (index) {
      //                     final mile = miles[index];
      //                     return MileItem(
      //                       selected: selectedMileIndex == index,
      //                       index: index,
      //                       mile: mile,
      //                       onChanged: updateSelectedMiles,
      //                     );
      //                   }),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         )
      //         : null,
    );
  }
}
