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

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    titleController.text = documentSnapshot['title'];
    contentController.text = documentSnapshot['content'];
    nameController.text = documentSnapshot['name'];
    passwdController.text = documentSnapshot['passwd'];


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
                  decoration: InputDecoration(labelText: '좋아요'),
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
                  child: Text('Update'),
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
                  decoration: InputDecoration(labelText: '제목'),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: '내용'),
                ),
                TextField(
                  controller: nameController,
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
                    await todaySuvry.add({"title": title, "content": content, "name": name, "passwd": passwd});

                    titleController.text = "";
                    contentController.text = "";
                    nameController.text = "";
                    passwdController.text = "";
                    Navigator.of(context).pop();
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
          appBar: AppBar(
            title: Text("오늘의 주제"),
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
                        title: Text(documentSnapshot['title']),
                        subtitle: Container(
                          child: Row(
                            children: [
                              Text(documentSnapshot['content']),
                              Text(documentSnapshot['name']),
                              Text(documentSnapshot['passwd']),
                            ],
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _update(documentSnapshot);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  _delete(documentSnapshot.id);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: (){
              _create();
            },
            child: Icon(Icons.add),
          ),
        )
    );
  }
}



