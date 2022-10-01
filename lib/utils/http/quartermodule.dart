import 'dart:ffi';

class Quarter {
  final Int year;
  final Int quarter;

  Quarter({
    required this.year,
    required this.quarter,
  });

  factory Quarter.fromJson(dynamic item) {
    return Quarter(
      year: item['yesr'],
      quarter: item['quarter'],
    );
  }
}
