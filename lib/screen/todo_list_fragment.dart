import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dektodo/screen/slide_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoListFragment extends StatefulWidget {
  final CollectionReference loveCollection;
  final ScrollController scrollController;
  const TodoListFragment(
      {required this.loveCollection, required this.scrollController, Key? key})
      : super(key: key);
  @override
  State<TodoListFragment> createState() => _TodoListFragmentState();
}

class _TodoListFragmentState extends State<TodoListFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: widget.loveCollection!.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        int listCount = 0; // snapshot.data!.docs.length;

        return ListView(
            physics: const BouncingScrollPhysics(),
            controller: widget.scrollController,
            reverse: false,
            padding: EdgeInsets.only(bottom: 80.h),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              listCount++;

              return slidItem(document.id, listCount, data);
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
    ));
  }
}
