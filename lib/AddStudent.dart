import 'package:flutter/material.dart';
import 'package:flutterprojecttodo/Studentinfo.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  void savestudent(){
    String name = nameController.text;
    String Fathername= fatherController.text;
    final newStudent= Students(

        name:name,
        fathername: Fathername
    );
    Navigator.pop(context,newStudent);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 50,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter name"
            ),
          ),
          TextField(
            controller: fatherController,
            decoration: InputDecoration(
                hintText: "Enter Fathername"
            ),
          ),
          InkWell(
            onTap: (){
               savestudent();
            },
            child:
            Container(
              width: 140,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color:Colors.white,size: 25,),
                  Text("Add",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),)

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
