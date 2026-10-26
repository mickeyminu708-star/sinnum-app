
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MeshEngine {
  static Future<void> startScanning(
    Function(ScanResult) onPeerFound,
  ) async {
    if (!await FlutterBluePlus.isSupported) {
      print('Bluetooth not supported on this device');
      return;
    }

    FlutterBluePlus.scanResults.listen((results) {
      for (final result in results) {
        onPeerFound(result);
      }
    });

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
    );
  }

  static Future<void> stopScanning() async {
    await FlutterBluePlus.stopScan();
  }
}
