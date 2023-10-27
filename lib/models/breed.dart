class Breed {
  Map<String, dynamic> breeds;
  String status;

  Breed({required this.breeds, required this.status});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(breeds: json['message'], status: json['status']);
  }
}
