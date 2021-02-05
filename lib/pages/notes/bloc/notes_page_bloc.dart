import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/api_client.dart';
import 'package:gonotter_app/api/model/note.dart';
import 'package:gonotter_app/core/request_status.dart';
import 'package:gonotter_app/pages/notes/bloc/notes_page_event.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'notes_page_state.dart';

const _postLimit = 20;

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc() : super(const NotesListState());
  var clientProvider = GetIt.I<ApiClient>();

  @override
  Stream<Transition<NotesListEvent, NotesListState>> transformEvents(
      Stream<NotesListEvent> events,
      TransitionFunction<NotesListEvent, NotesListState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NotesListState> mapEventToState(NotesListEvent event) async* {
    if (event is PostFetched) {
      yield await _mapPostFetchedToState(state);
    }

    if (event is NewNote) {
      await _mapNewNote(event);
    }
  }

  _mapNewNote(NewNote event) async{
    final client = await clientProvider.getGraphQLClient();
    await client.mutate(MutationOptions(documentNode: gql("mutation{newNote(title: \"${event.title}\", content: \"${event.content}\"){title}}")));
  }

  Future<NotesListState> _mapPostFetchedToState(NotesListState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status.state == RequestState.notStarted) {
        final notes = await _fetchNotes();
        return state.copyWith(
          status: RequestStatus.ok(notes),
          posts: notes,
          hasReachedMax: _hasReachedMax(notes.length),
        );
      }
      final notes = await _fetchNotes(state.notes.length);
      return notes.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: RequestStatus.ok(notes),
        posts: List.of(state.notes)..addAll(notes),
        hasReachedMax: _hasReachedMax(notes.length),
      );
    } catch (e) {
      return state.copyWith(status: RequestStatus.error(e));
    }
  }

  Future<List<Note>> _fetchNotes([int startIndex = 0]) async {
    final client = await clientProvider.getGraphQLClient();
    final queryResult = await client.query(QueryOptions(documentNode: gql("query{note(take: $_postLimit, skip:$startIndex){title,content}}")));

    return (queryResult.data["note"] as List)
        .map((e) => Note.fromJson(e))
        .toList();
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? false : true;
}