// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase CRUD',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('student');

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController dob = TextEditingController();

  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      name.text = documentSnapshot['name'];
      age.text = documentSnapshot['age'].toString();
      address.text = documentSnapshot['address'];
      contact.text = documentSnapshot['contact'].toString();
      dob.text = documentSnapshot['dob'];
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: contact,
                  decoration: const InputDecoration(
                    labelText: 'Contact',
                  ),
                ),   
                TextField(
                  controller: address,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: age,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  controller: dob,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'DOB',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    final String sName = name.text;
                    final String sAddress = address.text;
                    final String sContact = contact.text;
                    final int? sAge = int.tryParse(age.text);
                    final String sDob = dob.text;
                    if (sName.isNotEmpty ||
                        sAddress.isNotEmpty ||
                        sContact.isNotEmpty ||
                        sDob.isNotEmpty ||
                        sAge != null) {
                      await students.add(
                        {
                          'name': sName,
                          'address': sAddress,
                          'contact': sContact,
                          'age': sAge,
                          'dob': sDob,
                        },
                      );
                      name.text = '';
                      address.text = '';
                      contact.text = '';
                      age.text = '';
                      dob.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Student Added Successfully!',
        ),
      ),
    );
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      name.text = documentSnapshot['name'];
      age.text = documentSnapshot['age'].toString();
      address.text = documentSnapshot['address'];
      contact.text = documentSnapshot['contact'].toString();
      dob.text = documentSnapshot['dob'];
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: contact,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Contact',
                  ),
                ),
                TextField(
                  controller: address,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: age,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  controller: dob,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'DOB',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String sName = name.text;
                    final String sAddress = address.text;
                    final String sContact = contact.text;
                    final int? sAge = int.tryParse(age.text);
                    final String sDob = dob.text;
                    if (sAge != null) {
                      await students.doc(documentSnapshot!.id).update(
                        {
                          'name': sName,
                          'address': sAddress,
                          'contact': sContact,
                          'age': sAge,
                          'dob': sDob,
                        },
                      );
                      name.text = '';
                      address.text = '';
                      contact.text = '';
                      age.text = '';
                      dob.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFFB2DFDB),
        content: Text(
          'Student Updated Successfully!',
        ),
      ),
    );
  }

  Future<void> delete(String studentId) async {
    await students.doc(studentId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Student Deleted Successfully!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Firebase CRUD',
        ),
        actions: [
          IconButton(
            onPressed: () => create(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: students.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text(
                      documentSnapshot['age'].toString(),
                    ),
                    title: Text(
                      documentSnapshot['name'],
                    ),
                    subtitle: Text(
                      documentSnapshot['address'] +
                          '\n' +
                          documentSnapshot['contact'].toString() +
                          '\n' +
                          documentSnapshot['dob'],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              update(documentSnapshot);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              delete(documentSnapshot.id);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
