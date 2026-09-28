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
  var varUuid= const Uuid();
  late List<Students> students = [
    Students(id: varUuid.v4(), name: "Yasir", fathername: "Idrees"),
    Students(id: varUuid.v4(), name: "Ali", fathername: "Usman"),
    Students(id: varUuid.v4(), name: "Bilal", fathername: "Tariq"),
  ];
  Future<void> _navigateAndSaveStudent([Students? existingStudent,int? index])async {
       final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Addstudent(studentToEdit:existingStudent )));
       if(result!=null || result is Students){
         setState(() {
           if(index!=null){
             students[index]=result;
           }else{
             result.id=varUuid.v4();
             students.add(result);
           }
         });
       }
  }
  void _deletestudent(int index){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: const Text("Delete Student"),
          content: Text("Are you sure you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  students.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Records (CRUD)"),
        backgroundColor: Colors.blue,
      ),
      body: students.isEmpty? const Center(child: Text("No student is showing,tap + to add"),):
          ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                final student=students[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    // 1. ID on the far left inside a CircleAvatar
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // 2. Name
                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    // 3. Father Name (Subtitle with top padding for spacing)
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text("Father: ${student.fathername}"),
                    ),

                    // 4. Edit & Delete Buttons on the far right using a Row
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Prevents row from taking full width
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _navigateAndSaveStudent(student, index);
                          },
                        ),
                        // Space between Edit and Delete buttons
                        
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deletestudent(index);
                          },
                        ),
                      ],
                    ),
                  ),

                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndSaveStudent(); // Open in CREATE mode
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
