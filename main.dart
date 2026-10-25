import 'package:flutter/material.dart';
import 'MeshEngine.dart';
import 'CryptoEngine.dart';
import 'DatabaseEngine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseEngine.initDatabase();
  runApp(const SinNumApp());
}

class SinNumApp extends StatelessWidget {
  const SinNumApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SinNum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF38BDF8),
      ),
      home: const MeshHomeScreen(),
    );
  }
}

class MeshHomeScreen extends StatefulWidget {
  const MeshHomeScreen({Key? key}) : super(key: key);

  @override
  State<MeshHomeScreen> createState() => _MeshHomeScreenState();
}

class _MeshHomeScreenState extends State<MeshHomeScreen> {
  List<String> discoveredPeers = [];
  bool isScanning = false;

  void startMeshScan() {
    setState(() {
      isScanning = true;
      discoveredPeers.clear();
    });

    MeshEngine.startScanning((result) {
      setState(() {
        String peerName = result.device.platformName.isNotEmpty 
            ? result.device.platformName 
            : "Unknown Node (${result.device.remoteId})";
        if (!discoveredPeers.contains(peerName)) {
          discoveredPeers.add(peerName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛡️ SinNum [Off-Grid P2P]'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Node ID: #SN-9284', style: TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.bold)),
                  Text('🔒 Zero Server', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: startMeshScan,
              icon: const Icon(Icons.radar),
              label: Text(isScanning ? 'Scanning Nearby Nodes...' : 'Start P2P Mesh Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF38BDF8),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Nearby Disconnected Nodes:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: discoveredPeers.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF1E293B),
                    child: ListTile(
                      leading: const Icon(Icons.phone_android, color: Color(0xFF38BDF8)),
                      title: Text(discoveredPeers[index]),
                      subtitle: const Text('Encrypted Mesh Peer'),
                      trailing: const Text('Connect', style: TextStyle(color: Colors.green)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
