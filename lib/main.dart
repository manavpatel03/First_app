library globals;

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DataHome(),
      ),
  );
}
class DataHome extends StatefulWidget {
  const DataHome({Key? key}) : super(key: key);

  @override
  _DataHomeState createState() => _DataHomeState();
}

class _DataHomeState extends State<DataHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Center(
          child: Text(
            '#Find your id!!!',
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Welcome to the app!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Open',
                fontSize: 30,
                color: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Text(
              'Find the desired Id by \nclicking on the button',
              style: TextStyle(
                fontSize: 35,
                color: Colors.grey[200],
                fontFamily: 'Open',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          IconButton(
            iconSize: 200,
            icon: Image.asset('assets/search.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ans()),
              );
            },
          ),
        ],
      ),
    );
  }
}
class Ans extends StatelessWidget{
  Ans({super.key});
  List searchresult = [];
void datasearch (String Query) async{
  final result = await FirebaseFirestore.instance.collection('users').where('name', isEqualTo: Query,).get();
  searchresult = result.docs.map((e) => e.data()).toList();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            title: const Center(
              child: Text('#Search!!!',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      body:


      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Welcome to the app!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Open',
                fontSize : 30,
                color: Colors.grey[800],
              ),

            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Text(
              'Enter the text below:-',
              style: TextStyle(
                fontSize: 35,
                color: Colors.grey[800],
                fontFamily: 'Open',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // IconButton(
          //     iconSize: 200,
          //     icon: Image.asset('assets/search.png'), onPressed: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => Ans()),
          //   );
          // }
          //
          // ),
      Row(children: [
        Expanded(

          child: Container(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
                onChanged: (String name1){
                getname(name1);
                },
            ),
          ),
        ),
        IconButton(onPressed:( ) async {
          final collectionReference = FirebaseFirestore.instance.collection('users');
          final documentReference = collectionReference.doc('urls');
          final documentSnapshot = await documentReference.get();
          final fieldValue = documentSnapshot.data()![Name];
          final myVariable = fieldValue;
          U = myVariable;
          //datasearch(Name);
          // U = searchresult[1];
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Final()),
        );},
          icon:const Icon(
            Icons.search_rounded,
          ),
          iconSize: 50,
        )
        ],
      ),

      ],
      ),



    );
  }
}
class Final extends StatelessWidget{
  const Final({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Center(
          child: Text('Result',
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name : ${Name}',
              style: const TextStyle(
                fontSize: 35,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Expanded(child: Image(fit: BoxFit.fill,
                      image: NetworkImage(U)))),
            ),
          ],
      ),
    );
  }
}
  String U = '';
  String Name = '';
  getname(name) {
    Name = name;
  }
  geturl(url)
  {
    U = url;
  }

