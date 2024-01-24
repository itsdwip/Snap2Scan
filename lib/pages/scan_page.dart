import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.grey,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return Icon(
                      Icons.camera_front,
                      color: Colors.grey,
                    );
                  case CameraFacing.back:
                    return Icon(
                      Icons.camera_rear,
                      color: Colors.grey,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          if (image != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Image(
                    image: MemoryImage(image),
                  ),
                  title: Text(
                    barcodes.first.rawValue ?? "",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  actions: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            label: Text('Copy'),
                            icon: Icon(Icons.copy),
                            onPressed: () => Clipboard.setData(
                              ClipboardData(
                                  text: barcodes.first.rawValue ?? ""),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.public),
                            label: Text('Search'),
                            onPressed: () async {
                              if (barcodes.first.rawValue != null) {
                                try {
                                  await launchUrl(Uri.parse(
                                      barcodes.first.rawValue.toString()));
                                } catch (error) {
                                  print("Error opening URL: $error");
                                }
                              }
                            },
                          ),
                          // Share button
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.share),
                            label: Text('Share'),
                            onPressed: () async {
                              await Share.share(barcodes.first.rawValue ?? "");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
