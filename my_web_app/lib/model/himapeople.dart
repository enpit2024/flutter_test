import 'package:cloud_firestore/cloud_firestore.dart';

class HimaPeople {
  String id;
  String name;
  bool isHima;

  HimaPeople({
    required this.id,
    required this.name,
    required this.isHima,
  });

  factory HimaPeople.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return HimaPeople(
      id: data['id'],
      name: data['name'],
      isHima: data['isHima'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "isHima": isHima,
    };
  }
}
