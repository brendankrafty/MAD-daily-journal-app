class Entry {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Entry({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Entry> sampleEntry = [
  Entry(
    id: 0,
    title: 'Num 1',
    content: 'hi ',
    modifiedTime: DateTime.now(),
  ),
  Entry(
    id: 1,
    title: 'Num 2',
    content: 'bye',
    modifiedTime: DateTime.now(),
  ),
  Entry(
    id: 2,
    title: 'Num 3',
    content: 'alksdjfhaskldjh',
    modifiedTime: DateTime.now(),
  ),
  Entry(
    id: 3,
    title: 'Num 4',
    content: 'ds;kfjasd;lfkj',
    modifiedTime: DateTime.now(),
  ),
  Entry(
    id: 4,
    title: 'Num 5',
    content: '101010 0101010 0010001010100101',
    modifiedTime: DateTime.now(),
  )
];
