import 'package:dektodo/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../dto.dart';

class TextInputBox extends StatefulWidget {
  final ScrollController scrollController;
  const TextInputBox(this.scrollController, {Key? key}) : super(key: key);

  @override
  State<TextInputBox> createState() => _TextInputBoxState();
}

class _TextInputBoxState extends State<TextInputBox> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode textFocus = FocusNode();

  void onUploadBtnClicked(TextEditingController textController) {
    if (textController.value.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "내용을 채워 주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    }
    xianFirebaseController.uploadNewTodo(
        Love(title: textController.value.text, isFinished: false, image: ""));

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
    widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
        border: const GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                subPrimaryColor,
              ],
            ),
            width: 2),
      ),
      height: 64.h,
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 8.w),
              child: TextField(
                controller: _textController,
                focusNode: textFocus,
                // onSubmitted: sendMsg, //키보드로 엔터 클릭 시 호출
                // onChanged: checkText, //text 가 입력될 때 마다 호출
                decoration: InputDecoration(
                  // labelText: '텍스트 입력',
                  hintText: '같이 하고 싶은 일이 생각났oh?',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  // focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Color(0xFFFF9874), width: 2)),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Color(0xFFFFBFA9), width: 2)),
                  // border: OutlineInputBorder(
                  //     borderSide:
                  //         BorderSide(color: Color(0xFFFFBFA9), width: 1)), //외곽선
                  // disabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Color(0xFFFFBFA9), width: 1)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onUploadBtnClicked(_textController);
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: LinearGradient(colors: [
                  primaryColor,
                  subPrimaryColor,
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
