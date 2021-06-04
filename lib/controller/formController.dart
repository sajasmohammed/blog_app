import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class formController {
  static final picker = ImagePicker();
  static File? image;
  static String? url;

  static var dbTimeKey = DateTime.now();
  static var dateFormat = DateFormat('MMM d, yyyy');
  static var timeFormat = DateFormat('EEEE, hh:mm aaa');

  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();

  static dialogInformation(BuildContext context, String title, String body) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
      ),
    );
  }

  static var date = formController.dateFormat.format(formController.dbTimeKey);
  static var time = formController.timeFormat.format(formController.dbTimeKey);

  static final firebase_storage.Reference postImageref =
      firebase_storage.FirebaseStorage.instance.ref().child('blog images');
  static final firebase_storage.UploadTask uploadTask =
      postImageref.child(dbTimeKey.toString() + ".jpg").putFile(image!);

  static final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
}
