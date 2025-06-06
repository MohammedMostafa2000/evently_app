// import 'dart:async';

// import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
// import 'package:evently_app/data/models/event_data_model.dart';
// import 'package:flutter/material.dart';

// class FavoriteEventsProvider extends ChangeNotifier {
//   List<EventDataModel> events = [];
//   StreamSubscription<List<EventDataModel>>? _subscription;

//   void startListening() {
//     _subscription = FirebaseSevices.getFavoriteEventsStreamFromFirestore().listen((fetchedEvents) {
//       events = fetchedEvents;
//       notifyListeners();
//     });
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }
// }
