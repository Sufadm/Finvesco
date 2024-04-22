import 'package:finvesco/model/model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddDataController extends GetxController {
  RxList<UserModel> modelProvider = <UserModel>[].obs;

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  Future<void> addDataAll(UserModel value) async {
    final resumeData = await Hive.openBox<UserModel>("student");
    final resumeId = await resumeData.add(value);
    value.id = resumeId;
    modelProvider.add(value);
  }

  Future<void> getAllData() async {
    final dataDB = await Hive.openBox<UserModel>("student");
    modelProvider.assignAll(dataDB.values.toList());
  }

  Future<void> editData(int id, UserModel value) async {
    final dataDB = await Hive.openBox<UserModel>("student");
    dataDB.putAt(id, value);
    getAllData();
  }

  Future<void> delete(int id) async {
    final dataDB = await Hive.openBox<UserModel>("student");
    dataDB.deleteAt(id);
    getAllData();
  }
}
