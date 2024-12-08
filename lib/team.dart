import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String id;
  final String alumno;
  final String apellido;
  final String matricula;

  Team(
      {required this.id,
      required this.alumno,
      required this.apellido,
      required this.matricula});

  // Convertir un Team a un Map
  Map<String, dynamic> toMap() {
    return {
      'alumno': alumno,
      'apellido': apellido,
      'matricula': matricula,
    };
  }

  // Crear un team desde un DocumentSnapShot
  factory Team.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Team(
      id: doc.id,
      alumno: doc['alumno'],
      apellido: doc['apellido'],
      matricula: doc['matricula'],
    );
  }
}
