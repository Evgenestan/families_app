import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/cubits/parents/parents_state.dart';
import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/widgets/buttons.dart';
import 'package:families_app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddParentPage extends StatefulWidget {
  @override
  _AddParentPageState createState() => _AddParentPageState();
}

class _AddParentPageState extends State<AddParentPage> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  late final ParentsCubit _parentCubit;

  Future<void> _addParent() async {
    final parent = Parent(
      surname: _surnameController.text,
      name: _nameController.text,
      patronymic: _patronymicController.text,
      dob: _dobController.text,
      position: _positionController.text,
    );
    await _parentCubit.addParent(parent);
  }

  Future<void> _listener(BuildContext context, ParentsState state) async {
    if (state is ParentAddedParentState) {
      Navigator.of(context).pop();
    }
    if (state is InputErrorParentState) {
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

  @override
  void initState() {
    super.initState();
    _parentCubit = BlocProvider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Добавить родителя', style: Theme.of(context).textTheme.headline1),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text('Сведения о родителе:', style: Theme.of(context).textTheme.headline1),
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
            TextInput(
              label: 'Должность',
              controller: _positionController,
            ),
            const SizedBox(height: 16),
            BlocListener<ParentsCubit, ParentsState>(
              listener: _listener,
              child: Button(title: 'Добавить родителя', onPressed: _addParent),
            ),
          ],
        ),
      ),
    );
  }
}
