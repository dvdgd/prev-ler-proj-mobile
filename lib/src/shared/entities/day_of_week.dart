class DayOfWeek {
  int idWeekday;
  String name;

  DayOfWeek({
    required this.idWeekday,
    required this.name,
  });

  factory DayOfWeek.fromMap(Map<String, dynamic> map) {
    return DayOfWeek(
      idWeekday: map['idDiaSemana'],
      name: map['nome'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'idDiaSemana': idWeekday, 'nome': name};
  }
}
