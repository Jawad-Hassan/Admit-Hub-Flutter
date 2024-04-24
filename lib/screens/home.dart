import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../BlogScreens/AddBlog.dart';
import '../BlogScreens/blogDetail.dart';
import '../BlogScreens/editBlog.dart';
import '../customWidgets/CustomAppBar.dart';
import '../customWidgets/UniText.dart';
import '../customWidgets/iconButton.dart';
import '../firestore/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot>? uniStream;
  TextEditingController _searchController = TextEditingController();

  Widget uniInfo() {
    uniStream = FirebaseFirestore.instance
        .collection('University')
        .where('University Name',
            isGreaterThanOrEqualTo: _searchController.text)
        .where('University Name', isLessThan: _searchController.text + 'z')
        .snapshots();

    return StreamBuilder(
      stream: uniStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return snapshot.hasData
                ? Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var uniData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Container(
                          margin: EdgeInsets.all(4.0),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue.shade900,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    uniTilte(
                                      text: '${uniData['University Name']}',
                                    ),
                                    if (uniData['UserId'] == FirebaseAuth.instance.currentUser?.uid)
                                      Container(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            CustomIconButton(
                                              icon: Icons.edit,
                                              onPressed: () {
                                                navigateToEditBlogPage(uniData);
                                              },
                                              color: Colors.green.shade800,
                                            ),
                                            CustomIconButton(
                                              icon: Icons.delete,
                                              onPressed: () {
                                                deleteBlog(uniData);
                                              },
                                              color: Colors.red.shade600,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('City: ${uniData['City']}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                    Text('Sector: ${uniData['Sector']}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        'Established: ${uniData['Established']}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                onTap: () {
                                  navigateToUniDetailsPage(uniData);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container();
        }
      },
    );
  }

  void navigateToUniDetailsPage(Map<String, dynamic> uniData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversityDetailsPage(uniData: uniData),
      ),
    );
  }

  void navigateToEditBlogPage(Map<String, dynamic> uniData) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (uniData['UserId'] == userId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditBlogPage(uniData: uniData),
        ),
      );
    } else {
      showPermissionDeniedDialog(
          "Permission Denied", "You are not author of this blog.");
    }
  }

  void deleteBlog(Map<String, dynamic> uniData) {
    Blog.deleteBlog(context, uniData);
  }

  void showPermissionDeniedDialog(String title, String message) {
    Blog.showPermissionDeniedDialog(context, title, message);
  }

  @override
  void initState() {
    super.initState();
    uniStream = FirebaseFirestore.instance.collection('University').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBlog()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: CustomAppBar(title: 'Home Page', actions: [
        IconButton(
          icon: Icon(Icons.logout),
          color: Colors.blue.shade900,
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Search by University Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Expanded(
            child: uniInfo(),
          ),
        ],
      ),
    );
  }
}
