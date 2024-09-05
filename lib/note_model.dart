class NoteModel{
  final int? id;
  final String title;
  final String desc;

  NoteModel({this.id, required this.title, required this.desc});

  NoteModel copy({
    int? id,
    String? title,
    String? desc,

  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
      );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title': title,
      'desc':desc
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      // status: map['status']?? '',
    );
  }
}


