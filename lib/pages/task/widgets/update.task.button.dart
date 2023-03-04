import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_api/todo_api.dart';

import '../../../dataprovider/task.add.provider.dart';
import '../../../theme/colors.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';
import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class UpdateTaskButton extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;
  final Function onUpdate;

  UpdateTaskButton(this._formKey, this.taskStateProvider, this.onUpdate);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskAddState = ref.watch(taskAddStateProvider);
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
              final TaskDTO updateTask =
                  ref.read(taskStateProvider.notifier).getUpdateTaskData();
              onUpdate(context, updateTask);
            }
          },
          child: taskAddState.when(
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
