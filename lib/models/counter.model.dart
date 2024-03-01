class Counter {
  String label;
  int count;

  Counter(
    this.label, [
    this.count = 0,
  ]);

  Counter.fromJson(Map<String, dynamic> json)
      : label = json['label'] as String,
        count = json['count'] as int;

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'count': count,
    };
  }

  @override
  String toString() {
    String str = '\nLabel: $label';
    str += '\nCount: $count';

    return '$str\n';
  }
}
