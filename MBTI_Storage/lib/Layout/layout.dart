
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:mbti_storage/Layout/today_survey.dart';
import 'package:mbti_storage/shared/bloc/states.dart';
import 'package:mbti_storage/shared/components/components.dart';

import '../shared/bloc/cubit.dart';


class layout extends StatelessWidget {
  var nameController = TextEditingController();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  List<String> mbtiItem = [
    "ENFJ",
    "ENTJ",
    "ENFP",
    "ENTP",
    "ESFP",
    "ESFJ",
    "ESTP",
    "ESTJ",
    "INFP",
    "INFJ",
    "INTP",
    "ISTP",
    "ISFP",
    "ISFJ",
    "ISTJ",
    "INTJ",
  ];

  var mbtistring;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appCubit()..CreateDataBase(),
      child: BlocConsumer<appCubit, States>(
        listener: (context, status) {
          if (status is InsertIntoDB) {
            Navigator.pop(context);
          }
        },
        builder: (context, status) {
          appCubit cubit = appCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            key: Scaffoldkey,
            appBar: AppBar(
              leading: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.green,
              elevation: 0.1,
              title: Text(
                '나의 MBTI 저장소',
                style: TextStyle(color: Colors.white),
              ),
            ),
            floatingActionButton:  SpeedDial( //Speed dial menu
              marginBottom: 10, //margin bottom
              icon: Icons.menu, //icon on Floating action button
              activeIcon: Icons.close, //icon when menu is expanded on button
              backgroundColor: Colors.deepOrangeAccent, //background color of button
              foregroundColor: Colors.white, //font color, icon color in button
              activeBackgroundColor: Colors.deepPurpleAccent, //background color when menu is expanded
              activeForegroundColor: Colors.white,
              buttonSize: 56.0, //button size
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'), // action when menu opens
              onClose: () => print('DIAL CLOSED'), //action when menu closes

              elevation: 8.0, //shadow elevation of button
              shape: CircleBorder(), //shape of button

              children: [
                SpeedDialChild( //speed dial child
                  child: Icon(Icons.edit),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: 'MBTI 검사 등록', //이름 변경
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    if (cubit.isBottomSheetShown) {
                      if (Scaffoldkey.currentState != null &&
                          formkey.currentState != null &&
                          formkey.currentState!.validate()) {
                        cubit.InsertIntoDataBase(
                            name: nameController.text,
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text);
                      }
                    } else {

                      cubit.isBottomSheetShown = true;
                      Scaffoldkey.currentState!
                          .showBottomSheet(
                            (context) => Container(
                          color: Colors.white,
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextFormField(
                                    validator: ( value) {
                                      if (value!.isEmpty) {
                                        return '이름을 입력해주세요';
                                      }
                                      return null;
                                    },

                                    controller: nameController,
                                    keyboaredType: TextInputType.text,
                                    Label: '이름',
                                    prefix: Icons.title,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextFormField(
                                    validator: ( value) {
                                      if (value!.isEmpty) {
                                        return 'MBTI를 입력해주세요';
                                      }
                                      return null;
                                    },

                                    controller: titleController,
                                    keyboaredType: TextInputType.text,
                                    Label: 'MBTI',
                                    prefix: Icons.title,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextFormField(

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '검사 날짜를 입력해주세요';
                                      }
                                      return null;
                                    },
                                    controller: dateController,
                                    keyboaredType: TextInputType.datetime,
                                    Label: '검사 날짜',
                                    prefix: Icons.calendar_month,
                                    ontap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                          DateTime.parse('2030-01-01'))
                                          .then((value) => {
                                        dateController.text =
                                            DateFormat.yMMMd()
                                                .format(value!),
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),


                                  child: defaultTextFormField(
                                    validator: ( value) {
                                      if (value!.isEmpty) {
                                        return '검사 시간을 입력해주세요';
                                      }
                                      return null;
                                    },

                                    controller: timeController,
                                    keyboaredType: TextInputType.datetime,
                                    Label: '검사 시간',
                                    prefix: Icons.watch,
                                    ontap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                            (value) => {
                                          print(value!.format(context)),
                                          timeController.text =
                                              value.format(context).toString(),
                                        },
                                      );
                                    },
                                  ),
                                ),
                                /////
                              ],
                            ),
                          ),
                        ),
                      )
                          .closed
                          .then((value) {
                        cubit.ChangebottomSheet(isShown: false, icon: Icons.edit);
                      });
                      cubit.ChangebottomSheet(isShown: true, icon: Icons.add);
                    }
                  }, ////
                ),
                SpeedDialChild(
                  child: Icon(Icons.newspaper),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  label: '게시판 작성',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => todaysurvey()),
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 20.0,
              elevation: 15.0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: '나의 MBTI',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: '게시판',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'item',
                ),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}


