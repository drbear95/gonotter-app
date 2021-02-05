import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonotter_app/core/request_status.dart';
import 'package:gonotter_app/pages/notes/bloc/notes_page_bloc.dart';
import 'package:gonotter_app/pages/notes/widgets/bottom_loader.dart';
import 'package:gonotter_app/pages/notes/widgets/note_list_item.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../bloc/notes_page_event.dart';
import '../bloc/notes_page_state.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final _scrollController = ScrollController();
  NotesListBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<NotesListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        switch (state.status.state) {
          case RequestState.error:
            return const Center(child: Text('failed to fetch posts'));
          case RequestState.ok:
            if (state.notes.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: NoteListItem(note: state.notes[index]));
              },
              itemCount: state.notes.length,

              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
