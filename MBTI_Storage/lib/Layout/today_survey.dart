import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class todaysurvey extends StatefulWidget {
  const todaysurvey({Key? key}) : super(key: key);

  @override
  State<todaysurvey> createState() => _todaysurveyState();
}


class _todaysurveyState extends State<todaysurvey> {

  CollectionReference todaySuvry = FirebaseFirestore.instance.collection('todaySuvey');
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  /*
  Stream documentStream = FirebaseFirestore.instance.collection('notice').doc('5ztLPy8mHBHybfc1XKE6').snapshots();

  var t = firestore.collection("books").document("on_intelligence").get().then((DocumentSnapshot ds){ title = ds.data["title"];
    print(title);
  });
*/

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    titleController.text = documentSnapshot['title'];
    contentController.text = documentSnapshot['content'];
    nameController.text = documentSnapshot['name'];
    passwdController.text = documentSnapshot['passwd'];


    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: '제목'),
                ),
                TextField(
                  controller: contentController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: '내용'),
                ),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: '이름'),
                ),
                TextField(
                  controller: passwdController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'passwd'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String title = titleController.text;
                    final String content = contentController.text;
                    final String name = nameController.text;
                    final String passwd = passwdController.text;
                    await todaySuvry
                        .doc(documentSnapshot.id)
                        .update({"title": title, "content": content, "name": name, "passwd": passwd});
                    titleController.text = "";
                    contentController.text = "";
                    nameController.text = "";
                    passwdController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update',),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff00a29b), )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            child: Padding(
            padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        TextField(
        controller: titleController,
          maxLength: 18, // 글자수 지정
          textInputAction: TextInputAction.next, // 다음 텍스트 필드로 포커스 이동
        decoration: InputDecoration(
          labelText: '제목',
        ),
        ),
        TextField(
        controller: contentController,
          maxLength: 200, // 글자수 지정
          textInputAction: TextInputAction.next, // 다음 텍스트 필드로 포커스 이동
        decoration: InputDecoration(labelText: '내용'),
        ),
        TextField(
        controller: nameController,
          maxLength: 10, // 글자수 지정
          textInputAction: TextInputAction.next, // 다음 텍스트 필드로 포커스 이동
        decoration: InputDecoration(labelText: '이름'),
        ),
        TextField(
        controller: passwdController,
          maxLength: 20, // 글자수 지정
          textInputAction: TextInputAction.done, // 키보드가 자동으로 내려가며 포커스 해제
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: 'passwd'),
        ),
        SizedBox(
        height: 20,
        ),
        ElevatedButton(
        onPressed: () async {
        final String title = titleController.text;
        final String content = contentController.text;
        final String name = nameController.text;
        final String passwd = passwdController.text;
        await todaySuvry.add({"title": title, "content": content, "name": name, "passwd": passwd});

        titleController.text = "";
        contentController.text = "";
        nameController.text = "";
        passwdController.text = "";
        //Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);
        },
        child: Text('Update'),
        ),
        ],
        ),
            ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async{
    await todaySuvry.doc(productId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize( // 앱바 줄이기 https://freecatz.tistory.com/351
            preferredSize: Size.fromHeight(65.0),
              child:AppBar(
                backgroundColor: Colors.orangeAccent,
                  titleTextStyle: TextStyle(fontFamily: 'Roundwind',
                      fontWeight: FontWeight.bold),
                  title: Center(child:
                  Column(children: [
                    Text("오늘의 주제", style: TextStyle(fontSize: 20.0),),
                    Text("ESTJ 특", style: TextStyle(fontSize: 18.0),),
                  ],
                  ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical( // 앱바 모양 깍기
                      bottom: Radius.circular(58.0),
                ),),
              ),
          ),

          body: StreamBuilder(
            stream: todaySuvry.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot){
              if(streamSnapshot.hasData){
                return
                  ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return Card(
                        margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                        child: ListTile(
                          title: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.textsms),
                                Text("  제목: ${documentSnapshot['title']}",
                                    style: TextStyle(
                                        fontFamily: 'Roundwind',
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                            ],
                            ),
                          ),
                          subtitle: Container(
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.edit,size: 13),
                                    Text("글쓴이: ${documentSnapshot['name']}",
                                        style: TextStyle(
                                            fontFamily: 'Roundwind',
                                            color: Colors.black54,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 280,
                                      child: Text(documentSnapshot['content']),
                                    ),
                                  ],
                                ),
                              ],
                            )

                          ),
/*
                          trailing: SizedBox(
                            width: 30,
                            child: Row(
                              children: [
/*
                                IconButton(
                                  onPressed: () {
                                    _update(documentSnapshot);
                                  },
                                  icon: Icon(Icons.edit),
                                ),

 */
                                IconButton(
                                  onPressed: () {
                                    _delete(documentSnapshot.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
*/
                        ),
                      );
                    },
                  );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xfff76e77),
            onPressed: (){
              _create();
            },
            child: Icon(Icons.add),
          ),
        )
    );
  }
}
