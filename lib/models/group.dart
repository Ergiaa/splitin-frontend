import 'package:splitin_frontend/models/participant.dart';

class Group {
  final String id;
  final String name;
  final List<Participant> members;

  Group({
    required this.id,
    required this.name,
    required this.members,
  });
}