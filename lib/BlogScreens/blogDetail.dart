import 'package:flutter/material.dart';
import '../customWidgets/CustomAppBar.dart';
import '../customWidgets/customDetailPage.dart';

class UniversityDetailsPage extends StatelessWidget {
  final Map<String, dynamic> uniData;

  UniversityDetailsPage({required this.uniData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar(
        title: '${uniData['University Name']}',
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(label: 'City:', value: uniData['City']),
            DetailRow(label: 'Sector:', value: uniData['Sector']),
            DetailRow(label: 'Fee:', value: uniData['Fee']),
            DetailRow(label: 'Ranking:', value: uniData['Ranking']),
            DetailRow(label: 'Schedule:', value: uniData['Educational Schedule']),
            DetailRow(label: 'Established:', value: uniData['Established']),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Text(
                      uniData['Description'],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: addToFavoriteList,
      //   child: Icon(Icons.favorite),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }

// void addToFavoriteList() {
//
//   print('Added to favorite list');
// }
}