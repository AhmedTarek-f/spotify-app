import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  final String id;
  final String userName;
  final String email;

  static UserModel empty() => const UserModel(id: "", userName: "", email: "");

  Map<String ,dynamic > toJson() {
    return {
      "Id":id,
      "UserName":userName,
      "Email":email,
    };
  }

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = camelCaseUsername; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      Map<String, dynamic> data = document.data()!;
      return UserModel(
          id: data["Id"] as String,
          userName: data["UserName"] as String,
          email: data["Email"] as String,
      );
    }
    else{
      return empty();
    }
  }
}