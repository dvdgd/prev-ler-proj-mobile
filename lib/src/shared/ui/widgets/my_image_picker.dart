import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({
    super.key,
    required this.imagePathController,
    this.text,
  });

  final TextEditingController imagePathController;
  final Text? text;

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final imagePicker = ImagePicker();
  File? imageFile;
  final double heigth = 450;

  void openImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
      widget.imagePathController.text = pickedFile.path;
    }
  }

  void clearImage() {
    setState(() => imageFile = null);
    widget.imagePathController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          MyCard(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            elevation: 0,
            padding: const EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            child: imageFile == null ? _imageCover : _imageWidget,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: clearImage,
                child: const Text('Excluir'),
              ),
              OutlinedButton.icon(
                onPressed: openImage,
                label: const Text('Selecionar'),
                icon: const Icon(Icons.image),
              ),
            ],
          )
        ],
      ),
    );
  }

  get _imageWidget => Container(
        height: heigth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.file(
          imageFile!,
          fit: BoxFit.cover,
        ),
      );

  get _imageCover => SizedBox(
        height: heigth,
        child: Center(
          child: widget.text ?? const Text('Selecione uma imagem'),
        ),
      );
}
