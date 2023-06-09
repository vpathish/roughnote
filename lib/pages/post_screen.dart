import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simpleworld/pages/home.dart';
import 'package:simpleworld/widgets/header.dart';
import 'package:simpleworld/widgets/progress.dart';
import 'package:simpleworld/widgets/single_post.dart';

class PostScreen extends StatelessWidget {
  final String? userId;
  final String? postId;

  const PostScreen({Key? key, this.userId, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: postsRef.doc(userId).collection('userPosts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        SinglePost post = SinglePost.fromDocument(snapshot.data!);
        return Center(
          child: Scaffold(
            appBar: header(context, titleText: post.description),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
