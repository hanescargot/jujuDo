import 'package:dektodo/const.dart';
import 'package:dektodo/dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void alertShowEdit(BuildContext context, String createdTime, int idx, data) =>
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          TextEditingController _textController = TextEditingController();
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Builder(builder: (context) {
              _textController.text = data['title'];
              return Container(
                height: 200.h,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "내용 수정",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        constraints: BoxConstraints(minHeight: 200.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            )),
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            maxLength: 200,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "",
                              counterText: "",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    InkWell(
                      onTap: onClickedSaveBtn(
                          context, _textController, createdTime, idx, data),
                      child: Container(
                        width: 80.w,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "저장",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });

Function() onClickedSaveBtn(
        BuildContext context,
        TextEditingController textController,
        String createdTime,
        int idx,
        data) =>
    () {
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
      Love newLove = Love(
        title: textController.text,
        isFinished: data['isFinished'] as bool,
        image: data['image'] as String,
      );
      xianFirebaseController.editTodo(createdTime, newLove);
      Navigator.pop(context);
    };
