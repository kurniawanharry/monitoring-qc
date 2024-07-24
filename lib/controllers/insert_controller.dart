import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/client/monitoring_client.dart';
import 'package:monitoring/models/monitoring_model.dart';

class InsertController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController noController = TextEditingController();
  TextEditingController pecController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();

  RxString currentImage = ''.obs;
  RxString currentImageUrl = ''.obs;
  RxBool loading = false.obs;
  RxBool withBoq = false.obs;
  RxBool withPole = false.obs;
  RxBool withCable = false.obs;
  RxBool withAccessories = false.obs;
  RxBool currentStatus = false.obs;
  RxString selectedMitra = 'GMT'.obs;

  Rx<DateTime> currentDate = DateTime.now().obs;

  final MonitoringClient _client = MonitoringClient();

  bool isUpdated = false;

  String? _currentId;

  RxBool loadingScreen = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      loadingScreen(true);
      isUpdated = true;
      var model = Get.arguments as MonitoringModel;

      _currentId = model.id;
      noController.text = model.noProject ?? '';
      pecController.text = model.pic ?? '';
      dateController.text = model.date ?? '';
      descController.text = model.desc ?? '';
      selectedMitra.value = model.mitra ?? 'GMT';
      withBoq.value = model.boq ?? false;
      withCable.value = model.cable ?? false;
      withPole.value = model.pole ?? false;
      withAccessories.value = model.accessories ?? false;
      currentImageUrl.value = model.image ?? '';
      currentStatus.value = model.status ?? false;

      Future.delayed(const Duration(seconds: 1)).then((_) {
        loadingScreen(false);
      });
    }
    super.onInit();
  }

  Future insert() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var createdAt = convertDateTimeToUtcString();

    String image = '';
    if (isUpdated) {
      if (currentImage.isNotEmpty) {
        image = await uploadImageToFirebase(File(currentImage.value));
      } else {
        image = currentImageUrl.value;
      }
    } else if (currentImage.isNotEmpty) {
      image = await uploadImageToFirebase(File(currentImage.value));
    }

    MonitoringModel request = MonitoringModel(
      noProject: noController.value.text,
      pic: pecController.value.text,
      mitra: selectedMitra.value,
      boq: withBoq.value,
      cable: withBoq.value,
      pole: withPole.value,
      desc: descController.value.text,
      date: dateController.value.text,
      image: image,
      accessories: withAccessories.value,
      createdAt: createdAt,
      status: currentStatus.value,
      createdBy: auth.currentUser?.uid,
    );
    if (isUpdated) {
      var result = await _client.updateMonitoring(_currentId!, request);
      if (result ?? false) {
        Get.back(result: true);
      }

      return;
    }
    var result = await _client.setMonitoring(request);
    if (result ?? false) {
      Get.back(result: true);
    }
  }

  submit() async {
    if (!formkey.currentState!.validate()) {
      return;
    }

    loading(true);
    await insert();
    loading(false);
  }

  Future<String?>? _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    } else {
      return pickedFile.path;
    }
  }

  pickImage() async {
    var image = await _pickImage();
    if (image != null) {
      currentImage.value = image;
    }
  }

  selectDate() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    dateController.text = formatter.format(currentDate.value);
    update();
  }

  updateCurrentDate(DateTime newDate) {
    currentDate.value = newDate;
  }

  updateDropdown(String value) {
    selectedMitra.value = value;
  }

  toggleBoq() => withBoq.value = !withBoq.value;
  togglePole() => withPole.value = !withPole.value;
  toggleCable() => withCable.value = !withCable.value;
  toggleAccessories() => withAccessories.value = !withAccessories.value;
  toggleStatus() => currentStatus.value = !currentStatus.value;

  Future uploadImageToFirebase(File imageFile) async {
    String imageName = 'image_${getCurrentFormattedDate()}.jpg';
    final path = 'files/$imageName';
    final file = File(imageFile.path);

    final storageRef = FirebaseStorage.instance.ref().child(path);

    try {
      await storageRef.putFile(file);

      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print(e.toString());
    }
  }
}

String getCurrentFormattedDate() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyyMMdd_HHmmss');
  return formatter.format(now);
}

String convertDateTimeToUtcString() {
  DateTime now = DateTime.now();
  // Format the DateTime object as a string in UTC format
  String formattedDate = now.toIso8601String();

  return formattedDate;
}

List mitraList = ['GMT', 'IFT', 'MPP', 'SGT', 'DPA', 'ATM'];
