import 'package:finvesco/controller/db_service.dart';
import 'package:finvesco/utils/const/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_add_controller.dart';
import '../model/model.dart';
import 'dart:io';

class AddData extends StatelessWidget {
  final int? index;
  final UserModel? editData;

  AddData({this.editData, super.key, this.index});
  final AddDataController controller = Get.put(AddDataController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataAdd dataController = Get.put(DataAdd());

  @override
  Widget build(BuildContext context) {
    dataController.onClose();

    final bool isEditMode = editData != null;
    if (isEditMode) {
      dataController.image.value = File(editData!.photo);
      dataController.name.value = editData!.name;
      dataController.email.value = editData!.email;
      dataController.gender.value = editData!.gender;
      dataController.qualification.value = editData!.qualification;
      dataController.languages.assignAll(editData!.languages);
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Display image
                Obx(
                  () {
                    final image = dataController.image.value;
                    return image != null
                        ? Center(
                            child: CircleAvatar(
                              backgroundImage: FileImage(image),
                              radius: 70,
                            ),
                          )
                        : const Center(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://images.freeimages.com/image/previews/374/instabutton-png-design-5690390.png?fmt=webp&w=500",
                              ),
                              radius: 70,
                            ),
                          );
                  },
                ),
                const SizedBox(height: 5),
                // Button to add photo
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      dataController.getPhoto();
                    },
                    child: const Text("Add photo"),
                  ),
                ),
                const SizedBox(height: 15),
                // Full Name text field
                const Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  initialValue: isEditMode ? editData!.name : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Name",
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) => dataController.name.value = value,
                ),
                height10, // Email text field
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  initialValue:
                      isEditMode && editData != null ? editData!.email : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Email",
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) => dataController.email.value = value,
                  keyboardType: TextInputType.emailAddress,
                ),

                height10, // Gender selection
                const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  subtitle: Obx(
                    () => Row(
                      children: [
                        const Text('Male'),
                        createRadio(
                          value: 'Male',
                          groupValue: dataController.gender.value,
                          onChanged: (value) =>
                              dataController.toggleGender(value!),
                        ),
                        const Text('Female'),
                        createRadio(
                          value: 'Female',
                          groupValue: dataController.gender.value,
                          onChanged: (value) =>
                              dataController.toggleGender(value!),
                        ),
                      ],
                    ),
                  ),
                ),
                height10, // Qualification selection
                const Text(
                  "Qualification",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  leading: Obx(
                    () => DropdownButton<String>(
                      value: dataController.qualification.value,
                      onChanged: (value) {
                        dataController.setQualification(value!);
                      },
                      items: ['Plus 2', 'Degree']
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                height10, // Language selection
                const Text(
                  "Languages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  children: ['Telugu', 'English', 'Hindi'].map((hobby) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(hobby),
                        Obx(
                          () => Checkbox(
                            value: dataController.languages.contains(hobby),
                            onChanged: (value) =>
                                dataController.toggleHobby(hobby),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                height10, const Spacer(),
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (dataController.image.value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please add a profile photo"),
                            ),
                          );
                          return;
                        }
                        if (dataController.languages.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please select at least one language"),
                            ),
                          );
                          return;
                        }
                        UserModel user = UserModel(
                          photo: dataController.image.value?.path ?? '',
                          name: dataController.name.value,
                          email: dataController.email.value,
                          gender: dataController.gender.value,
                          qualification: dataController.qualification.value,
                          languages: dataController.languages.toList(),
                        );
                        if (isEditMode) {
                          await controller.editData(index!, user);
                          Get.back();
                          Get.snackbar("Success", "Data saved succesfully",
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          await controller.addDataAll(user);
                          Get.back();
                          Get.snackbar("Success", "Data Added succesfully",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      }
                    },
                    child: Text(isEditMode ? 'Save' : 'Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to create Radio button
  Radio<String> createRadio({
    required String value,
    required String? groupValue,
    required void Function(String?) onChanged,
  }) {
    return Radio<String>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }
}
