import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class todaysurvey extends StatefulWidget {
  const todaysurvey({Key? key}) : super(key: key);

  @override
  State<todaysurvey> createState() => _todaysurveyState();
}


class _todaysurveyState extends State<todaysurvey> {

  CollectionReference todaySuvry = FirebaseFirestore.instance.collection('todaySuvey');
  final TextEditingController suveyController = TextEditingController();
  final TextEditingController likeController = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    suveyController.text = documentSnapshot['suvey'];
    likeController.text = documentSnapshot['like'];

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
                  controller: suveyController,
                  decoration: InputDecoration(labelText: 'suvey'),
                ),
                TextField(
                  controller: likeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'like'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String suvey = suveyController.text;
                    final String like = likeController.text;
                    await todaySuvry
                        .doc(documentSnapshot.id)
                        .update({"suvey": suvey, "like": like});
                    suveyController.text = "";
                    likeController.text = "";
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
                  controller: suveyController,
                  decoration: InputDecoration(labelText: 'suvey'),
                ),
                TextField(
                  controller: likeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'like'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String suvey = suveyController.text;
                    final String like = likeController.text;
                    await todaySuvry.add({'suvey': suvey, 'like': like});

                    suveyController.text = "";
                    likeController.text = "";
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
          body: StreamBuilder(
          stream: todaySuvry.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData){
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context,index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    child: ListTile(
                      title: Text(documentSnapshot['suvey']),
                      subtitle: Text(documentSnapshot['like']),
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



