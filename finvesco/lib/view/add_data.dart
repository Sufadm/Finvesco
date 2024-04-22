import 'package:finvesco/controller/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/data_add.dart';
import '../model/model.dart';

class AddData extends StatelessWidget {
  final AddDataController controller = Get.put(AddDataController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataAdd dataController = Get.put(DataAdd());
  AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Data'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 70,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Add photo")),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Name",
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  onChanged: (value) => dataController.name.value = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Email",
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  onChanged: (value) => dataController.email.value = value,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  subtitle: Obx(() => Row(
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
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Languages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  children: ['Telugu ', 'English', 'Hindi'].map((hobby) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(hobby),
                        Obx(() => Checkbox(
                              value: dataController.hobbies.contains(hobby),
                              onChanged: (value) =>
                                  dataController.toggleHobby(hobby),
                            )),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserModel user = UserModel(
                          photo: dataController.photo.value,
                          name: dataController.name.value,
                          email: dataController.email.value,
                          gender: dataController.gender.value,
                          qualification: dataController.qualification.value,
                          hobbies: dataController.hobbies.toList(),
                        );
                        controller.addDataAll(user);
                        Get.back();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
