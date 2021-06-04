import 'dart:io';
import 'package:blog_app/controller/formController.dart';
import 'package:blog_app/size_config.dart';
import 'package:blog_app/view/home_screen.dart';
import 'package:blog_app/wisgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await formController.picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        formController.image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No image selected")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey),
      body: Center(
        child: formController.image == null ? Text("Upload an image") : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.largeSize, vertical: sizeConfig.largeSize),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Image.file(
              formController.image!,
              height: 200,
              width: 300,
            ),
            cWidget.sizeBox(hieght: sizeConfig.mediumSize,),
            TextFormField(
              controller: formController.titleController,
              autofocus: true,
              validator: (_val) {
                if (_val!.isEmpty) {
                  return "Please enter title";
                }
                return null;
              },
              decoration: cWidget.inputDecoration(lableText: 'Title', hintText: 'Enter Title'),
            ),
            cWidget.sizeBox(hieght: sizeConfig.mediumSize,),
            TextFormField(
              controller: formController.descriptionController,
              autofocus: true,
              validator: (_val) {
                if (_val!.isEmpty) {
                  return "Please enter description";
                }
                return null;
              },
              decoration: cWidget.inputDecoration(lableText: 'Description', hintText: 'Enter Description')
            ),
            cWidget.sizeBox(hieght: sizeConfig.mediumSize,),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    uploadStatusImage();
                  }
                  return null;
                },
                child: Text("Upload"))
          ],
        ),
      ),
    );
  }

  void uploadStatusImage() async {
    final firebase_storage.UploadTask uploadTask =
        formController.postImageref.child(formController.dbTimeKey.toString() + ".jpg").putFile(formController.image!);

    var imageUrl = await (await uploadTask).ref.getDownloadURL();

    formController.url = imageUrl.toString();
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );

    formController.dialogInformation(
      context,
      'Add Blog',
      'Blog Uploaded Successfully',
    );
    

    formController.dbRef.child('blogs').push().set({
      'image': formController.url,
      'title': formController.titleController.text,
      'description': formController.descriptionController.text,
      'date': formController.date,
      'time': formController.time
    });
  }
}
