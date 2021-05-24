import 'package:families_app/cubits/children/children_cubit.dart';
import 'package:families_app/cubits/children/children_state.dart';
import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/cubits/parents/parents_state.dart';
import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/widgets/buttons.dart';
import 'package:families_app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChildPage extends StatefulWidget {
  const AddChildPage({Key? key, required this.parentId}) : super(key: key);

  final String parentId;
  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  late final ParentsCubit _parentCubit;
  late final ChildrenCubit _childrenCubit;

  Future<void> _addChild() async {
    final child = Child(
      surname: _surnameController.text,
      name: _nameController.text,
      patronymic: _patronymicController.text,
      dob: _dobController.text,
    );
    await _childrenCubit.addChild(child);
  }

  Future<void> _childrenListener(BuildContext context, ChildrenState state) async {
    if (state is ChildAddedChildrenState) {
      final id = int.tryParse(widget.parentId);
      if (id != null) {
        await _parentCubit.addChildToParent(parentId: id, childId: state.id);
      }
    }
    if (state is InputErrorChildrenState) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          state.error,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _parentListener(BuildContext context, ParentsState state) async {
    if (state is ChildAddedParentState) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _parentCubit = BlocProvider.of(context, listen: false);
    _childrenCubit = BlocProvider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Добавить ребенка', style: Theme.of(context).textTheme.headline1),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text('Сведения о ребенке:', style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 16),
            TextInput(
              label: 'Фамилия',
              controller: _surnameController,
            ),
            const SizedBox(height: 16),
            TextInput(
              label: 'Имя',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            TextInput(
              label: 'Отчество',
              controller: _patronymicController,
            ),
            const SizedBox(height: 16),
            TextInput(
              label: 'Дата рождения',
              controller: _dobController,
            ),
            const SizedBox(height: 16),
            BlocListener<ChildrenCubit, ChildrenState>(
              listener: _childrenListener,
              child: BlocListener<ParentsCubit, ParentsState>(
                listener: _parentListener,
                child: Button(title: 'Добавить ребенка', onPressed: _addChild),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
