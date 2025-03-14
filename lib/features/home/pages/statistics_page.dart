import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/hire_container.dart';
import 'package:looking2hire/components/stat_card.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/views/stats_cards.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Statistics",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        centeredTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 30),

            HireContainer(
              title: "Decal Performance Overview",
              child: StatsCards(
                cards: [
                  StatCard(
                    title: "Total Applications",
                    value: "578",
                    icon: AppAssets.notepad,
                    onPressed: () {},
                  ),
                  StatCard(
                    title: "Conversation Rate",
                    value: "46%",
                    icon: AppAssets.statistics,
                    onPressed: () {},
                  ),
                  StatCard(
                    title: "Total Scans",
                    value: "1,245",
                    icon: AppAssets.search2,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            HireContainer(
              title: "Candidate Engagement Insights",
              child: StatsCards(
                cards: [
                  StatCard(
                    title: "Unique Visitors",
                    value: "890",
                    icon: AppAssets.users,
                    onPressed: () {},
                  ),
                  StatCard(
                    title: "Returning Users",
                    value: "320",
                    icon: AppAssets.reverse,
                    onPressed: () {},
                  ),
                  StatCard(
                    title: "Peak Engagement Time",
                    value: "2 PM - 6 PM",
                    icon: AppAssets.time,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
