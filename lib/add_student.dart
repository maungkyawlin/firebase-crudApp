// ignore_for_file: must_be_immutable



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/home.dart';
import 'package:firebase_crud/model/student_model.dart';
import 'package:firebase_crud/text_fields_widget.dart';
import 'package:flutter/material.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final TextEditingController rollnoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final FocusNode focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Students"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyTextFields().getTextFields(context, "Enter RollNo", "Roll Number",
                textInputType: TextInputType.number,
                controller: rollnoController,
                focusNode: focusNode),
            MyTextFields().getTextFields(context, "Enter Name", "Name",
                textInputType: TextInputType.text, controller: nameController),
            MyTextFields().getTextFields(context, "Enter marks", "Marks",
                textInputType: TextInputType.number,
                controller: marksController),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: () {
                  Student student=Student(rollno: int.parse(rollnoController.text),name: nameController.text,marks: int.parse(marksController.text),);
                  addStudentsandNavigateToHome(student,context);
                }, child: const Text("Student Add")),
                const SizedBox(width: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                     
                      rollnoController.text = "";
                      nameController.text = "";
                      marksController.text = "";
                      focusNode.requestFocus();
                    
                    },
                    child: const Text("Reset"))
              ],
            )
          ],
        ),
      ),
    );
  }
  
  void addStudentsandNavigateToHome(Student student, BuildContext context) {
    final  StudentRef=FirebaseFirestore.instance.collection("students").doc();
    student.id=StudentRef.id;
    final data=student.toJson();
    StudentRef.set(data).whenComplete(() {
      
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);
    });
  }
}
