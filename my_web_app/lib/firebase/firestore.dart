import 'package:my_web_app/model/himapeople.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //←追加します

// himapeopleテーブルへのアクセスをまとめたクラス
class FirestoreHelper {
  // DbHelperをinstance化する
  static final FirestoreHelper instance = FirestoreHelper._createInstance();

  FirestoreHelper._createInstance();

  // himapeopleテーブルのデータを全件取得する
  // selectAllHimaPeople(String userId) async {
  //   final db = FirebaseFirestore.instance;
  //   // himapeopleコレクションにあるdocを全て取得する
  //   // この時、fromFirestore、toFirestoreを使ってデータ変換する
  //   final snapshot = await db
  //       .collection("users")
  //       .withConverter(
  //         fromFirestore: HimaPeople.fromFirestore,
  //         toFirestore: (HimaPeople himapeople, _) => himapeople.toFirestore(),
  //       )
  //       .get();
  //   final himapeopleList = snapshot.docs.map((doc) => doc.data()).toList();
  //   return himapeopleList;
  // }

  Future<List<HimaPeople>> selectAllHimaPeople(String userId) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return snapshot.docs
        .map((doc) => HimaPeople.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }

// nameをキーにして1件のデータを読み込む
// ※himapeopleのキーはidでなくnameに変更している
  himapeopleData(String userId, String name) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("himapeople")
        .doc(name)
        .withConverter(
          fromFirestore: (snapshot, _) => HimaPeople.fromFirestore(snapshot),
          toFirestore: (HimaPeople himapeople, _) => himapeople.toFirestore(),
        );
    final himapeopledata = await docRef.get();
    final himapeople = himapeopledata.data();
    return himapeople;
  }

// データをinsertする
// ※updateも同じ処理で行うことができるので、共用している
  Future insert(HimaPeople himapeople, String userId) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("himapeople")
        .doc(himapeople.name)
        .withConverter(
          fromFirestore: (snapshot, _) => HimaPeople.fromFirestore(
              snapshot as DocumentSnapshot<Map<String, dynamic>>),
          toFirestore: (HimaPeople himapeople, options) =>
              himapeople.toFirestore(),
        );
    await docRef.set(himapeople);
  }

// データを削除する
  Future delete(String userId, String name) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc(userId)
        .collection("himapeople")
        .doc(name)
        .delete();
  }
}
