import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Userdata extends StatefulWidget {
  const Userdata({Key? key}) : super(key: key);

  @override
  State<Userdata> createState() => _UserdataState();
}


class _UserdataState extends State<Userdata> {


  getData() async {
    try {
      var result = await firestore.collection('user').doc('O6pgVtHJhfx85lW9vxNM').get();
      print(result['name']);
    }
    catch(e)
    {
      print(e);
    }
  }

  setData()async{
    try {
      await firestore.collection('user').add({'name' : '지은', 'email' : "qweqr@naver.com",'passwd' : "qwwqd123", 'uid' : "qweqr1com"});
      print('성공');
    } catch (e) {
      print("에러다에러");
    }
  }
  @override
  void initState(){
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
