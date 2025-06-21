import '../../core/api/end_ponits.dart';

class GetUserModel {
  final int id;
  final String nom;
  final String prenom;
  final String matricule;
  final String phone;
  final String longitude;
  final String latitude;
  final bool isActive;

  GetUserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.phone,
    required this.longitude,
    required this.latitude,
    required this.isActive,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> jsonData) {
    return GetUserModel(
      id: jsonData['id'],
      nom: jsonData['nom'],
      prenom: jsonData['prenom'],
      matricule: jsonData['matricule_de_voiture'],
      phone: jsonData['numero_de_telephone'],
      longitude: jsonData['longitude'] ?? "0",
      latitude: jsonData['latitude'] ?? "0",
      isActive: jsonData['is_active'] ?? false,
    );
  }
}
