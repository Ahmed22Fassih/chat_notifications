import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImage(this.imagePickFn);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _pickedImage;
  final ImagePicker picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await ImagePicker().getImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
    } else {
      print("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _pickImage(ImageSource.camera),
              icon: Icon(Icons.photo_camera),
              label: Text(
                'Add Image\nfromCamera',
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: Icon(Icons.photo_camera),
              label: Text(
                'Add Image\nfromCamera',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
