import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../dataprovider/todo.add.provider.dart';
import '../../../openapi/lib/api.dart';
import '../../../theme/colors.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';
import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class UpdateTodoButton extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;
  final Function onUpdate;

  UpdateTodoButton(this._formKey, this.todoStateProvider, this.onUpdate);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAddState = ref.watch(todoAddStateProvider);
    print("button");
    return Expanded(
        child: Container(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: profileItem,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final TodoDTO updateTodo =
                  ref.read(todoStateProvider.notifier).getUpdateTodoData();
              onUpdate(context, updateTodo);
            }
          },
          child: todoAddState.when(
              data: (data) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Iconsax.edit, weight: 22),
                    const SizedBox(width: 20),
                    Expanded(child: Text("Update"))
                  ],
                );
              },
              error: (err, s) => ErrorDialog(
                  errorObject: ErrorObject.mapErrorToObject(error: err)),
              loading: () {
                return Center(
                    child: CircularProgressIndicator(color: primaryColor));
              }),
        ),
      ),
    ));
  }
}
