import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Source extends Equatable {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[id, name];
}
