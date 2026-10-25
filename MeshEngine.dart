import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MeshEngine {
  static final FlutterBluePlus ble = FlutterBluePlus();

  // 1. Initialize BLE Scanning for Nearby SinNum Nodes
  static Future<void> startScanning(Function(ScanResult) onPeerFound) async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported on this device");
      return;
    }

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        onPeerFound(r);
      }
    });
  }

  // 2. Stop Scanning
  static void stopScanning() {
    FlutterBluePlus.stopScan();
  }
}
