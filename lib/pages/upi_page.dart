import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class UpiQr extends StatefulWidget {
  const UpiQr({super.key});

  @override
  State<UpiQr> createState() => _UpiQrState();
}

class _UpiQrState extends State<UpiQr> {
  final upiDetailsWithoutAmount = UPIDetails(
    upiID: "deeppalta91@okaxis",
    payeeName: "deep",
    transactionNote: "hello",
  );

  @override
  Widget build(BuildContext context) {
    String qrCodeImage = 'assets/images/bhimupi_logo.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI QR '),
        centerTitle: true,
      ),
      body: Center(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UPIPaymentQRCode(
                upiDetails: upiDetailsWithoutAmount,
                embeddedImagePath: qrCodeImage,
                size: 220,
                embeddedImageSize: const Size(60, 60),
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Color.fromARGB(255, 41, 27, 27),
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Color.fromARGB(255, 35, 33, 52),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
