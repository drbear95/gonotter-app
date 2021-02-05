import 'package:flutter/material.dart';
import 'package:gonotter_app/api/model/note.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({Key key, @required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(note.title),
      isThreeLine: true,
      subtitle: Text(note.content),
      dense: true,
    );
  }
}