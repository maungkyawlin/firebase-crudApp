// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add_student.dart';
import 'package:firebase_crud/update_student.dart';
import 'package:flutter/material.dart';

import 'model/student_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Firebase"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _reference.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            }
            //has data received form firebase 
            if(snapshot.hasData){
              QuerySnapshot querySnapshot=snapshot.data!;
              List<QueryDocumentSnapshot> documents=querySnapshot.docs;
              //Convert to list data from database
              List<Student> students=documents.map((e) => Student(id:e["id"],marks:e["marks"], rollno:e[ "rollno"], name: e["name"])).toList();
              return  getBody(students);
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddStudents()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget getBody(students){
    return students.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: students.length,
                itemBuilder: ((context, index) => Card(
                  color: students[index].marks<40?Colors.red:students[index].marks>75?Colors.green:Colors.yellow,
                      child: ListTile(
                        title: Text(students[index].name),
                        leading: CircleAvatar(
                          radius: 25,
                          child: Text("${students[index].marks}"),
                        ),
                        trailing: SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Icon(Icons.edit),
                                
                                onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateStudents(student: students[index])));
                              },),
                              
                              InkWell(
                                child: Icon(Icons.delete),
                                
                                onTap: () {
                                  _reference.doc(students[index].id).delete();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                
                              },)
                            ],
                          ),
                        ),
                      ),
                    )),
              );
  }
}
