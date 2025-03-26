import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_decal/service/decal_service.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCProvider extends ChangeNotifier {
  final DecalService apiService = DecalService();

  final formKey = GlobalKey<FormState>();

  String errorMessage = "";
  String successMessage = "";
  bool isNfcAvailable = false;
  bool isNfcEnabled = false;

  bool isProcessing = false;
  bool isActive = false;
  String message = '';

  Future<void> checkNfcAvailability() async {
    isNfcAvailable = await NfcManager.instance.isAvailable();
    notifyListeners();
    if (isNfcAvailable) {
      message = 'Nfc is available';
      notifyListeners();
    } else {
      message = 'Please enable NFC from settings';
      isProcessing = false;
      setSnackBar(context: currentContext!, title: "NFC", message: message);
      notifyListeners();
    }
  }

  Future<void> startNFCOperation({
    required NFCOperation operation,
    String dataType = '',
    required PageController pageController,
  }) async {
    try {
      isProcessing = true;
      // notifyListeners();
      await checkNfcAvailability();

      if (isNfcAvailable) {
        // if (operation == NFCOperation.read) {
        //   // await startNFCOperation(operation: NFCOperation.read);

        //   message = 'Scanning...';
        // } else {
        //   // await startNFCOperation(operation: NFCOperation.write);
        //   message = 'Writing to NFC...';
        // }
        // notifyListeners();
        if (!isActive) {
          NfcManager.instance.startSession(
            onDiscovered: (NfcTag tag) async {
              if (operation == NFCOperation.read) {
                // readNewFromTag(tag);
                message = "NFC Tag found";
                isActive = true;

                if (pageController.page == 0) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }

                // setSnackBar(
                //   context: currentContext!,
                //   title: "Success",
                //   message: message,
                // );
                notifyListeners();
              }
              isProcessing = false;
              notifyListeners();

              // await NfcManager.instance.stopSession();
            },
            onError: (e) async {
              message = e.toString();
              isProcessing = false;
              notifyListeners();
            },
          );
        } else {
          activateNfc(
            operation: operation,
            url: "http://ayomilotunde.github.io",
            pageController: pageController,
          );
        }
      }
      // setSnackBar(context: currentContext!, title: "Success", message: message);
    } catch (e) {
      message = e.toString();
      isProcessing = false;
      setSnackBar(context: currentContext!, title: "Error", message: message);
      notifyListeners();
    }
  }

  Future<void> activateNfc({
    required NFCOperation operation,
    required String url,
    required PageController pageController,
  }) async {
    try {
      setProgressDialog();
      await checkNfcAvailability();

      if (isNfcAvailable) {
        if (operation == NFCOperation.read) {
          // await startNFCOperation(operation: NFCOperation.read);

          message = 'Reading from the NFC Tag...';
        } else {
          // await startNFCOperation(operation: NFCOperation.write);
          message = 'Writing to the NFC Tag...';
        }
        // setSnackBar(
        //   context: currentContext!,
        //   title: "Success",
        //   message: message,
        // );
        notifyListeners();
        await NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // message = "Tag found";
            if (isActive) {
              if (operation == NFCOperation.read) {
                readNewFromTag(tag);
              } else {
                writeNewToTag(tag, url);
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            }
            isProcessing = false;
            notifyListeners();

            await NfcManager.instance.stopSession();
            currentContext?.pop();
          },
          onError: (e) async {
            message = e.toString();
            isProcessing = false;
            currentContext?.pop();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      message = e.toString();
      isProcessing = false;
      setSnackBar(context: currentContext!, title: "Error", message: message);
      notifyListeners();
      currentContext?.pop();
    }
    // finally {
    //   currentContext?.pop();
    // }
  }

  void readFromTag({required NfcTag tag}) {
    Map<String, dynamic> data = {
      "nfca": tag.data['nfca'],
      "mifareultralight": tag.data['mifareultralight'],
      "ndef": tag.data['ndef'],
    };

    String? decodeText;

    if (data.containsKey("ndef")) {
      print(data['ndef']);
      // List<int> payload =
      //     data['ndef']['cachedMessage']['records'][0]['payload'];
      // String text = String.fromCharCodes(payload);
      // decodeText = text.substring(3);
    } else {
      List<int> payload = data['mifareultralight']['payload'];
      String text = String.fromCharCodes(payload);
      decodeText = text.substring(3);
    }
    message = decodeText ?? 'No data found';
    message = tag.data.toString();
    print(data);
    notifyListeners();
  }

  Future<void> writeToTag({
    required NfcTag tag,
    required String dataType,
  }) async {
    NdefMessage ndefMessage = createsNdefMessage(dataType: dataType);
    await Ndef.from(tag)?.write(ndefMessage);
    message = "DONE";
  }

  NdefMessage createsNdefMessage({required String dataType}) {
    switch (dataType) {
      case "URL":
        {
          NdefMessage([
            NdefRecord.createUri(Uri.parse("https://ayomilotunde.github.io")),
          ]);
        }
      case "MAIL":
        {
          NdefMessage([
            NdefRecord.createUri(Uri.parse("mailto:ayomilotunde02@gmail.com")),
          ]);
        }
      default:
        return const NdefMessage([]);
    }
    return NdefMessage([]);
  }

  Future<void> readNewFromTag(NfcTag tag) async {
    var data = tag.data;
    String? decodeText;

    if (data.containsKey('ndef')) {
      var ndefMessage = data['ndef']['cachedMessage'];
      if (ndefMessage != null) {
        var records = ndefMessage['records'];
        if (records != null && records.isNotEmpty) {
          List<int> payload = records[0]['payload'];
          String text = String.fromCharCodes(payload);
          // Skip first 3 bytes which contain language info
          decodeText = text.substring(3);
          if (decodeText != null && decodeText.startsWith('http')) {
            try {
              final Uri url = Uri.parse(decodeText);
              await NfcManager.instance.stopSession();

              await launchUrl(url, mode: LaunchMode.externalApplication);
            } catch (e) {
              print('Error launching URL: $e');
            }
          }
        }
      }
    } else if (data.containsKey('mifareultralight')) {
      List<int> payload = data['mifareultralight']['payload'];
      String text = String.fromCharCodes(payload);
      decodeText = text.substring(3);
    }

    message = decodeText ?? 'No data found';
    print("message: $message");
    notifyListeners();
  }

  Future<void> writeNewToTag(NfcTag tag, String text) async {
    try {
      var ndef = Ndef.from(tag);

      if (ndef == null) {
        message = 'Tag is not ndef writable';
        notifyListeners();
        return;
      }

      if (!ndef.isWritable) {
        message = 'Tag is not writable';
        notifyListeners();
        return;
      }

      NdefMessage ndefMessage = NdefMessage([NdefRecord.createText(text)]);

      try {
        await ndef.write(ndefMessage);
        message = 'Write successful';
      } catch (e) {
        message = 'Write failed: $e';
      }

      notifyListeners();
    } catch (e) {
      message = 'Error writing to tag: $e';
      notifyListeners();
    }
    setSnackBar(context: currentContext!, title: "Success", message: message);
  }

  // Future<void> blockNFCTag(NfcTag tag) async {
  //   try {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null) {
  //       message = 'Tag is not ndef compatible';
  //       notifyListeners();
  //       return;
  //     }
  //     if (!ndef.isWritable) {
  //       message = 'Tag is already locked';
  //       notifyListeners();
  //       return;
  //     }
  //     try {
  //       // Write a final message to make the tag read-only
  //       await ndef.write(NdefMessage([NdefRecord.createText('LOCKED')]));
  //       message = 'Tag locked successfully';
  //     } catch (e) {
  //       message = 'Failed to lock tag: $e';
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     message = 'Error locking tag: $e';
  //     notifyListeners();
  //   }
  //   setSnackBar(
  //     context: currentContext!,
  //     title: "Lock Status",
  //     message: message,
  //   );
  // }

  // API Calls

  Future<bool> createDecal({required String nfcTagId}) async {
    errorMessage = "";
    successMessage = "";

    try {
      setProgressDialog();

      final response = await apiService.createDecal(nfcTagId: nfcTagId);

      successMessage =
          response.data['message'] ?? "Successfully applied for job";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }
}

enum NFCOperation { read, write }
