class CriteriaTag {
  final String _name;
  final String _imageUrl;

  const CriteriaTag(this._name, this._imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CriteriaTag && name == other.name;

  @override
  int get hashCode => name.hashCode;
  String get name => _name;
  String get imageUrl => _imageUrl;

  @override
  String toString() {
    return name;
  }
}
