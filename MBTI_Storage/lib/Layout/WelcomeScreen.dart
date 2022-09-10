import 'package:flutter/material.dart';
import 'package:mbti_storage/Layout/layout.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 60,),
          Expanded(
            flex: 2,
            child: Padding(padding: EdgeInsets.all(25),
            child: Container(
              child: Image(image: AssetImage('assets/mbti-types.png'))
              //child: CircleAvatar(radius: 170,backgroundImage: NetworkImage("https://drive.google.com/file/d/1Ian3soj0fv152f8XlsyPVXlGFa9bkdjr/view?usp=sharing"),),
            ),)
          ),
          ElevatedButton.icon(
            // 텍스트버튼에 아이콘 넣기
            onPressed: () async {
              const url = 'https://www.16personalities.com/ko/%EB%AC%B4%EB%A3%8C-%EC%84%B1%EA%B2%A9-%EC%9C%A0%ED%98%95-%EA%B2%80%EC%82%AC';
              // 외부 브라우저 실행
              await launch(url, forceWebView: false, forceSafariVC: false);

            }, // 버튼 클릭 비활성화 -> 비활성화 시의 UI는 onSurface로 가능
            icon: Icon(Icons.home, size: 30),
            label: Text('MBTI 검사하기'),
            style: TextButton.styleFrom(
                minimumSize: Size(200,50) // 버튼 크기를 지정해서 바꾸기
            ),
          ),
          SizedBox(height: 50,),
          Text("MBTI 저장소",style: TextStyle(color: Color.fromARGB(255, 7, 26, 17),fontSize: 35,fontWeight: FontWeight.bold),),
          SizedBox(height: 50,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return layout();
                        },
                      ));
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
   
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Text(
                            "내 MBTI 저장하기",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                  color: Color.fromARGB(255, 245, 244, 244),
                                ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),



    ],
      ),
    );
  }
}