import 'package:families_app/models/relatives/parent.dart';

abstract class ParentsState {}

class InitialParentState extends ParentsState {}

class ParentsLoadedParentState extends ParentsState {}

class ParentAddedParentState extends ParentsState {}

class LoadingParentState extends ParentsState {}

class InputErrorParentState extends ParentsState {
  InputErrorParentState(this.error);
  String error;
}

class ParentLoadedParentState extends ParentsState {
  ParentLoadedParentState(this.parent);
  final Parent parent;
}

class ChildAddedParentState extends ParentsState {}
