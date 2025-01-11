import 'package:flutter/material.dart';

enum Priority{
  high(name: 'highPriority', color: Colors.red),
  medium(name: 'mediumPriority', color: Colors.orange),
  low(name: 'lowPriority', color: Colors.green),
  none(name: 'noPriority');
  
  const Priority({
    required this.name,
    this.color
  });

  final String name;
  final Color? color;
}