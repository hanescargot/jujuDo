import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputBox extends StatefulWidget {
  final TextEditingController textCtr;
  final FocusNode textFocus;
  const TextInputBox({required this.textCtr, required this.textFocus, Key? key})
      : super(key: key);

  @override
  State<TextInputBox> createState() => _TextInputBoxState();
}

class _TextInputBoxState extends State<TextInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: widget.textCtr,
        focusNode: widget.textFocus,
        // onSubmitted: sendMsg, //키보드로 엔터 클릭 시 호출
        // onChanged: checkText, //text 가 입력될 때 마다 호출
        decoration: InputDecoration(
          // labelText: '텍스트 입력',
          hintText: '같이 하고 싶은 일이 생각났oh?',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF9874), width: 2)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFBFA9), width: 2)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFBFA9), width: 1)), //외곽선
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFBFA9), width: 1)),
        ),
      ),
    );
  }
}
