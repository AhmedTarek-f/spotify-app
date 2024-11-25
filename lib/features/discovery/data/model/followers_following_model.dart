import 'package:cloud_firestore/cloud_firestore.dart';

class FollowersFollowingModel{
  const FollowersFollowingModel({
    required this.userId,
  });
  final String userId;

  static FollowersFollowingModel empty() => const FollowersFollowingModel(userId: "");

  Map<String,dynamic> toJson() {
    return {
      "UserId":userId,
    };
  }

  factory FollowersFollowingModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      final snapshot = document.data()!;
      return FollowersFollowingModel(
          userId: snapshot["UserId"] as String
      );
    }
    else{
      return empty();
    }
  }
}