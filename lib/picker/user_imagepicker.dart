import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Userimagepick extends StatefulWidget {
  Userimagepick(this.image);
  final void Function(File picker) image;
  @override
  _UserimagepickState createState() => _UserimagepickState();
}

class _UserimagepickState extends State<Userimagepick> {
  File imagepicked = File("");
  void pickimage() async {
    final picker = ImagePicker();
    final pickedimage = await picker.getImage(source: ImageSource.gallery,imageQuality: 50,);
    final pickedimagefile = File(pickedimage.path);
    setState(() {
      imagepicked = pickedimagefile;
    });
    widget.image(imagepicked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickimage != null ? FileImage(imagepicked) : null,
        ),
        FlatButton.icon(
          onPressed: pickimage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
