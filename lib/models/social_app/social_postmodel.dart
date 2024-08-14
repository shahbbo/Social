class PostUserModel
{
  String? name ;
  String? uid ;
  String? image;
  String? dateTime;
  String? text;
  String? PostImage;

  PostUserModel({
    this.name,
    this.uid,
    this.image,
    this.text,
    this.dateTime,
    this.PostImage,
  });

  PostUserModel.fromJson(Map<String,dynamic >? json)
  {
    name = json?['name'];
    uid = json?['uid'];
    image = json?['image'];
    dateTime = json?['dateTime'];
    text = json?['text'];
    PostImage = json?['PostImage'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'uid' : uid ,
        'image' : image ,
        'dateTime' : dateTime,
        'text' : text,
        'PostImage' : PostImage,
      };
  }
}