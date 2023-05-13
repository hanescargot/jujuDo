import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dektodo/dto.dart';

class XianFirebaseController {
  final CollectionReference loveCollection;
  XianFirebaseController({required this.loveCollection});

  void editTodo(String doc, Love updateLove) {
    loveCollection!
        .doc(doc)
        .update({
          'title': updateLove.title,
          'isFinished': updateLove.isFinished,
          'image': updateLove.image
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void uploadNewTodo(Love love) {
    loveCollection!.doc(love.createdTime.toString()).set({
      'title': love.title,
      'isFinished': love.isFinished,
      'image': love.image
    });
  }

  void deleteTodo(String doc) {
    loveCollection!.doc(doc).delete();
  }

  // Future<void> _loadServerData() async {
  //   loveCollection.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       loveList.add(Love(
  //           title: doc.toString(),
  //           isFinished: doc["isFinished"],
  //           image: doc["image"] ?? ""));
  //     });
  //   });
  // }

}
