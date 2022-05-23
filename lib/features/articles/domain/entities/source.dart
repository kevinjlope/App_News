

class Source {
  Source({
    this.id,
    required this.name,
  });

  String? id;
  String name;
  
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
