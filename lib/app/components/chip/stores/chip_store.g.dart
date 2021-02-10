// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChipStore on _ChipStore, Store {
  Computed<List<Task>> _$allTaskComputed;

  @override
  List<Task> get allTask => (_$allTaskComputed ??=
          Computed<List<Task>>(() => super.allTask, name: '_ChipStore.allTask'))
      .value;

  final _$_tasksAtom = Atom(name: '_ChipStore._tasks');

  @override
  List<Task> get _tasks {
    _$_tasksAtom.reportRead();
    return super._tasks;
  }

  @override
  set _tasks(List<Task> value) {
    _$_tasksAtom.reportWrite(value, super._tasks, () {
      super._tasks = value;
    });
  }

  final _$_ChipStoreActionController = ActionController(name: '_ChipStore');

  @override
  void addTask(Task task) {
    final _$actionInfo =
        _$_ChipStoreActionController.startAction(name: '_ChipStore.addTask');
    try {
      return super.addTask(task);
    } finally {
      _$_ChipStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsSelectedAt(int index) {
    final _$actionInfo = _$_ChipStoreActionController.startAction(
        name: '_ChipStore.toggleIsSelectedAt');
    try {
      return super.toggleIsSelectedAt(index);
    } finally {
      _$_ChipStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsSelected(Task task) {
    final _$actionInfo = _$_ChipStoreActionController.startAction(
        name: '_ChipStore.toggleIsSelected');
    try {
      return super.toggleIsSelected(task);
    } finally {
      _$_ChipStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelection() {
    final _$actionInfo = _$_ChipStoreActionController.startAction(
        name: '_ChipStore.clearSelection');
    try {
      return super.clearSelection();
    } finally {
      _$_ChipStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allTask: ${allTask}
    ''';
  }
}
