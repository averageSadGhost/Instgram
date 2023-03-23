class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  UserModel(
    this.email,
    this.uid,
    this.photoUrl,
    this.userName,
    this.bio,
    this.followers,
    this.following,
  );

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "profilePicUrl": photoUrl,
      };
}
