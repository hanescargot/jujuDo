import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dektodo/controller/firebase_controller.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFACAC);
const Color primaryColorShadow = Color(0xFFC58383);
const Color subPrimaryColor = Color(0xFFFFEBB4);
const double mainBorder = 8;
const int maxTotoCount = 100;
final String loveTitle = "DeckJuDo afddkdakljflkdajfklajelkjlk";
final String id = "loves"; // 파티 구분 키
late final XianFirebaseController xianFirebaseController =
    XianFirebaseController(
        loveCollection: FirebaseFirestore.instance.collection(id)!);
