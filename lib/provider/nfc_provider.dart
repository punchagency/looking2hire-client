import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCProvider extends ChangeNotifier {
  bool isNfcAvailable = false;
  bool isNfcEnabled = false;

  bool isProcessing = false;
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
      notifyListeners();
    }
  }

  Future<void> startNFCOperation({
    required NFCOperation operation,
    String dataType = '',
  }) async {
    try {
      isProcessing = true;
      notifyListeners();
      await checkNfcAvailability();

      if (isNfcAvailable) {
        if (operation == NFCOperation.read) {
          // await startNFCOperation(operation: NFCOperation.read);

          message = 'Scanning...';
        } else {
          // await startNFCOperation(operation: NFCOperation.write);
          message = 'Writing to NFC...';
        }
        notifyListeners();
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Do something with an NfcTag instance.
            print(tag.data.values);
            if (operation == NFCOperation.read) {
              readFromTag(tag: tag);
            } else {
              writeToTag(tag: tag, dataType: dataType);
            }
            isProcessing = false;
            notifyListeners();

            await NfcManager.instance.stopSession();
          },
          onError: (e) async {
            message = e.toString();
            isProcessing = false;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      message = e.toString();
      isProcessing = false;
      notifyListeners();
    }
  }

  void readFromTag({required NfcTag tag}) {
    Map<String, dynamic> data = {
      "nfca": tag.data['nfca'],
      "mifareultralight": tag.data['mifareultralight'],
      "ndef": tag.data['ndef'],
    };

    String? decodeText;

    // if(data.containsKey("ndef")){
    //   List<int> payload = data['ndef']['cachedMessage']['records'][0]['payload'];
    //   String text = String.fromCharCodes(payload);
    //   decodeText = text.substring(3);
    // }
    // else{
    //   List<int> payload = data['mifareultralight']['payload'];
    //   String text = String.fromCharCodes(payload);
    //   decodeText = text.substring(3);
    // }
    // message = decodeText ?? 'No data found';
    // message =  tag.data.toString();
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
}

enum NFCOperation { read, write }
