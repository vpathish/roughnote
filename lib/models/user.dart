// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class GloabalUser {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;
  final int credit_points;
  final String coverUrl;
  final bool userIsVerified;
  final bool no_ads;
  String activeVipId = '';

  GloabalUser({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.bio,
    required this.credit_points,
    required this.no_ads,
    required this.coverUrl,
    required this.userIsVerified,
  });

  /// Set Active VIP Subscription ID
  // void setActiveVipId(String subscriptionId) {
  //   this.activeVipId = subscriptionId;
  //   notifyListeners();
  // }

  factory GloabalUser.fromDocument(DocumentSnapshot doc) {
    return GloabalUser(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      bio: doc['bio'],
      credit_points: doc['credit_points'],
      coverUrl: doc['coverUrl'],
      userIsVerified: doc['userIsVerified'],
      no_ads: doc['no_ads'],
    );
  }

  factory GloabalUser.fromMap(Map<String, dynamic> map) {
    return GloabalUser(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      username: map['username'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      bio: map['bio'] as String? ?? '',
      credit_points: map['credit_points'],
      coverUrl: map['coverUrl'] as String? ?? '',
      userIsVerified: map['userIsVerified'],
      no_ads: map['no_ads'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'bio': bio,
      'credit_points': credit_points,
      'searchIndexes': searchIndexes,
      'coverUrl': coverUrl,
      'userIsVerified': userIsVerified,
      'no_ads': no_ads,
    };
  }

  List<String> get searchIndexes {
    final indices = <String>[];
    for (final s in [username, displayName]) {
      for (var i = 1; i < s.length; i++) {
        indices.add(s.substring(0, i).toLowerCase());
      }
    }
    return indices;
  }

  static final usersCol =
      FirebaseFirestore.instance.collection('users').withConverter<GloabalUser>(
            fromFirestore: (e, _) => GloabalUser.fromMap(e.data()!),
            toFirestore: (m, _) => m.toMap(),
          );
  static DocumentReference<GloabalUser> userDoc([String? id]) =>
      usersCol.doc(id ?? id);

  static Future<GloabalUser?> fetchUser([String? id]) async {
    final doc = await userDoc(id ?? id).get();
    return doc.data();
  }
}
