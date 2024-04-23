import 'dart:io';
import 'package:finvesco/controller/db_service.dart';
import 'package:finvesco/view/data_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'list_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(AddDataController());
    AddDataController().getAllData();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(AddData()),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: GetBuilder<AddDataController>(
        builder: (controller) {
          try {
            final datas = controller.modelProvider;
            if (datas.isEmpty) {
              return const Center(child: Text("No data"));
            }
            return ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final data = datas[index];
                return GestureDetector(
                  onTap: () => Get.to(StudentListDetailsPage(
                      image: data.photo,
                      name: data.name,
                      email: data.email,
                      gender: data.gender,
                      qualification: data.qualification,
                      languages: data.languages)),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                      title: Text(data.name),
                      subtitle: Text(data.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(AddData(
                                index: index,
                                editData: data,
                              ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Confirmation",
                                content: const Text(
                                  "Are you sure you want to delete this item?",
                                ),
                                textConfirm: "Delete",
                                onConfirm: () {
                                  controller.delete(index);
                                  Get.back();
                                  Get.snackbar(
                                    datas[index].name,
                                    "Removed",
                                  );
                                },
                                textCancel: "Cancel",
                                onCancel: () {},
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } catch (e) {
            return const Center(
              child: Text("Pls Try Again"),
            );
          }
        },
      ),
    );
  }
}
