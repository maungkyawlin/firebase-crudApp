// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/home.dart';
import 'package:firebase_crud/model/student_model.dart';
import 'package:firebase_crud/text_fields_widget.dart';
import 'package:flutter/material.dart';

class UpdateStudents extends StatelessWidget {
  final Student student;
  UpdateStudents({super.key, required this.student});

  final TextEditingController rollnoController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController marksController = TextEditingController();

  final FocusNode focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    rollnoController.text="${student.rollno}";
    nameController.text=student.name;
    marksController.text="${student.marks}";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Students"),
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
                 
                 Student updateStudent=Student(id:student.id, marks:int.parse(marksController.text), rollno: int.parse(rollnoController.text), name:nameController.text);
                 final collectionReference=FirebaseFirestore.instance.collection('students');
                 collectionReference.doc(updateStudent.id).update(updateStudent.toJson()).whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>  HomePage()  ), (route) => false)
                 );

                }, child: const Text("Student Update")),
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
}
