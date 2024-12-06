import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingFollowersModel{
  const FollowingFollowersModel({
  required this.following,
  required this.followers,
  });
  final num following;
  final num followers;

  static FollowingFollowersModel empty() => const FollowingFollowersModel(following: 0, followers: 0);

  factory FollowingFollowersModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data() != null){
      final snapshot = document.data()!;
      return FollowingFollowersModel(
          following: snapshot["Following"],
          followers: snapshot["Followers"]
      );
    }
    else{
      return empty();
    }
  }
}