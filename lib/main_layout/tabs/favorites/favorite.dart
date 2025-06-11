import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/main_layout/widgets/custom_event_card.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseSevices.getFavoriteEventsStreamFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }

        final events = snapshot.data;

        if (events == null || events.isEmpty) {
          return const Center(child: Text('لا توجد فعاليات مفضلة'));
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return CustomEventCard(event: event);
          },
        );
      },
    );
  }
}
