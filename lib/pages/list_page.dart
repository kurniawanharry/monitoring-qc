import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monitoring/controllers/insert_controller.dart';
import 'package:monitoring/controllers/monitoring_controller.dart';
import 'package:monitoring/models/monitoring_model.dart';

class ListPage extends GetView<MonitoringController> {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getData('monitoring'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = MonitoringModel.fromDocumentSnapshot(doc);
              return ListTile(
                title: const Text('No. Project'),
                subtitle: Text(data.noProject ?? '-'),
                trailing: PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert_outlined),
                  onSelected: (result) async {
                    if (result == 0) {
                      Get.toNamed('/insert', arguments: data)?.then(
                        (value) => Get.delete<InsertController>(),
                      );
                    } else {
                      controller.deleteData(data.id ?? '');
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.edit_outlined),
                        title: Text('Edit'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.delete_outline),
                        title: Text('Hapus'),
                      ),
                    ),
                  ],
                ),
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('No. Project'),
                            trailing: Text(data.noProject ?? '-'),
                          ),
                          ListTile(
                            title: const Text('PIC'),
                            trailing: Text(data.pic ?? '-'),
                          ),
                          ListTile(
                            title: const Text('Mitra'),
                            trailing: Text(data.mitra ?? '-'),
                          ),
                          ListTile(
                            title: const Text('BOQ'),
                            trailing: Text(data.boq ?? false ? 'OK' : 'NOK'),
                          ),
                          ListTile(
                            title: const Text('Kabel'),
                            trailing: Text(data.cable ?? false ? 'OK' : 'NOK'),
                          ),
                          ListTile(
                            title: const Text('Tiang'),
                            trailing: Text(data.pole ?? false ? 'OK' : 'NOK'),
                          ),
                          ListTile(
                            title: const Text('Accessories'),
                            trailing: Text(data.accessories ?? false ? 'OK' : 'NOK'),
                          ),
                          ListTile(
                            title: const Text('Deskripsi'),
                            subtitle: Text(data.desc ?? '-'),
                          ),
                          ListTile(
                            title: const Text('Tanggal'),
                            subtitle: Text(data.date ?? '-'),
                          ),
                          ListTile(
                            title: const Text('Status'),
                            subtitle: Text(data.status ?? false ? 'OK' : 'NOK'),
                          ),
                          ListTile(
                            title: const Text('Gambar'),
                            trailing: data.image?.isNotEmpty ?? false
                                ? Image.network(
                                    data.image ?? '',
                                    fit: BoxFit.cover,
                                    height: 200,
                                  )
                                : const Text('No Image'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
