import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:looking2hire/service/file_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class UploadCvScreen extends StatefulWidget {
  const UploadCvScreen({super.key});

  @override
  State<UploadCvScreen> createState() => _UploadCvScreenState();
}

class _UploadCvScreenState extends State<UploadCvScreen> {
  File? pdfFile;

  void selectPdf() async {
    pdfFile = await pickPdfFile();
    if (pdfFile != null) {
      // print('Selected PDF: ${pdfFile?.parent.path}');
      setState(() {});
    } else {
      print('No file selected');
    }
  }

  @override
  void initState() {
    super.initState();
    nfcSection();
  }

  Future<void> nfcSection() async {
    // Check availability
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      print("NFC is available");
    } else {
      print("NFC is not available");
    }

    // Start Session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Do something with an NfcTag instance.
        print(tag.data.values);
      },
    );

    // Stop Session
    //     NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCProvider(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Looking To Work",
          arrowColor: AppColor.black,
          centeredTitle: true,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          rightChild: IconButton(
            icon: SvgPicture.asset(AppAssets.menu),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Consumer<NFCProvider>(
              //     builder: (_, provider, __){
              //       if(provider.isProcessing){
              //         return const Center(child: CircularProgressIndicator());
              //       }
              //       if(provider.message.isNotEmpty){
              //         return CustomText(text: provider.message, textSize: 16, fontWeight: FontWeight.w400);
              //       }
              //       return Container();
              //     }),
              SizedBox(height: 56),
              CustomRobotoText(
                text: "Upload Your CV",
                textSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 15),
              CustomText(
                text:
                    "Let AI enhance your profile by extracting key details from your resume.",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              SizedBox(height: 29),
              GestureDetector(
                onTap: () {
                  selectPdf();
                  // Provider.of<NFCProvider>(context, listen: false).startNFCOperation(operation: NFCOperation.read);
                },
                child: CustomLabelInputText(
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: "",
                  enabled: false,
                  placeholder:
                      pdfFile?.path.split("/").last ??
                      "Select and upload your CV in PDF/DOC format",
                ),
              ),
              SizedBox(height: 8),
              CustomText(
                text:
                    "Our AI will analyze your CV and automatically fill in your profile details, saving you time!",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
