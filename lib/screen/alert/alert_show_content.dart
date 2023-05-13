import 'package:dektodo/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void alertShowContent(
        BuildContext context, String createdTime, int idx, data) =>
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Builder(builder: (context) {
              return Container(
                height: 200.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "To-Do",
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
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.w),
                        constraints: BoxConstraints(minHeight: 200.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            )),
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Text(data['title']),
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
