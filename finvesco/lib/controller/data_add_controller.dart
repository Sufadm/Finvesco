import 'dart:io';
import 'package:finvesco/model/model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DataAdd extends GetxController {
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString gender = RxString('Male');
  RxString qualification = RxString('Plus 2');
  RxList<String> languages = <String>[].obs;
  Rx<File?> image = Rx<File?>(null);

  @override
  void onClose() {
    image.value = null;
    gender.value = '';
    languages.clear();
    super.onClose();
  }

  void toggleGender(String value) {
    gender.value = value;
  }

  void toggleHobby(String hobby) {
    if (languages.contains(hobby)) {
      languages.remove(hobby);
    } else {
      languages.add(hobby);
    }
  }

  void setQualification(String value) {
    qualification.value = value;
  }

  Future<void> getPhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      final photoTemp = File(pickedFile.path);
      image.value = photoTemp;
    }
  }

  void initEditData(UserModel editData) {
    image.value = File(editData.photo);
    name.value = editData.name;
    email.value = editData.email;
    gender.value = editData.gender;
    qualification.value = editData.qualification;
    languages.assignAll(editData.languages);
  }
}
