extension DynamicExensions<T> on dynamic {
  List<T> castToList(T Function(Map<String, dynamic>) callback) {
    if (this is! List || this.isEmpty || this.first is! Map<String, dynamic>) {
      return [];
    }
    return (this as List<dynamic>)
        .map((e) => callback(e as Map<String, dynamic>))
        .toList();
  }
}
