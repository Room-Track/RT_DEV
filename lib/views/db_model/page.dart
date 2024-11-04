import 'package:flutter/material.dart';
import 'package:rtdev/types/model.dart';
import 'package:rtdev/views/db_model/search/page.dart';

class DBModelPage extends StatelessWidget {
  const DBModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Models'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...Model.names.map((name) => ListTile(
                  title: Text(name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModelSearchPage(model: name),
                        ));
                  },
                  leading: Model.getIcon(name),
                ))
          ],
        ),
      ),
    );
  }
}
