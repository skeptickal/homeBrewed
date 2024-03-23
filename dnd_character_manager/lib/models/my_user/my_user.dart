import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String userID;
  final String email;
  final String? name;

  const MyUser({
    required this.userID,
    required this.email,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userID': userID,
      'email': email,
    };
    return data;
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      userID: json['userID'].toString(),
      email: json['email'].toString(),
      name: json['name'].toString(),
    );
  }

  MyUser copyWith({required String? userID, String? email, String? name}) {
    return MyUser(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [userID, email];
}
