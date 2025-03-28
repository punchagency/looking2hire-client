import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/app_progress_bar.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/extensions/scroll_controller_extensions.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';

import 'package:looking2hire/features/profile/components/profile_card.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../home/models/nfc_employer_jobs.dart';
import '../home/widgets/active_job_item.dart';

class NFCCompanyProfilePage extends StatefulWidget {
  static const String routeName = '/employerprofile';
  const NFCCompanyProfilePage({super.key});

  @override
  State<NFCCompanyProfilePage> createState() => _NFCCompanyProfilePageState();
}

class _NFCCompanyProfilePageState extends State<NFCCompanyProfilePage> {
  final ScrollController _scrollController = ScrollController();

  void getJobs() async {
    // isLoading = true;
    // setState(() {});
    await Future.delayed(const Duration(milliseconds: 300));

    final jobProvider = context.read<JobProvider>();
    //jobPosts =
    await jobProvider.getJobPosts() ?? [];

    _scrollController.addOnScrollEndListener(() {
      jobProvider.getMoreJobPosts();
    });
  }

  void getEmployer() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // if (args == null) {
    //   print(
    //     "args:-:-:-:--::-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:NO ARGS:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:--:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-: ",
    //   );
    // } else {
    //   print(
    //     "args:-:-:-:--::-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:ARGS:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:--:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-: $args",
    //   );
    // }

    final userProvider = context.read<UserProvider>();
    await userProvider.getNFCEmployerProfile(id: args?['id'] ?? "");
    await userProvider.getNFCEmployerJobs(id: args?['id'] ?? "", page: 1);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getJobs();
    // getEmployer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getEmployer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 200) {}
  // }

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.watch<UserProvider>();
    // final employer = userProvider.employer;
    // Retrieve the arguments passed to this route
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: args?['name'] ?? "",
            // title: appTitle,
            // arrowColor: AppColor.arrowColor,
            centeredTitle: false,
            fontWeight: FontWeight.w600,
            needsDrawer: true,
            canNotGoBack: true,
          ),

          body: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NFCProfileCard(
                  name: provider.nfcEmployerProfile.employer?.companyName ?? "",
                  address: provider.nfcEmployerProfile.employer?.address ?? "",
                  imageUrl:
                      provider.nfcEmployerProfile.employer?.companyLogo ?? "",
                  onEdit: () {},
                ),

                if ((provider.nfcEmployerProfile.employer?.heading ?? "")
                    .isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    provider.nfcEmployerProfile.employer?.heading ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
                if ((provider.nfcEmployerProfile.employer?.body ?? "")
                    .isNotEmpty) ...[
                  const SizedBox(height: 11),
                  Text(
                    provider.nfcEmployerProfile.employer?.body ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],

                // const SizedBox(height: 11),
                // Text(
                //   "Come make an impact that's uniquely you.",
                //   style: const TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //     color: AppColors.lightBlack,
                //   ),
                // ),
                // if (jobProvider.isLoading) ...[
                //   const SizedBox(height: 20),
                //   Center(child: const AppProgressBar()),
                //   const SizedBox(height: 20),
                // ] else ...[
                SizedBox(height: 35),
                const SizedBox(height: 20),
                Text(
                  "Our Active Jobs",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 14),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.nfcEmployerJobs.jobs?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 26);
                  },
                  itemBuilder: (context, index) {
                    final job = provider.nfcEmployerJobs.jobs?[index];
                    return NFCActiveJobItem(job: job ?? Job(), onPressed: () {});
                  },
                ),

                SizedBox(height: 35),

                //],
                if (provider.nfcEmployerJobs.jobs != null && provider.nfcEmployerJobs.jobs!.isEmpty) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/lottie/empty.json',
                          height: 200.0,
                          // width: 80,
                          repeat: true,
                          // reverse: true,
                          animate: true,
                        ),
                        const Text(
                          "No Job Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlack,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                if (provider.isLoading) ...[
                  const SizedBox(height: 20),
                  Center(child: const AppProgressBar()),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
