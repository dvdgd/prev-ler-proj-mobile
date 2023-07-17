import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

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
  late final MyConverter converter;
  final imagePicker = ImagePicker();
  Uint8List? imageBytes;
  final double heigth = 450;

  @override
  void initState() {
    super.initState();
    converter = MyConverter();

    if (widget.imagePathController.text.isNotEmpty) {
      imageBytes = MyConverter.base64Binary(widget.imagePathController.text);
    }
  }

  void openImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final bytes = await pickedFile.readAsBytes();
    final imageBase64 = await MyConverter.binaryToBase64(bytes);

    setState(() => imageBytes = bytes);
    widget.imagePathController.text = imageBase64;
  }

  void clearImage() {
    setState(() => imageBytes = null);
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
            child: imageBytes == null ? _imageCover : _imageWidget,
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
        child: Image.memory(
          imageBytes!,
        ),
      );

  get _imageCover => SizedBox(
        height: heigth,
        child: Center(
          child: widget.text ?? const Text('Selecione uma imagem'),
        ),
      );
}
