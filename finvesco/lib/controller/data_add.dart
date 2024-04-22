import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DataAdd extends GetxController {
  RxString photo = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString gender = RxString('Male');
  RxString qualification = RxString('Plus 2');
  RxList<String> hobbies = <String>[].obs;
  Rx<File?> image = Rx<File?>(null);

  void toggleGender(String value) {
    gender.value = value;
  }

  void toggleHobby(String hobby) {
    if (hobbies.contains(hobby)) {
      hobbies.remove(hobby);
    } else {
      hobbies.add(hobby);
    }
  }

  void setQualification(String value) {
    qualification.value = value;
  }

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageFile = File(pickedImage.path);
      image.value = imageFile;
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
