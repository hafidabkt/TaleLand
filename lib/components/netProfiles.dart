import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/homePage.dart';

List<Profile> netProfiles(List<Profile> profiles) {
  List<Profile> temp = [];
  for (int i = 0; i < profiles.length; i++) {
    if (!user.blockedList.contains(profiles[i].id)) {
      temp.add(profiles[i]);
    }
  }
  return temp;
}
