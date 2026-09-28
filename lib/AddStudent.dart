import 'package:flutter/material.dart';
import 'Studentinfo.dart';

class Addstudent extends StatefulWidget {
  final Students? studentToEdit; // If provided, we are in UPDATE mode

  const Addstudent({super.key, this.studentToEdit});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  late TextEditingController nameController;
  late TextEditingController fatherController;

  @override
  void initState() {
    super.initState();
    // Prefill text fields if editing an existing student
    nameController = TextEditingController(
      text: widget.studentToEdit != null ? widget.studentToEdit!.name : '',
    );
    fatherController = TextEditingController(
      text: widget.studentToEdit != null ? widget.studentToEdit!.fathername : '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherController.dispose();
    super.dispose();
  }

  void savestudent() {
    String name = nameController.text.trim();
    String fathername = fatherController.text.trim();

    if (name.isEmpty || fathername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final updatedStudent = Students(
      id: widget.studentToEdit?.id, // Keep existing ID if editing
      name: name,
      fathername: fathername,
    );

    Navigator.pop(context, updatedStudent);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.studentToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Student" : "Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fatherController,
              decoration: const InputDecoration(
                labelText: "Father Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: savestudent,
              child: Container(
                width: 160,
                height: 45,
                decoration: BoxDecoration(
                  color: isEditing ? Colors.orange : Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isEditing ? Icons.save : Icons.add,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isEditing ? "Update" : "Add",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}