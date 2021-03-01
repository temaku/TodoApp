import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class  Todo extends Equatable {
  Todo(
      {this.id,
        @required this.title,
        @required this.description,
        @required this.dateCreated,
        @required this.done});

  final String id;
  final String title;
  final String description;
  final String dateCreated;
  final String done;

  @override
  List<Object> get props => [id, title, description, dateCreated,done];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateCreated: json['dateCreated'],
      done: json['done'],
    );
  }

  @override
  String toString() => 'Course { id: $id, title: $title, description: $description,datereated: $dateCreated}';
}