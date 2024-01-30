import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/components/text_field.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class UpiQr extends StatefulWidget {
  const UpiQr({super.key});

  @override
  State<UpiQr> createState() => _UpiQrState();
}

class _UpiQrState extends State<UpiQr> {
  String? UpiId;
  String? payeeName;

  @override
  Widget build(BuildContext context) {
    String qrCodeImage = 'assets/images/bhimupi_logo.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI QR '),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  labelText: 'enter your upi id ',
                  maxLength: 100,
                  onSubmitted: (value) {
                    if (value.indexOf('@') > 0 &&
                        value.indexOf('@') < value.length - 1) {
                      setState(() {
                        UpiId = value;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  labelText: 'enter payee name ',
                  maxLength: 100,
                  onSubmitted: (value) {
                    setState(() {
                      payeeName = value;
                    });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                if (UpiId != null && payeeName != null)
                  UPIPaymentQRCode(
                    upiDetails: UPIDetails(
                      upiID: UpiId!,
                      payeeName: payeeName!,
                    ),
                    embeddedImagePath: qrCodeImage,
                    size: 300,
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
                if (UpiId != null && payeeName != null)
                  Text(
                    "Scan QR to Pay",
                    style:
                        TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
                  ),
                if (UpiId == null && payeeName == null)
                  Text("UPI Id And Payee Name Is Missing!!!"),
                if (UpiId == null && payeeName != null)
                  Text("UPI Id Is Missing Or You Put Wrong UPI Id!!!!"),
                if (payeeName == null && UpiId != null)
                  Text("Payee Name Is Missing."),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
