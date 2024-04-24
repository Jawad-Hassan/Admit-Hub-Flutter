import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admit_hub/firestore/firebase.dart';
import '../customWidgets/CustomAppBar.dart';
import '../customWidgets/roundedtextfields.dart';
import 'package:random_string/random_string.dart';
import '../screens/home.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController universityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController rankingController = TextEditingController();
  TextEditingController establishedController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    universityController.dispose();
    cityController.dispose();
    scheduleController.dispose();
    feeController.dispose();
    rankingController.dispose();
    establishedController.dispose();
    sectorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar(
        title: 'Add Blog', actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RoundedTextField(
                  controller: universityController,
                  labelText: 'University Name',
                ),
                RoundedTextField(
                  controller: cityController,
                  labelText: 'City',
                ),
                RoundedTextField(
                  controller: sectorController,
                  labelText: 'Sector',
                ),
                RoundedTextField(
                  controller: feeController,
                  labelText: 'Fee Structure',
                ),
                RoundedTextField(
                  controller: rankingController,
                  labelText: 'Ranking',
                ),
                RoundedTextField(
                  controller: scheduleController,
                  labelText: 'Schedule',
                ),
                RoundedTextField(
                  controller: establishedController,
                  labelText: 'Established',
                ),
                RoundedTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String id = randomAlphaNumeric(10);
                      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

                      Map<String, dynamic> uniInfoMap = {
                        'University Name': universityController.text,
                        'City': cityController.text,
                        'Sector': sectorController.text,
                        'Fee': feeController.text,
                        'Ranking': rankingController.text,
                        'Id': id,
                        'Educational Schedule': scheduleController.text,
                        'UserId': userId,
                        'Established': establishedController.text,
                        'Description' : descriptionController.text,
                      };

                      await Blog().addBlog(uniInfoMap, id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data uploaded successfully!'),
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    }
                  },
                  child: Text('Add Blog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
