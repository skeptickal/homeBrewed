import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String? userID;
  final String email;
 

  const MyUser({
    this.userID,
    required this.email,
 
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

    );
  }

  MyUser copyWith({required String? userID, String? email, String? name}) {
    return MyUser(
      userID: userID ?? this.userID,
      email: email ?? this.email,

    );
  }

  @override
  String toString() {
    return 'email: $email \n userID: $userID,';
  }

  @override
  List<Object?> get props => [userID, email];
}
