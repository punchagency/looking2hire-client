import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/features/home/widgets/recent_search_item.dart';
import 'package:looking2hire/reuseable/extensions.dart';

import '../../../resusable/widgets/outlined_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> recentSearches = [];
  String selectedSearch = "";

  void updateSearch(String search) {
    selectedSearch = search;
    setState(() {});
  }

  void viewAllJobs() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedContainer(
                  child: Row(
                    children: [
                      Image.asset("search".toSvg),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Search jobs within 10 miles",
                          style: TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset("search".toSvg),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              OutlinedContainer(child: Container())
            ],
          ),
          const SizedBox(height: 11),
          Text(
            "Recent searches",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentSearches.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 5);
              },
              itemBuilder: (context, index) {
                final search = recentSearches[index];
                return RecentSearchItem(
                    title: search,
                    selected: selectedSearch == search,
                    onPressed: () => updateSearch(search));
              },
            ),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Popular jobs",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: viewAllJobs,
                child: Text(
                  "View all",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
