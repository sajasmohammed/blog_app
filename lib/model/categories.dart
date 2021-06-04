import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories {
  Categories({required this.title, required this.icon});
  String? title;
  IconData? icon;

}

   final listCategories = [
    Categories(title: 'Technology', icon: Icons.computer),
    Categories(title: 'Education', icon: Icons.cast_for_education),
    Categories(title: 'Movies', icon: Icons.movie),
    Categories(title: 'Actors', icon: Icons.person),
  ];