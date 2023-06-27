class CacheModel {
  final String id;
  final DateTime date;
  final dynamic data;

  CacheModel({
    required this.id,
    required this.date,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'data': data,
    };
  }
}
