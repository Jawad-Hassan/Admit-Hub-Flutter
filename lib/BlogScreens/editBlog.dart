import 'package:flutter/material.dart';
import '../customWidgets/CustomAppBar.dart';
import 'package:admit_hub/firestore/firebase.dart';

import '../customWidgets/roundedtextfields.dart';

class EditBlogPage extends StatefulWidget {
  final Map<String, dynamic> uniData;

  EditBlogPage({required this.uniData});

  @override
  _EditBlogPageState createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  TextEditingController universityNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController educationalScheduleController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController rankingController = TextEditingController();
  TextEditingController establishedController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    universityNameController.text = widget.uniData['University Name'];
    cityController.text = widget.uniData['City'];
    educationalScheduleController.text = widget.uniData['Educational Schedule'];
    feeController.text = widget.uniData['Fee'];
    rankingController.text = widget.uniData['Ranking'];
    establishedController.text = widget.uniData['Established'];
    sectorController.text = widget.uniData['Sector'];
    descriptionController.text = widget.uniData['Description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar(title: 'Edit Blog', actions: []),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedTextField(labelText: 'University Name', controller: universityNameController),
              RoundedTextField(labelText: 'City', controller: cityController),
              RoundedTextField(labelText: 'Educational Schedule', controller: educationalScheduleController),
              RoundedTextField(labelText: 'Fee', controller: feeController),
              RoundedTextField(labelText: 'Ranking', controller: rankingController),
              RoundedTextField(labelText: 'Established', controller: establishedController),
              RoundedTextField(labelText: 'Sector', controller: sectorController),
              RoundedTextField(labelText: 'Description', controller: descriptionController),

              SizedBox(height: 16.0),

              Center(
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Map<String, dynamic> updatedData = {
                      'University Name': universityNameController.text,
                      'City': cityController.text,
                      'Educational Schedule': educationalScheduleController.text,
                      'Fee': feeController.text,
                      'Ranking': rankingController.text,
                      'Established': establishedController.text,
                      'Sector': sectorController.text,
                      'Description' : descriptionController.text,
                    };
                    Blog().updateBlog(context, widget.uniData, updatedData);

                  },

                  child: Text('Update Blog'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
