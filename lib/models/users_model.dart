import 'package:flutter/cupertino.dart';

const users = [userSam, userVuk];



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

  const Users({required this.id, required this.name, required this.image});
}
