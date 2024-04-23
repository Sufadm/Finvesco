import 'dart:io';
import 'package:finvesco/utils/const/sizedbox.dart';
import 'package:flutter/material.dart';
import '../utils/const/text__styles.dart';

class StudentListDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String email;
  final String gender;
  final String qualification;
  final List<String> languages;

  const StudentListDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.qualification,
    required this.languages,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.file(File(image)),
                ),
                height10,
                Text(
                  "Name: $name",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
                height10,
                Text("Gender: $gender", style: tStyle),
                height10,
                Text(
                  "Email: $email",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
                height10,
                Text("Qualification:$qualification", style: tStyle),
                height10,
                const Text(
                  'Languages:',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 20,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Text(" , "),
                    scrollDirection: Axis.horizontal,
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            languages[index],
                            style: tStyle,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
