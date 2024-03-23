class Entry {
  final int? id;
  final String title;
  final String content;
  final int? moodRating;

  Entry({this.id, required this.title, required this.content, this.moodRating});

  Entry copy({int? id, String? title, String? content, int? moodRating}) => Entry(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    moodRating: moodRating ?? this.moodRating,
  );

  static Entry fromJson(Map<String, Object?> json) => Entry(
    id: json['id'] as int?,
    title: json['title'] as String,
    content: json['content'] as String,
    moodRating: json['moodRating'] as int?,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'moodRating': moodRating,
  };
}