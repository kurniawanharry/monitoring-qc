import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring/controllers/insert_controller.dart';

class InsertPage extends GetView<InsertController> {
  const InsertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Insert Data'),
          ),
          body: GetX<InsertController>(
            builder: (controller) {
              if (controller.loadingScreen.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Form(
                        key: controller.formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: controller.noController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'No. Project',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'No. Project masih kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.pecController,
                              decoration: InputDecoration(
                                labelText: 'PIC',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'PIC masih kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: controller.selectedMitra.value,
                              hint: const Text('Pilih Mitra'),
                              decoration: InputDecoration(
                                labelText: 'Mitra',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (newValue) =>
                                  controller.updateDropdown(newValue as String),
                              items: mitraList.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            Obx(() => SwitchListTile(
                                  title: const Text('BOQ'),
                                  value: controller.withBoq.value,
                                  onChanged: (value) => controller.toggleBoq(),
                                )),
                            const SizedBox(height: 10),
                            Obx(() => SwitchListTile(
                                  title: const Text('Kabel'),
                                  value: controller.withCable.value,
                                  onChanged: (value) => controller.toggleCable(),
                                )),
                            const SizedBox(height: 10),
                            Obx(() => SwitchListTile(
                                  title: const Text('Tiang'),
                                  value: controller.withPole.value,
                                  onChanged: (value) => controller.togglePole(),
                                )),
                            const SizedBox(height: 10),
                            Obx(() => SwitchListTile(
                                  title: const Text('Accessories'),
                                  value: controller.withAccessories.value,
                                  onChanged: (value) => controller.toggleAccessories(),
                                )),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.descController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Keterangan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Keterangan masih kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.dateController,
                              onTap: () => datePicker(context),
                              canRequestFocus: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Tanggal Pekerjaan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Email masih kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            Obx(() => SwitchListTile(
                                  title: const Text('Status'),
                                  value: controller.currentStatus.value,
                                  onChanged: (value) => controller.toggleStatus(),
                                )),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => controller.pickImage(),
                                    child: const Text('Upload Gambar'),
                                  ),
                                  Obx(
                                    () => Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: controller.isUpdated
                                              ? controller.currentImageUrl.isNotEmpty
                                                  ? NetworkImage(controller.currentImageUrl.value)
                                                      as ImageProvider
                                                  : FileImage(
                                                      File(controller.currentImage.value),
                                                    )
                                              : FileImage(
                                                  File(controller.currentImage.value),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.maxFinite, 50),
                          backgroundColor: Colors.pink.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => controller.submit(),
                        child: controller.loading.isFalse
                            ? const Text('Submit')
                            : const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  datePicker(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            color: Colors.white,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pilih Tanggal',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          controller.selectDate();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: controller.currentDate.value,
                      onDateTimeChanged: (DateTime newDate) =>
                          controller.updateCurrentDate(newDate),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).then((value) {
        FocusManager.instance.primaryFocus?.unfocus();
      });
}
