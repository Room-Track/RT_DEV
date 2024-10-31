import 'package:flutter/material.dart';

class FieldWrap extends StatelessWidget {
  final List<String> keys;
  final List<dynamic> values;
  const FieldWrap({super.key, required this.keys, required this.values});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: [
        ...keys.indexed.map((element) => Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(232, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "${element.$2}:\n${values.elementAt(element.$1)}",
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ));
                },
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text(
                            "${element.$2} : ${values.elementAt(element.$1)}"),
                      ),
                    )),
              ),
            ))
      ],
    );
  }
}
