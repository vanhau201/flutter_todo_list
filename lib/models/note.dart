class Note {
  final String id;
  final String title;
  final String content;
  final DateTime modifiedTime;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.modifiedTime});
}

List<Note> sampleNotes = [
  Note(
      id: "1",
      title: "Học lập trình flutter cơ bản",
      content:
          "Each different area of requires a separate initialization process. That way, if the application only needs to format dates, it doesn't need to take the time or space to load up messages, numbers, or other things it may not need.",
      modifiedTime: DateTime(2023, 1, 1, 34, 5)),
  Note(
      id: "2",
      title: "Học lập trình Python cơ bản",
      content:
          "Each different area of requires a separate initialization process. That way, if the application only needs to format dates, it doesn't need to take the time or space to load up messages, numbers, or other things it may not need.",
      modifiedTime: DateTime(2023, 1, 3, 34, 5)),
  Note(
      id: "3",
      title: "Học lập trình Java cơ bản",
      content:
          "Each different area of requires a separate initialization process. That way, if the application only needs to format dates, it doesn't need to take the time or space to load up messages, numbers, or other things it may not need.",
      modifiedTime: DateTime(2023, 1, 2, 34, 5))
];
