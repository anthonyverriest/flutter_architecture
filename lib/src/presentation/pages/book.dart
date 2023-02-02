import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/data/models/book.dart';
import 'package:flutter_architecture/src/logic/blocs/book.dart';

class BookPage extends StatelessWidget {
  final _bookBloc = BookBloc();

  BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Books'),
        StreamBuilder(
            stream: _bookBloc.getBooks(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView(
                shrinkWrap: true,
                children: snapshot.data!
                    .map((Book e) => ListTile(title: Text(e.title)))
                    .toList(),
              );
            }),
      ],
    );
  }
}
