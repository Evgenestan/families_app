import 'package:families_app/models/relatives/child.dart';

abstract class ChildrenState {}

class InitialChildrenState extends ChildrenState {}

class LoadingChildrenState extends ChildrenState {}

class LoadedChildrenState extends ChildrenState {
  LoadedChildrenState(this.children);
  final List<Child> children;
}
