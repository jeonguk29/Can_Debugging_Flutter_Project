
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mbti_storage/Layout/today_survey.dart';
import 'package:mbti_storage/shared/bloc/states.dart';
import 'package:mbti_storage/shared/components/components.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:store_redirect/store_redirect.dart';

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
              backgroundColor: Color(0xfff76e77),
              elevation: 0.1,
              title: Text(
                '나의 MBTI 저장소',
                style: TextStyle(color: Colors.white, fontFamily: 'RoundWind',fontWeight: FontWeight.w700, ),
              ),
            ),



            floatingActionButton:  SpeedDial( //Speed dial menu
              //margin bottom
              icon: Icons.menu, //icon on Floating action button
              activeIcon: Icons.close, //icon when menu is expanded on button
              backgroundColor: Color(0xffffbd60), //background color of button
              foregroundColor: Colors.white, //font color, icon color in button
              activeBackgroundColor: Colors.white, //background color when menu is expanded
              activeForegroundColor: Color(0xffffbd60),
              //button size
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,

              onOpen: () => print('OPENING DIAL'), // action when menu opens
              onClose: () => print('DIAL CLOSED'), //action when menu closes

              elevation: 8.0, //shadow elevation of button
              shape: CircleBorder(), //shape of button

              children: [
                SpeedDialChild( //speed dial child
                  child: Icon(Icons.edit),
                  backgroundColor: Color(0xffffbd60),
                  foregroundColor: Colors.white,
                  label: 'MBTI 검사 등록', //이름 변경
                  labelStyle: TextStyle(fontFamily: 'RoundWind', fontSize: 15.0),
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
                                    prefix: Icons.account_circle_rounded,
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
                                    prefix: Icons.title_rounded,
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
                    }
                  }, ////
                ),
                SpeedDialChild(
                  child: Icon(Icons.newspaper),
                  backgroundColor: Color(0xffffbd60),
                  foregroundColor: Colors.white,
                  label: '게시판 작성',
                  labelStyle: TextStyle(fontFamily: 'RoundWind', fontSize: 15.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => todaysurvey()),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.share),
                  backgroundColor: Color(0xffffbd60),
                  foregroundColor: Colors.white,
                  label: '카카오톡 공유',
                  labelStyle: TextStyle(fontSize: 15.0),
                  onTap: () async {
                    bool result = await ShareClient.instance.isKakaoTalkSharingAvailable();

                    int templateId = 82812; // 템플릿 ID
                    if (result) {
                      print('카카오톡으로 공유 가능');
                      // 사용자 정의 템플릿 ID

                      try {
                        Uri uri =
                        // await ShareClient.instance.shareDefault(template: defaultFeed);     // 템플릿 직접 제작
                        await ShareClient.instance.shareCustom(templateId: templateId);  // Kakao Developers 도구 템플릿
                        await ShareClient.instance.launchKakaoTalk(uri);
                        print('카카오톡 공유 완료');
                      } catch (error) {
                        Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
                            templateId: templateId, templateArgs: {'key1': 'value1'});
                        await launchBrowserTab(shareUrl);
                        print('카카오톡 공유 실패 $error');
                      }
                    } else {
                      StoreRedirect.redirect(androidAppId: "com.kakao.talk", iOSAppId: "362057947");  // 안드로이드는 플레이스토어, IOS는 앱스토어로 리다이렉트
                    }},
                ),
              ],
            ),

            bottomNavigationBar: BubbleBottomBar(
              opacity: .2,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavBarIndex(index);
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              elevation: 10,
              hasNotch: true, //new
              hasInk: true, //new, gives a cute ink effect
              inkColor: Colors.black, //optional, uses theme color if not specified
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(backgroundColor: Color(0xfff76e77), icon: Icon(Icons.account_circle, color: Colors.black,), activeIcon: Icon(Icons.account_circle, color: Color(0xfff76e77),), title: Text("나의 MBTI")),
                BubbleBottomBarItem(backgroundColor: Color(0xfff76e77), icon: Icon(Icons.article, color: Colors.black,), activeIcon: Icon(Icons.article, color: Color(0xfff76e77),), title: Text("게시판")),
                BubbleBottomBarItem(backgroundColor: Color(0xfff76e77), icon: Icon(Icons.star, color: Colors.black,), activeIcon: Icon(Icons.star, color: Color(0xfff76e77),), title: Text("즐겨찾기")),
              ],
            ),


            body: cubit.Screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}


