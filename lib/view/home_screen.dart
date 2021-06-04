import 'package:blog_app/controller/formController.dart';
import 'package:blog_app/model/blogs.dart';
import 'package:blog_app/size_config.dart';
import 'package:blog_app/view/categories_list.dart';
import 'package:blog_app/view/upload_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Blogs> blogsLists = [];

  @override
  void initState() {
    super.initState();
    formController.dbRef.child('blogs').once().then((DataSnapshot snapshot) {
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;
      blogsLists.clear();

      for (var individualKeys in KEYS) {
        Blogs blogs = Blogs(
          date: DATA[individualKeys]['date'],
          description: DATA[individualKeys]['description'],
          image: DATA[individualKeys]['image'],
          time: DATA[individualKeys]['time'],
          title: DATA[individualKeys]['title'],
        );

        setState(() {
          blogsLists.add(blogs);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(sizeConfig.mediumSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Blog App",
                      style: TextStyle(
                          fontSize: sizeConfig.defaultSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    categories_list(),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView.builder(
                  itemCount: blogsLists.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange[300],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(blogsLists[index].date!),
                              subtitle: Text(blogsLists[index].time!),
                              trailing: Icon(Icons.download_rounded),
                            ),
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    blogsLists[index].image!,
                                  ),
                                  fit: BoxFit.fill
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: ListTile(
                                title: Text(blogsLists[index].title!,),
                                subtitle: Text(blogsLists[index].description!,),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UploadImage()));
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.image_outlined),
      ),
    );
  }
}
