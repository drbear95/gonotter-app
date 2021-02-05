import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

class GraphQLDataConverter<TData> implements JsonConverter<LinkedHashMap<String,dynamic>, List<TData>> {
  @override
  LinkedHashMap<String, dynamic> fromJson(List<TData> json) {
    throw Exception("Not implemented");
  }

  @override
  List<TData> toJson(LinkedHashMap<String, dynamic> object) {
    return new List<TData>(10);
  }

}