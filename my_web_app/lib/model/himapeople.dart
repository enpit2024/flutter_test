import 'package:cloud_firestore/cloud_firestore.dart';

class HimaPeople {
  String id;
  String? name;
  bool isHima;
  String mail;
  String? deadline;
  String? place;

  HimaPeople({
    required this.id,
    required this.name,
    required this.isHima,
    required this.mail,
    required this.deadline,
    required this.place,
  });

  factory HimaPeople.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    var deadlineFormatted = "";
    if (data['deadline'] != null) {
      final deadline = data['deadline'] as Timestamp;
      final deadlineTodate = deadline.toDate();
      deadlineFormatted =
          "${deadlineTodate.year}/${deadlineTodate.month}/${deadlineTodate.day}";
    } else {
      deadlineFormatted = "";
    }
    return HimaPeople(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
      isHima: data['isHima'] ?? false,
      mail: data['mail'] ?? "",
      deadline: deadlineFormatted,
      place: data['place'] ?? "",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "isHima": isHima,
      "mail": mail,
      "deadline": deadline,
      "place": place,
    };
  }
}
