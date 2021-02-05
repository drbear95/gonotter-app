import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonotter_app/pages/application_page.dart';
import 'package:gonotter_app/pages/notes/bloc/notes_page_bloc.dart';
import 'package:gonotter_app/pages/notes/bloc/notes_page_event.dart';
import 'package:gonotter_app/pages/notes/widgets/notes_list.dart';

class NotesPage extends ApplicationPage {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    return BlocProvider<NotesListBloc>(
        create: (_) => NotesListBloc()..add(PostFetched()),
        lazy: false,
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Notes')),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showAddDialog(context);
              },
            ),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  return context.read<NotesListBloc>().add(PostFetched());
                },
                child: NotesList()),
          ),
        ));
  }

  void showAddDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Add note"),
          content: _inputWidget(ctx),
          actions: [
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                ctx.read<NotesListBloc>().add(NewNote(
                    title: titleController.text,
                    content: contentController.text));
              },
            ),
          ],
        ));
  }

  Widget _inputWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _entryField(context, "Title"),
        SizedBox(height: 25),
        _entryField(context, "Content"),
      ],
    );
  }

  Widget _entryField(BuildContext context, String title) {
    var controller;
    if (title == "Title") {
      controller = titleController;
    } else {
      controller = contentController;
    }
    return TextFormField(
      maxLines: null,
      onChanged: (text) {},
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
    );
  }
}
