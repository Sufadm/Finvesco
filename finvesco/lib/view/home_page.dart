import 'dart:io';
import 'package:finvesco/controller/service.dart';
import 'package:finvesco/view/add_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            return Expanded(
              child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                      title: Text(data.name),
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
                              controller.delete(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } catch (e) {
            return Center(
              child: Text("Error: $e"),
            );
          }
        },
      ),
    );
  }
}
