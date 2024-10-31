import 'package:flutter/material.dart';

class ImgField extends StatelessWidget {
  final TextEditingController controller;
  const ImgField({super.key, required this.controller});

  void _onPressed(BuildContext context) {
    // TODO Take photo and upload to server
    showDialog(
        context: context, builder: (context) => const Icon(Icons.camera_alt));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Text("img:"),
        const Spacer(),
        IconButton(
            onPressed: () {
              _onPressed(context);
            },
            icon: const Icon(Icons.camera_alt)),
      ],
    );
  }
}
