import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/provider/nfc_provider.dart';

import 'package:provider/provider.dart';

class ScanNfcPage extends StatefulWidget {
  const ScanNfcPage({super.key});

  @override
  State<ScanNfcPage> createState() => _ScanNfcPageState();
}

class _ScanNfcPageState extends State<ScanNfcPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NFCProvider>().isActive = true;
    context.read<NFCProvider>().startNFCOperation(
      operation: NFCOperation.read,
      pageController: PageController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NFCProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: ""),
          body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.nfcScan),
                const SizedBox(height: 50),
                Text(
                  "Scan NFC",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                Text(
                  "Hold your NFC sticker to the back of your phone",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757575),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
