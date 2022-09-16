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
<<<<<<< HEAD
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom),
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
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
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
                      await todaySuvry.add({
                        "title": title,
                        "content": content,
                        "name": name,
                        "passwd": passwd
                      });

                      titleController.text = "";
                      contentController.text = "";
                      nameController.text = "";
                      passwdController.text = "";
                    },
                    child: Text('Update'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff00a29b),)
                    ),
                  ),
                ],
              ),
=======
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
>>>>>>> e170e83dc9d92df2cf07140368eaf2d1a49a7a90
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
<<<<<<< HEAD

=======
          appBar: AppBar(
            title: Text("오늘의 주제"),
          ),
>>>>>>> e170e83dc9d92df2cf07140368eaf2d1a49a7a90
          body: StreamBuilder(
            stream: todaySuvry.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot){
              if(streamSnapshot.hasData){
                return
<<<<<<< HEAD
                  ListView.separated(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return ListTile(
                        //margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
=======
                  ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                      child: ListTile(
>>>>>>> e170e83dc9d92df2cf07140368eaf2d1a49a7a90
                        title: Text(documentSnapshot['title']),
                        subtitle: Container(
                          child: Row(
                            children: [
<<<<<<< HEAD
                              Expanded(child:Text(documentSnapshot['content'])),
                              //Text(documentSnapshot['content']),
                              Text(documentSnapshot['name']),
                              //Text(documentSnapshot['passwd']),
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
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 2,
                    );
                  },
                  );
=======
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
>>>>>>> e170e83dc9d92df2cf07140368eaf2d1a49a7a90
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
