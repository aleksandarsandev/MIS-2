import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ListScreen extends StatelessWidget {
  final String jokeType;

  ListScreen({required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jokeType),
        backgroundColor: Colors.green.shade50,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade50,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.getJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading jokes"));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(joke['setup']),
                    subtitle: Text(joke['punchline']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
