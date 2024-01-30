import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/components/home_page_card_style.dart';
import 'package:qr_code_scanner_and_generator/pages/generate_page.dart';
import 'package:qr_code_scanner_and_generator/pages/scan_page.dart';
import 'package:qr_code_scanner_and_generator/pages/upi_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[90],
      appBar: AppBar(
        title: const Text('Q R  C O D E '),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.blueGrey[100],
        elevation: null,
      ),
      body: SafeArea(
        child: Center(
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Scan or Generate',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey[800],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomePageCard(
                      icon: Icons.camera_alt_rounded,
                      title: 'Scan',
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ScanPage();
                        }));
                      },
                    ),
                    HomePageCard(
                      icon: Icons.qr_code_2_outlined,
                      title: 'Generate',
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const GeneratePage();
                        }));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Badge(
                      offset: Offset.zero,
                      label: const Text('New'),
                      isLabelVisible: true,
                      alignment: Alignment.topLeft,
                      backgroundColor: Colors.blue,
                      largeSize: 30,
                      child: HomePageCard(
                        icon: Icons.qr_code_rounded,
                        title: 'UPI QR',
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const UpiQr();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
