import 'package:clickbay_flutter/screens/add_post_screen.dart';
import 'package:clickbay_flutter/screens/feed_screen_layout.dart';
import 'package:clickbay_flutter/screens/profile_screen.dart';
import 'package:clickbay_flutter/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize=600;

var homeScreenItems=[
  const FeedScreen(),
  // Text('search'),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];