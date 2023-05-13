import 'package:dektodo/const.dart';
import 'package:dektodo/dto.dart';
import 'package:dektodo/screen/3d_button.dart';
import 'package:dektodo/screen/alert/alert_show_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget todoListItem(String createdTime, int idx, data) =>
    Builder(builder: (context) {
      double _height = 64.w;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        child: Row(
          children: [
            Container(
              width: _height,
              height: _height,
              padding: EdgeInsets.all(8.w),
              child: Container(
                child: Xian3dButton(
                    size: _height,
                    childWidget: Center(
                      child: Text(
                        idx.toString(),
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
            ),
            Expanded(
              child: Container(
                height: _height,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2.w),
                  borderRadius: BorderRadius.all(Radius.circular(mainBorder)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            alertShowContent(context, createdTime, idx, data);
                          },
                          child: Container(
                            width: 200.w,
                            child: Text(
                              data['title'],
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                            xianFirebaseController.editTodo(
                                createdTime,
                                Love(
                                    title: data['title'],
                                    isFinished: value as bool,
                                    image: data['image']));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
