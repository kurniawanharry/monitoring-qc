import 'package:cloud_firestore/cloud_firestore.dart';

class MonitoringModel {
  String? id;
  String? noProject;
  String? pic;
  String? mitra;
  bool? boq;
  bool? pole;
  bool? cable;
  bool? accessories;
  bool? status;
  String? date;
  String? desc;
  String? image;
  String? createdAt;
  String? createdBy;

  MonitoringModel({
    this.id,
    this.noProject,
    this.pic,
    this.mitra,
    this.boq,
    this.pole,
    this.cable,
    this.accessories,
    this.date,
    this.desc,
    this.image,
    this.createdAt,
    this.createdBy,
    this.status,
  });
  MonitoringModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    noProject = json['no_project']?.toString();
    pic = json['pic']?.toString();
    mitra = json['mitra']?.toString();
    boq = json['boq'];
    pole = json['pole'];
    cable = json['cable'];
    accessories = json['accessories'];
    status = json['status'];
    date = json['date']?.toString();
    desc = json['desc']?.toString();
    image = json['image']?.toString();
    createdAt = json['createdAt']?.toString();
    createdBy = json['createdBy']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['no_project'] = noProject;
    data['pic'] = pic;
    data['mitra'] = mitra;
    data['boq'] = boq;
    data['status'] = status;
    data['pole'] = pole;
    data['cable'] = cable;
    data['accessories'] = accessories;
    data['date'] = date;
    data['desc'] = desc;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    return data;
  }

  factory MonitoringModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return MonitoringModel(
        id: snapshot.id,
        image: data['image'] ?? '',
        mitra: data['mitra'] ?? '',
        noProject: data['no_project'],
        pic: data['pic'] ?? '',
        boq: data['boq'] ?? false,
        pole: data['pole'] ?? false,
        cable: data['cable'] ?? false,
        accessories: data['accessories'] ?? false,
        date: data['date'] ?? '',
        desc: data['desc'] ?? '',
        createdAt: data['createdAt'] ?? '',
        createdBy: data['createdBy'] ?? '',
        status: data['status'] ?? false);
  }

  static List<MonitoringModel> fromJsonList(List<QueryDocumentSnapshot> snapshot) {
    return snapshot.map((e) => MonitoringModel.fromDocumentSnapshot(e)).toList();
  }
}
