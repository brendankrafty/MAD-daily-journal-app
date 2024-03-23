import 'database_helper.dart';

class Entry {
  final int? id;
  final String title;
  final String content;
  final int? moodRating;

  Entry({this.id, required this.title, required this.content, this.moodRating});

  Entry copy({int? id, String? title, String? content}) => Entry(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    moodRating: moodRating ?? this.moodRating,
  );

  static Entry fromJson(Map<String, Object?> json) => Entry(
    id: json[EntryFields.id] as int?,
    title: json[EntryFields.title] as String,
    content: json[EntryFields.content] as String,
    moodRating: json['moodRating'] as int?,
  );

  Map<String, Object?> toJson() => {
    EntryFields.id: id,
    EntryFields.title: title,
    EntryFields.content: content,
    'moodRating': moodRating,
  };
}