import 'package:equatable/equatable.dart';
import 'package:gonotter_app/api/model/note.dart';
import 'package:gonotter_app/core/request_status.dart';

class NotesListState extends Equatable {
  const NotesListState({
    this.status = const RequestStatus.notStarted(),
    this.notes = const <Note>[],
    this.hasReachedMax = false,
  });

  final RequestStatus<List<Note>> status;
  final List<Note> notes;
  final bool hasReachedMax;

  NotesListState copyWith({
    RequestStatus<List<Note>> status,
    List<Note> posts,
    bool hasReachedMax,
  }) {
    return NotesListState(
      status: status ?? this.status,
      notes: posts ?? this.notes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, notes, hasReachedMax];
}