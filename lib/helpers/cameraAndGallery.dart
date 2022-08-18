import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future<XFile?> openGallery(BuildContext context) async {
  final XFile? image =
      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
  return image;
}

Future<XFile?> openCamera(BuildContext context) async {
  final XFile? photo =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);
  return photo;
}




/*PickedFile? _picture;

Future<PickedFile?> openGallery(BuildContext context) async {
  _picture = (await ImagePicker().pickImage(source: ImageSource.gallery)) as PickedFile?;
  //Navigator.of(context).pop();
  return _picture;
}

Future<PickedFile?> openCamera(BuildContext context) async {
  _picture = (await ImagePicker().pickImage(source: ImageSource.camera)) as PickedFile?;
  //Navigator.of(context).pop();
  return _picture;
}*/
