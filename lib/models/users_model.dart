import 'package:flutter/cupertino.dart';

const users = [userSam];



const userSam = Users(
  id: "sam",
  name: 'Samrath Arora',
  image: 'https://i.imgur.com/7yUvePI.png',
);
const userVuk = Users(
  id: "Vuk",
  name: 'Vuk',
  image: 'https://i.imgur.com/7yUvePI.png',
);

@immutable
class Users {
  final String id;
  final String name;
  final String image;

  const Users({this.id, this.name, this.image});
}
