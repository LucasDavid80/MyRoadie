class EventModel {
  final String id; // Bom para identificar no Firebase depois
  final String title;
  final String type; // Show, Ensaio, etc.
  final DateTime date;
  final String startTime;
  final String endTime;
  final String location;
  final double fee;
  final String notes;

  EventModel({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.fee,
    this.notes = '',
  });

  // Construtor vazio para facilitar a criação inicial
  factory EventModel.empty() {
    return EventModel(
      id: '',
      title: '',
      type: '',
      date: DateTime.now(),
      startTime: '',
      endTime: '',
      location: '',
      fee: 0.0,
      notes: '',
    );
  }

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, type: $type, date: $date, startTime: $startTime, endTime: $endTime, location: $location, fee: $fee, notes: $notes)';
  }
}
