import 'package:flutter/material.dart';
import 'package:flutterprojecttodo/AddStudent.dart';
import 'package:uuid/uuid.dart';

class Studentinfo extends StatefulWidget {
  const Studentinfo({super.key});

  @override
  State<Studentinfo> createState() => _StudentinfoState();
}

class Students {
  String? id;
  String name;
  String fathername;
  List<dynamic>? subject;

  Students({
     this.id,
    required this.name,
    required this.fathername,
    this.subject,
  });
}

class _StudentinfoState extends State<Studentinfo> {

  // Updated component to support expanding inside a Row
  Widget mycomponent(String label) {
    return Expanded(
      child: Container(
        height: 40, // Increased height for better visibility
        decoration: const BoxDecoration(color: Colors.black),
        alignment: Alignment.center, // Centers the text inside the container
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
  var uuid = Uuid();
  late List<Students> students = [
    Students(id: uuid.v1() , name: "name1", fathername: "fathername"),
    Students(id: uuid.v4(), name: "name1", fathername: "fathername"),
    Students(id: uuid.v4(), name: "name1", fathername: "fathername"),
    Students(id: uuid.v4(), name: "name1", fathername: "fathername"),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        child:    Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            ListView.builder(
              itemCount: students.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)

                    ),
                    child: Column(
                      children: [
                        Text("ID: ${index + 1}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
                        Text(students[index].name),
                        Text(students[index].fathername)
                      ],
                    ),

                  ),
                );
              }
          )

          ],

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
              final newStudent= await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addstudent()));

              if(newStudent!=null && newStudent is Students){
                  setState(()  {
                  students.add( newStudent);

                });
              }
        },
        child: Icon(Icons.add),
      ),
      







    );

  }
}
