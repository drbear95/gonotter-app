import 'package:equatable/equatable.dart';

abstract class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object> get props => [];
}

class PostFetched extends NotesListEvent {}

class NewNote extends NotesListEvent{
  final String title;
  final String content;

  const NewNote({
    this.title,
    this.content
  }): super();

  NewNote copyWith({
    String title,
    String content
  }) {
    return NewNote(
      title: title ?? this.title,
      content: content ?? this.content
    );
  }

  @override
  List<Object> get props => [title, content];
}