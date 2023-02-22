import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/service/impl/todo.service.impl.dart';

final todoProvider = Provider<TodoServiceImpl>((ref) => TodoServiceImpl());
