import 'package:mobx/mobx.dart';
import 'package:fullstackdiv_material/app/components/chip/stores/task.dart';

part 'chip_store.g.dart';

class ChipStore = _ChipStore with _$ChipStore;

/// this is the [Store] class to help setting up the [Chip] component
// TODO(Andre): check this
abstract class _ChipStore with Store {
  @observable
  // ignore: prefer_final_fields
  List<Task> _tasks = <Task>[];

  @computed
  List<Task> get allTask {
    return _tasks;
  }

  @action
  void addTask(Task task) {
    _tasks.add(task);
  }

  @action
  void toggleIsSelectedAt(int index) {
    _tasks[index].isSelected = !_tasks[index].isSelected;
  }

  @action
  void toggleIsSelected(Task task) {
    task.isSelected = !task.isSelected;
  }

  @action
  void clearSelection() {
    for (final Task task in _tasks) {
      task.isSelected = false;
    }
  }
}
