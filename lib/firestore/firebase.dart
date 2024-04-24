import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';

class Blog {
  //Add Blog
  Future addBlog(Map<String,dynamic> uniInfoMap, String id) async{
    return await FirebaseFirestore.instance
        .collection('University')
        .doc(id)
        .set(uniInfoMap);
  }
  Future<Stream<QuerySnapshot>> getUniDetails() async {
    return await FirebaseFirestore.instance.collection('University').snapshots();
  }

  //DELETE BLOG
  static void deleteBlog(BuildContext context, Map<String, dynamic> uniData) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this blog?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (uniData['UserId'] == userId) {
                  FirebaseFirestore.instance.collection('University').doc(uniData['Id']).delete();
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  Blog.showPermissionDeniedDialog(
                    context,
                    "Permission Denied",
                    "You are not the author of this blog.",
                  );
                }
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }


  static void showPermissionDeniedDialog(
      BuildContext context,
      String title,
      String message,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  //UPDATE BLOG


  void updateBlog(BuildContext context, Map<String, dynamic> uniData, Map<String, dynamic> updatedData) {

    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Update"),
          content: Text("Are you sure you want to update this blog?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (uniData['UserId'] == userId) {
                  FirebaseFirestore.instance.collection('University').doc(uniData['Id']).update(updatedData).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Updated Successfully'),
                      ),
                    );

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error updating blog: $error'),
                      ),
                    );
                  });
                } else {
                  Navigator.of(context).pop();
                  showPermissionDeniedDialog(
                    context,
                    "Permission Denied",
                    "You are not the author of this blog.",
                  );
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
