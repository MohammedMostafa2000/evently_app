import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/data/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSevices {
  static Future<void> addEventToFirestore(EventDataModel event) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> eventsCollection = db.collection('events');
    DocumentReference<Map<String, dynamic>> document = eventsCollection.doc();
    String eventID = document.id;
    document.set(event.toJson(eventID));
  }

  static Stream<List<EventDataModel>> getEventsStreamFromFirestore(String categoryID) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = FirebaseFirestore.instance
        .collection('events')
        .orderBy('date')
        .where('categoryID', isEqualTo: categoryID == '1' ? null : categoryID)
        .snapshots();
    Stream<List<EventDataModel>> eventDataModelList = snapshots.map((querySnapshot) => querySnapshot
        .docs
        .map((queryDocumentSnapshot) => EventDataModel.fromJson(queryDocumentSnapshot.data()))
        .toList());
    yield* eventDataModelList;
  }

  static Stream<List<EventDataModel>> getFavoriteEventsStreamFromFirestore() {
    final favoriteEventsIds = UserDataModel.currentUser!.favoriteEventsIds;

    if (favoriteEventsIds.isEmpty) {
      return Stream.value([]);
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = FirebaseFirestore.instance
        .collection('events')
        .orderBy('date')
        .where('eventID', whereIn: favoriteEventsIds)
        .snapshots();
    return snapshots.map((querySnapshot) =>
        querySnapshot.docs.map((doc) => EventDataModel.fromJson(doc.data())).toList());
  }

  static Future<void> addFavoriteEventToFirestore(String eventID) async {
    UserDataModel currentUser = UserDataModel.currentUser!;
    currentUser.favoriteEventsIds.add(eventID);
    // update user data
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = db.collection('users');
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(currentUser.id);
    await userDocument.set(currentUser.toJson());
  }

  static Future<void> removeFavoriteEventToFirestore(String eventID) async {
    UserDataModel currentUser = UserDataModel.currentUser!;
    currentUser.favoriteEventsIds.remove(eventID);
    // update user data
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = db.collection('users');
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(currentUser.id);
    await userDocument.set(currentUser.toJson());
  }

  static Future<bool> checkFavoriteEvent(String eventID) async {
    UserDataModel currentUser = UserDataModel.currentUser!;
    return currentUser.favoriteEventsIds.contains(eventID);
  }

  static Future<void> createAccountWithEmailAndPassword(
      {required String emailAddress, required String password, required String name}) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    UserDataModel user = UserDataModel(
        name: name, id: credential.user!.uid, email: emailAddress, favoriteEventsIds: []);
    await addUserToFirestore(user);
  }

  static Future<void> loginWithEmailAndPassword(String emailAddress, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);

    UserDataModel? user = await getUserFromFirestore(credential.user!.uid);
    UserDataModel.currentUser = user;
  }

  static Future<void> addUserToFirestore(UserDataModel user) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> usersCollection = db.collection('users');
    DocumentReference<Map<String, dynamic>> document = usersCollection.doc(user.id);
    return document.set(user.toJson());
  }

  static Future<UserDataModel?> getUserFromFirestore(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = db.collection('users');
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(userId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await userDocument.get();
    return UserDataModel.fromJson(documentSnapshot.data()!);
  }
}
