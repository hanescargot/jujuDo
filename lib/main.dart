import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dektodo/firebase_options.dart';
import 'package:dektodo/screen/text_input_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dto.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: const MyHomePage(),
      );
    });
  }
}

const Color primaryColor = Color(0xFFFFACAC);

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String id = "loves"; // 파티 구분 키
  late final TextEditingController _textController =
      new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FocusNode textFocus = FocusNode();

  List<bool> checkedValList = <bool>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference loveCollection =
        FirebaseFirestore.instance.collection(id)!;
    Future<void> updateTodo(String doc, Love updateLove) {
      return loveCollection!
          .doc(doc)
          .update(
              {'isFinished': updateLove.isFinished, 'image': updateLove.image})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    Future<void> _uploadNewTodo(Love love) {
      return loveCollection!.doc(love.createdTime.toString()).set({
        'title': love.title,
        'isFinished': love.isFinished,
        'image': love.image
      });
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

    Future<void> onDeleteBtnClicked(String doc) {
      return loveCollection!.doc(doc).delete();
    }

    Future<void> onUploadBtnClicked() async {
      _uploadNewTodo(Love(
          title: _textController.value.text, isFinished: false, image: ""));
      Fluttertoast.showToast(
          msg: "추가 완료",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      _textController.clear();
      textFocus.unfocus();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    }

    Widget todo(String createdTime, int idx, data) => Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(idx.toString()),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    data['title'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    value: data['isFinished'],
                    onChanged: (value) {
                      updateTodo(
                          createdTime,
                          Love(
                              title: data['title'],
                              isFinished: value as bool,
                              image: data['image']));
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      onDeleteBtnClicked(createdTime);
                    },
                    icon: Container(
                      width: 2.w,
                      child: Icon(
                        Icons.delete_forever_sharp,
                        color: Color(0xFFFF6E6E),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2,
        title: Text("DekJuDoDekJuDo"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Color(0xFFFFBFA9),
              Color(0xFFFFEBB4),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
              stream: loveCollection!.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                int listCount = 0; // snapshot.data!.docs.length;

                return ListView(
                    controller: _scrollController,
                    reverse: false,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      listCount++;
                      return todo(document.id, listCount, data);
                    }).toList());

                // ListView.builder(
                //   itemCount: loveList.length,
                //   itemBuilder: (context, index) {
                //     Love thisLove = loveList[index];
                //     bool isFinishedVal = thisLove.isFinished;
                //     checkedValList.add(isFinishedVal);
                //     return todo(thisLove.title, index);
                //   });
              },
            ))),
            TextInputBox(textCtr: _textController, textFocus: textFocus),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          onUploadBtnClicked();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
