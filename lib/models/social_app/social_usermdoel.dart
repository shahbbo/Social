class SocialUserModel
{
  String? name ;
  String? email ;
  String? phone;
  String? uid ;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified ;

 SocialUserModel({
   this.name,
   this.email,
   this.phone,
   this.uid,
   this.image,
   this.cover,
   this.bio,
   this.isEmailVerified,
 });

 SocialUserModel.fromJson(Map<String,dynamic >? json)
 {
   email = json?['email'];
   name = json?['name'];
   phone = json?['phone'];
   uid = json?['uid'];
   image = json?['image'];
   cover = json?['cover'];
   bio = json?['bio'];
   isEmailVerified = json?['isEmailVerified'];
 }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'email' : email,
        'phone':phone,
        'uid' : uid ,
        'image' : image ,
        'cover' :cover,
        'bio' : bio,
        'isEmailVerified': isEmailVerified ,
      };
  }
}