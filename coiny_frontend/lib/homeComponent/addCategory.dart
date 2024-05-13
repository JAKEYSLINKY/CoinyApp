import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/addCategory.dart';

class addCategory extends StatelessWidget {
  const addCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AddCategoryDialog());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFEDB59E),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
