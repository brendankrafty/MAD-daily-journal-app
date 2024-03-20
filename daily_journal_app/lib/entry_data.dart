class Entry {
  late int? id;
  late String? etitle;
  late String? econtent;
  late int? emoodRating;

  Entry.i(int this.id, String title, String content, int moodRating) {
    etitle = title;
    econtent = content;
    emoodRating = moodRating;
  }
  Entry({
    required this.id,
    required this.etitle,
    required this.econtent,
    required this.emoodRating,
  });

  Entry.rating(int dietRating, int sleepRating, int moodRating) {
    emoodRating = moodRating;
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': etitle,
      'content': econtent,
      'mood': emoodRating
    };
    return map;
  }

  Entry copyWith({int? id, String? title, String? content, int? rating}) {
    return Entry(
        id: id ?? this.id,
        etitle: title ?? etitle,
        econtent: content ?? econtent,
        emoodRating: rating ?? emoodRating);
  }

  Entry.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    etitle = map['title'];
    econtent = map['content'];
    emoodRating = map['mood'];
  }
}
