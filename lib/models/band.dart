class Band {
  final String _id;
  String get id => _id;
  final String _name;
  String get name => _name;
  final int _votes;
  int get votes => _votes;

  Band(this._id, this._name, this._votes);

  factory Band.fromMap(Map<String, dynamic> obj) =>
      Band(obj['id'], obj['name'], obj['votes']);
}
