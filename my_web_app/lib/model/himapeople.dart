import 'package:cloud_firestore/cloud_firestore.dart';

class HimaPeople {
  String id;
  String? name;
  bool isHima;
  String mail;

  HimaPeople({
    required this.id,
    required this.name,
    required this.isHima,
    required this.mail,
  });

  factory HimaPeople.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return HimaPeople(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
      isHima: data['isHima'] ?? false,
      mail: data['mail'] ?? "",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "isHima": isHima,
      "mail": mail,
    };
  }
}
