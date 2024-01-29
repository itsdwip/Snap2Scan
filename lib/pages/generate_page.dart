import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_scanner_and_generator/components/text_field.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  String? qrData;
  XFile? pickedImage;
  String currentQrDecorationImagePosition = 'embedded';
  PrettyQrDecorationImagePosition position =
      PrettyQrDecorationImagePosition.embedded;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR CODE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                TextFieldWidget(
                  maxLength: 1111,
                  labelText: 'Enter here to generate QR Code',
                  onSubmitted: (value) {
                    setState(() {
                      qrData = value;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: pickImage,
                        child: Text('Choose Image'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      DropdownButton<PrettyQrDecorationImagePosition>(
                        value: position,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        onChanged: (newPosition) {
                          setState(() {
                            position = newPosition!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: PrettyQrDecorationImagePosition.embedded,
                            child: Text('Embedded'),
                          ),
                          DropdownMenuItem(
                            value: PrettyQrDecorationImagePosition.foreground,
                            child: Text('Foreground'),
                          ),
                          DropdownMenuItem(
                            value: PrettyQrDecorationImagePosition.background,
                            child: Text('Background'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                if (qrData != null)
                  FittedBox(
                    child: SizedBox(
                      height: 500,
                      width: 500,
                      child: PrettyQrView.data(
                        data: qrData!,
                        decoration: PrettyQrDecoration(
                          image: pickedImage != null
                              ? PrettyQrDecorationImage(
                                  image: FileImage(
                                    File(pickedImage!.path),
                                  ),
                                  position: position,
                                )
                              : null,
                          shape: const PrettyQrSmoothSymbol(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
