import 'package:dektodo/const.dart';
import 'package:dektodo/firebase_options.dart';
import 'package:dektodo/screen/text_input_box.dart';
import 'package:dektodo/screen/todo_list_fragment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> checkedValList = <bool>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: <Color>[primaryColor, subPrimaryColor]
            //
            // )
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 24.h,
            ),
            Container(
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        loveTitle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ))
                  ],
                )),
            Expanded(
              child: Stack(
                children: [
                  Expanded(
                      child: TodoListFragment(
                    loveCollection: xianFirebaseController.loveCollection,
                    scrollController: _scrollController,
                  )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: TextInputBox(_scrollController)),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   onPressed: () {
      //     onUploadBtnClicked();
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
